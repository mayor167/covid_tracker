import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../features/covid_dashboard/models/global_stats_model.dart';
import '../../features/covid_dashboard/models/historical_model.dart';
import '../../core/exceptions/covid_exception.dart';

/// Data source that talks to the disease.sh REST API.
///
/// All network logic lives here — the rest of the app never sees raw HTTP.
/// We accept an optional [http.Client] in the constructor so unit tests can
/// inject a mock client without touching the network.
///
/// Every failure is translated into a typed [CovidException] subtype at this
/// boundary. The controller never has to parse error strings — it just catches
/// the sealed type and hands it to [ErrorHandler] for a user-friendly message.
class CovidRepository {
  static const _base = 'https://disease.sh/v3/covid-19';
  static const _timeout = Duration(seconds: 15);

  final http.Client _client;

  CovidRepository({http.Client? client}) : _client = client ?? http.Client();

  /// Fetches the latest worldwide totals (cases, active, recovered, deaths).
  ///
  /// Endpoint: GET /v3/covid-19/all
  Future<GlobalStatsModel> fetchGlobalStats() async {
    await _ensureConnectivity();
    final body = await _get('$_base/all');
    return GlobalStatsModel.fromJson(body);
  }

  /// Fetches 8 days of cumulative case data so we can derive 7 daily deltas.
  ///
  /// Endpoint: GET /v3/covid-19/historical/all?lastdays=8
  /// We ask for 8 days because differencing N cumulative values gives N-1 deltas.
  Future<HistoricalModel> fetchHistorical() async {
    await _ensureConnectivity();
    final body = await _get('$_base/historical/all?lastdays=8');
    return HistoricalModel.fromJson(body);
  }

  // ─────────────────────────────────────────────
  // Private helpers
  // ─────────────────────────────────────────────

  /// Quick connectivity pre-check using a DNS lookup.
  ///
  /// This fails fast when the device is completely offline, rather than making
  /// the user wait for the HTTP timeout. If the lookup fails because the host
  /// can't be resolved, we throw [NetworkUnavailableException] immediately.
  Future<void> _ensureConnectivity() async {
    try {
      await InternetAddress.lookup('disease.sh')
          .timeout(const Duration(seconds: 5));
    } on SocketException {
      throw const NetworkUnavailableException();
    } on TimeoutException {
      throw const NetworkUnavailableException();
    }
  }

  /// Executes a GET request and returns the decoded JSON body.
  ///
  /// Handles every failure mode and maps it to the correct [CovidException]:
  ///   - Timeout        -> [NetworkTimeoutException]
  ///   - DNS failure    -> [DnsException]
  ///   - Socket errors  -> [ConnectionException] or [NetworkUnavailableException]
  ///   - TLS/SSL errors -> [ConnectionException]
  ///   - HTTP 503       -> [ServiceUnavailableException]
  ///   - HTTP 4xx/5xx   -> [ServerException]
  ///   - Bad JSON       -> [ParseException]
  ///   - Anything else  -> [UnknownException]
  Future<Map<String, dynamic>> _get(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await _client.get(uri).timeout(_timeout);

      // Map HTTP status codes to the right exception
      if (response.statusCode == 503) {
        throw const ServiceUnavailableException();
      }
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ServerException('HTTP ${response.statusCode}');
      }

      // Attempt to parse the response body
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is! Map<String, dynamic>) {
          throw const ParseException();
        }
        return decoded;
      } on FormatException {
        throw const ParseException();
      }
    } on CovidException {
      // Already a typed exception from the status-code checks above — rethrow
      rethrow;
    } on TimeoutException {
      throw const NetworkTimeoutException();
    } on SocketException catch (e) {
      // Distinguish DNS failures from general connection issues
      if (e.message.contains('No address associated') ||
          e.message.contains('Failed host lookup')) {
        throw const DnsException();
      }
      if (e.message.contains('No route to host') ||
          e.message.contains('Network is unreachable')) {
        throw const NetworkUnavailableException();
      }
      throw const ConnectionException();
    } on HandshakeException {
      throw const ConnectionException();
    } on TlsException {
      throw const ConnectionException();
    } catch (_) {
      throw const UnknownException();
    }
  }
}
