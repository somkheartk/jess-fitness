import '../models/workout.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class WorkoutService {
  final ApiService _apiService = ApiService();

  // Get all workouts
  Future<List<Workout>> getWorkouts({String? category}) async {
    try {
      final endpoint = category != null
          ? '${ApiConfig.workoutsEndpoint}?category=$category'
          : ApiConfig.workoutsEndpoint;

      final response = await _apiService.get(endpoint);
      
      final List<dynamic> workoutsJson = response['data'] ?? response['workouts'] ?? [];
      return workoutsJson.map((json) => Workout.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to get workouts: $e');
    }
  }

  // Get workout by ID
  Future<Workout> getWorkoutById(String workoutId) async {
    try {
      final response = await _apiService.get(
        '${ApiConfig.workoutsEndpoint}/$workoutId',
      );

      return Workout.fromJson(response);
    } catch (e) {
      throw Exception('Failed to get workout: $e');
    }
  }

  // Create workout
  Future<Workout> createWorkout(Map<String, dynamic> data) async {
    try {
      final response = await _apiService.post(
        ApiConfig.workoutsEndpoint,
        data,
      );

      return Workout.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create workout: $e');
    }
  }

  // Update workout
  Future<Workout> updateWorkout(
    String workoutId,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await _apiService.put(
        '${ApiConfig.workoutsEndpoint}/$workoutId',
        data,
      );

      return Workout.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update workout: $e');
    }
  }

  // Mark workout as completed
  Future<Workout> completeWorkout(String workoutId) async {
    try {
      final response = await _apiService.put(
        '${ApiConfig.workoutsEndpoint}/$workoutId/complete',
        {},
      );

      return Workout.fromJson(response);
    } catch (e) {
      throw Exception('Failed to complete workout: $e');
    }
  }

  // Delete workout
  Future<void> deleteWorkout(String workoutId) async {
    try {
      await _apiService.delete(
        '${ApiConfig.workoutsEndpoint}/$workoutId',
      );
    } catch (e) {
      throw Exception('Failed to delete workout: $e');
    }
  }
}
