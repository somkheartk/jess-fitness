import '../models/exercise.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class ExerciseService {
  final ApiService _apiService = ApiService();

  // Get all exercises
  Future<List<Exercise>> getExercises({
    String? category,
    String? difficulty,
    String? search,
  }) async {
    try {
      String endpoint = ApiConfig.exercisesEndpoint;
      final queryParams = <String>[];

      if (category != null) queryParams.add('category=$category');
      if (difficulty != null) queryParams.add('difficulty=$difficulty');
      if (search != null) queryParams.add('search=$search');

      if (queryParams.isNotEmpty) {
        endpoint += '?${queryParams.join('&')}';
      }

      final response = await _apiService.get(endpoint);
      
      final List<dynamic> exercisesJson = response['data'] ?? response['exercises'] ?? [];
      return exercisesJson.map((json) => Exercise.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get exercises: $e');
    }
  }

  // Get exercise by ID
  Future<Exercise> getExerciseById(String exerciseId) async {
    try {
      final response = await _apiService.get(
        '${ApiConfig.exercisesEndpoint}/$exerciseId',
      );

      return Exercise.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get exercise: $e');
    }
  }

  // Create exercise
  Future<Exercise> createExercise(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.post(
        ApiConfig.exercisesEndpoint,
        data,
      );

      return Exercise.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create exercise: $e');
    }
  }

  // Update exercise
  Future<Exercise> updateExercise(
    String exerciseId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.put(
        '${ApiConfig.exercisesEndpoint}/$exerciseId',
        data,
      );

      return Exercise.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update exercise: $e');
    }
  }

  // Delete exercise
  Future<void> deleteExercise(String exerciseId) async {
    try {
      await _apiService.delete(
        '${ApiConfig.exercisesEndpoint}/$exerciseId',
      );
    } catch (e) {
      throw Exception('Failed to delete exercise: $e');
    }
  }
}
