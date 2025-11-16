import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/constants.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class ApiService {
  final String baseUrl;
  String? _authToken;

  ApiService({String? baseUrl}) : baseUrl = baseUrl ?? ApiConstants.baseUrl;

  // Set authentication token
  void setAuthToken(String token) {
    _authToken = token;
  }

  // Clear authentication token
  void clearAuthToken() {
    _authToken = null;
  }

  // Get headers
  Map<String, String> _getHeaders({bool includeAuth = true}) {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (includeAuth && _authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }

    return headers;
  }

  // Handle response
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    } else {
      String errorMessage = 'Request failed';
      dynamic errorData;

      try {
        errorData = json.decode(response.body);
        errorMessage = errorData['message'] ?? errorMessage;
      } catch (e) {
        errorMessage = response.body.isNotEmpty
            ? response.body
            : 'Request failed with status ${response.statusCode}';
      }

      throw ApiException(
        message: errorMessage,
        statusCode: response.statusCode,
        data: errorData,
      );
    }
  }

  // GET request
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    bool includeAuth = true,
  }) async {
    try {
      var uri = Uri.parse('$baseUrl$endpoint');
      if (queryParams != null && queryParams.isNotEmpty) {
        uri = uri.replace(queryParameters: queryParams);
      }

      final response = await http
          .get(
            uri,
            headers: _getHeaders(includeAuth: includeAuth),
          )
          .timeout(
            const Duration(milliseconds: ApiConstants.connectionTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: $e');
    }
  }

  // POST request
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    bool includeAuth = true,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      final response = await http
          .post(
            uri,
            headers: _getHeaders(includeAuth: includeAuth),
            body: body != null ? json.encode(body) : null,
          )
          .timeout(
            const Duration(milliseconds: ApiConstants.connectionTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: $e');
    }
  }

  // PUT request
  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    bool includeAuth = true,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      final response = await http
          .put(
            uri,
            headers: _getHeaders(includeAuth: includeAuth),
            body: body != null ? json.encode(body) : null,
          )
          .timeout(
            const Duration(milliseconds: ApiConstants.connectionTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: $e');
    }
  }

  // DELETE request
  Future<dynamic> delete(
    String endpoint, {
    bool includeAuth = true,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      final response = await http
          .delete(
            uri,
            headers: _getHeaders(includeAuth: includeAuth),
          )
          .timeout(
            const Duration(milliseconds: ApiConstants.connectionTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: $e');
    }
  }

  // PATCH request
  Future<dynamic> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    bool includeAuth = true,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');

      final response = await http
          .patch(
            uri,
            headers: _getHeaders(includeAuth: includeAuth),
            body: body != null ? json.encode(body) : null,
          )
          .timeout(
            const Duration(milliseconds: ApiConstants.connectionTimeout),
          );

      return _handleResponse(response);
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: $e');
    }
  }
}

// Singleton instance
final apiService = ApiService();
