/// Sealed exception hierarchy for the COVID-19 Tracker feature.
///
/// Every error that can occur during data fetching is represented as a concrete
/// subtype of [CovidException]. This lets the controller match exhaustively on
/// the type and keeps raw platform errors out of the UI layer entirely.
///
/// Each subtype corresponds to a specific failure category — from no internet
/// to malformed JSON — so the error handler can map them to distinct,
/// human-friendly messages without inspecting exception strings.
sealed class CovidException implements Exception {
  final String? message;
  const CovidException([this.message]);

  @override
  String toString() => message ?? runtimeType.toString();
}

/// The device has no active internet connection (WiFi/mobile data off).
class NetworkUnavailableException extends CovidException {
  const NetworkUnavailableException([super.message]);
}

/// An HTTP request exceeded the configured timeout threshold.
class NetworkTimeoutException extends CovidException {
  const NetworkTimeoutException([super.message]);
}

/// The API returned a 4xx or 5xx HTTP status code.
class ServerException extends CovidException {
  const ServerException([super.message]);
}

/// The API returned a 503 or the service is completely unreachable.
class ServiceUnavailableException extends CovidException {
  const ServiceUnavailableException([super.message]);
}

/// The response body was empty, malformed, or failed JSON decoding.
class ParseException extends CovidException {
  const ParseException([super.message]);
}

/// DNS resolution failed — the hostname could not be found.
class DnsException extends CovidException {
  const DnsException([super.message]);
}

/// The connection was refused, reset, or aborted mid-flight.
class ConnectionException extends CovidException {
  const ConnectionException([super.message]);
}

/// A catch-all for any exception or error that doesn't match the above.
class UnknownException extends CovidException {
  const UnknownException([super.message]);
}
