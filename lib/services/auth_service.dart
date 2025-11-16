import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';
import '../models/user_model.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = apiService;
  User? _currentUser;

  User? get currentUser => _currentUser;

  // Login
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConstants.login,
        body: {
          'email': email,
          'password': password,
        },
        includeAuth: false,
      );

      // Save token
      final token = response['token'] as String;
      await _saveToken(token);
      _apiService.setAuthToken(token);

      // Save refresh token if available
      if (response['refresh_token'] != null) {
        await _saveRefreshToken(response['refresh_token'] as String);
      }

      // Parse and save user data
      _currentUser = User.fromJson(response['user']);
      await _saveUserData(_currentUser!);

      return _currentUser!;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Register
  Future<User> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _apiService.post(
        ApiConstants.register,
        body: {
          'email': email,
          'password': password,
          'name': name,
        },
        includeAuth: false,
      );

      // Save token
      final token = response['token'] as String;
      await _saveToken(token);
      _apiService.setAuthToken(token);

      // Parse and save user data
      _currentUser = User.fromJson(response['user']);
      await _saveUserData(_currentUser!);

      return _currentUser!;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _apiService.post(ApiConstants.logout);
    } catch (e) {
      // Continue with local logout even if API fails
    } finally {
      await _clearAuthData();
      _apiService.clearAuthToken();
      _currentUser = null;
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await _getToken();
    return token != null;
  }

  // Get stored token
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.keyToken);
  }

  // Save token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyToken, token);
  }

  // Save refresh token
  Future<void> _saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyRefreshToken, token);
  }

  // Save user data
  Future<void> _saveUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyUserData, user.toJson().toString());
    await prefs.setString(AppConstants.keyUserId, user.id);
  }

  // Clear all auth data
  Future<void> _clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.keyToken);
    await prefs.remove(AppConstants.keyRefreshToken);
    await prefs.remove(AppConstants.keyUserData);
    await prefs.remove(AppConstants.keyUserId);
  }

  // Load user from storage
  Future<User?> loadUserFromStorage() async {
    final token = await _getToken();
    if (token == null) return null;

    _apiService.setAuthToken(token);

    try {
      // Try to get fresh user data from API
      final response = await _apiService.get(ApiConstants.userProfile);
      _currentUser = User.fromJson(response);
      await _saveUserData(_currentUser!);
      return _currentUser;
    } catch (e) {
      // If API fails, try to load from local storage
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString(AppConstants.keyUserData);
      if (userData != null) {
        // Note: You might need to implement a proper JSON parse here
        // This is simplified
        return null;
      }
      return null;
    }
  }

  // Refresh token
  Future<void> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString(AppConstants.keyRefreshToken);

    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    try {
      final response = await _apiService.post(
        ApiConstants.refreshToken,
        body: {'refresh_token': refreshToken},
        includeAuth: false,
      );

      final newToken = response['token'] as String;
      await _saveToken(newToken);
      _apiService.setAuthToken(newToken);
    } catch (e) {
      throw Exception('Token refresh failed: $e');
    }
  }

  // Mock login for demo (ใช้ก่อนจะมี API จริง)
  Future<User> mockLogin({
    required String email,
    required String password,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));

    if (email == 'demo@jess.com' && password == '123456') {
      _currentUser = User(
        id: 'demo-user-1',
        email: email,
        name: 'John Doe',
        avatarUrl: 'https://via.placeholder.com/150',
        dateOfBirth: DateTime(1990, 1, 1),
        weight: 75.0,
        height: 175.0,
        gender: 'male',
        createdAt: DateTime.now(),
      );

      // Save mock token
      await _saveToken('mock-token-12345');
      _apiService.setAuthToken('mock-token-12345');
      await _saveUserData(_currentUser!);

      return _currentUser!;
    } else {
      throw Exception('Invalid email or password');
    }
  }
}

// Singleton instance
final authService = AuthService();
