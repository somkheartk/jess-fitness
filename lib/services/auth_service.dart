import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  static const String _tokenKey = 'auth_token';
  static const String _userIdKey = 'user_id';

  // Login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _apiService.post(
        '${ApiConfig.authEndpoint}/login',
        {
          'email': email,
          'password': password,
        },
        includeAuth: false,
      );

      if (response['token'] != null) {
        await _saveToken(response['token']);
        _apiService.setAuthToken(response['token']);
        
        if (response['userId'] != null) {
          await _saveUserId(response['userId']);
        }
      }

      return response;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Register
  Future<Map<String, dynamic>> register(
    String email,
    String password,
    String name,
  ) async {
    try {
      final response = await _apiService.post(
        '${ApiConfig.authEndpoint}/register',
        {
          'email': email,
          'password': password,
          'name': name,
        },
        includeAuth: false,
      );

      if (response['token'] != null) {
        await _saveToken(response['token']);
        _apiService.setAuthToken(response['token']);
        
        if (response['userId'] != null) {
          await _saveUserId(response['userId']);
        }
      }

      return response;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _clearToken();
      await _clearUserId();
      _apiService.clearAuthToken();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final token = await getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Get stored token
  Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      return null;
    }
  }

  // Get stored user ID
  Future<String?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userIdKey);
    } catch (e) {
      return null;
    }
  }

  // Initialize auth service with stored token
  Future<void> initialize() async {
    try {
      final token = await getToken();
      if (token != null && token.isNotEmpty) {
        _apiService.setAuthToken(token);
      }
    } catch (e) {
      // Ignore initialization errors
    }
  }

  // Private: Save token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  // Private: Save user ID
  Future<void> _saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  // Private: Clear token
  Future<void> _clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  // Private: Clear user ID
  Future<void> _clearUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
  }
}
