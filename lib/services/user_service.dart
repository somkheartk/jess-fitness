import '../models/user.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class UserService {
  final ApiService _apiService = ApiService();

  // Get user profile
  Future<User> getUserProfile(String userId) async {
    try {
      final response = await _apiService.get(
        '${ApiConfig.usersEndpoint}/$userId',
      );

      return User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  // Update user profile
  Future<User> updateUserProfile(
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.put(
        '${ApiConfig.usersEndpoint}/$userId',
        data,
      );

      return User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  // Get user statistics
  Future<Map<String, dynamic>> getUserStats(String userId) async {
    try {
      final response = await _apiService.get(
        '${ApiConfig.usersEndpoint}/$userId/stats',
      );

      return response;
    } catch (e) {
      throw Exception('Failed to get user stats: $e');
    }
  }
}
