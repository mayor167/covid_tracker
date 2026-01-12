import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_app_boilerplate/utils/constants/app_constants.dart';

class RHttpHelper {
  static const String _baseUrl = RAppConstants.backendUrl;
  static const String _postPath = RAppConstants.publicPostUrl;
  static const String _getPath = RAppConstants.publicGetUrl;
  static const String _secretKey = RAppConstants.secretKey;

  /// Helper method to make a POST request
  static Future<Map<String, dynamic>> post(
    String endpoint,
    dynamic data,
  ) async {
    final Map<String, dynamic> details = {'path': endpoint, 'data': data};

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/$_postPath'),
        headers: {'Content-Type': 'application/json', 'secret-key': _secretKey},
        body: json.encode(details),
      );

      return _handleResponse(response);
    } on http.ClientException catch (e) {
      throw Exception(
        'Failed to connect to the server. Please check your internet connection. $e',
      );
    } catch (e) {
      throw Exception('POST request failed: $e');
    }
  }

  /// Helper method to make a GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$_getPath'),
        headers: {'Content-Type': 'application/json', 'secret-key': _secretKey},
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('GET request failed: $e');
    }
  }

  /// Helper method to make a PUT request
  static Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json', 'secret-key': _secretKey},
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('PUT request failed: $e');
    }
  }

  /// Helper method to make a DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json', 'secret-key': _secretKey},
      );
      return _handleResponse(response);
    } catch (e) {
      throw Exception('DELETE request failed: $e');
    }
  }

  /// Handles HTTP responses
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Request failed\nStatus: $statusCode\nBody: ${response.body}',
      );
    }
  }
}
