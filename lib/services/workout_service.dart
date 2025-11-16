import '../config/constants.dart';
import '../models/workout_model.dart';
import 'api_service.dart';

class WorkoutService {
  final ApiService _apiService = apiService;

  // Get all workouts
  Future<List<Workout>> getWorkouts({
    String? category,
    String? difficulty,
    bool? completed,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (category != null) queryParams['category'] = category;
      if (difficulty != null) queryParams['difficulty'] = difficulty;
      if (completed != null) queryParams['completed'] = completed.toString();

      final response = await _apiService.get(
        ApiConstants.workouts,
        queryParams: queryParams,
      );

      return (response as List).map((json) => Workout.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load workouts: $e');
    }
  }

  // Get workout by ID
  Future<Workout> getWorkoutById(String id) async {
    try {
      final response = await _apiService.get(
        ApiConstants.workoutDetail.replaceAll(':id', id),
      );

      return Workout.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load workout: $e');
    }
  }

  // Create workout
  Future<Workout> createWorkout(Workout workout) async {
    try {
      final response = await _apiService.post(
        ApiConstants.createWorkout,
        body: workout.toJson(),
      );

      return Workout.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create workout: $e');
    }
  }

  // Update workout
  Future<Workout> updateWorkout(String id, Workout workout) async {
    try {
      final response = await _apiService.put(
        ApiConstants.updateWorkout.replaceAll(':id', id),
        body: workout.toJson(),
      );

      return Workout.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update workout: $e');
    }
  }

  // Delete workout
  Future<void> deleteWorkout(String id) async {
    try {
      await _apiService.delete(
        ApiConstants.deleteWorkout.replaceAll(':id', id),
      );
    } catch (e) {
      throw Exception('Failed to delete workout: $e');
    }
  }

  // Complete workout
  Future<Workout> completeWorkout(String id) async {
    try {
      final response = await _apiService.post(
        ApiConstants.completeWorkout.replaceAll(':id', id),
      );

      return Workout.fromJson(response);
    } catch (e) {
      throw Exception('Failed to complete workout: $e');
    }
  }

  // Get exercises
  Future<List<Exercise>> getExercises({
    String? muscleGroup,
    String? equipment,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (muscleGroup != null) queryParams['muscle_group'] = muscleGroup;
      if (equipment != null) queryParams['equipment'] = equipment;

      final response = await _apiService.get(
        ApiConstants.exercises,
        queryParams: queryParams,
      );

      return (response as List).map((json) => Exercise.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load exercises: $e');
    }
  }

  // Mock data (ใช้ก่อนจะมี API จริง)
  Future<List<Workout>> getMockWorkouts() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      Workout(
        id: '1',
        userId: 'demo-user-1',
        name: 'Full Body Workout',
        description: 'Complete full body strength training',
        durationMinutes: 30,
        caloriesBurned: 250,
        category: 'Full Body',
        difficulty: 'Intermediate',
        exercises: getMockExercises(),
        scheduledDate: DateTime.now(),
        isCompleted: false,
        createdAt: DateTime.now(),
      ),
      Workout(
        id: '2',
        userId: 'demo-user-1',
        name: 'Morning Cardio',
        description: 'High intensity cardio session',
        durationMinutes: 20,
        caloriesBurned: 200,
        category: 'Cardio',
        difficulty: 'Beginner',
        exercises: [],
        scheduledDate: DateTime.now(),
        isCompleted: true,
        completedAt: DateTime.now(),
        createdAt: DateTime.now(),
      ),
    ];
  }

  List<Exercise> getMockExercises() {
    return [
      Exercise(
        id: '1',
        name: 'Overhead Press',
        description: 'Shoulder press with dumbbells',
        reps: 16,
        sets: 3,
        durationSeconds: null,
        muscleGroup: 'Shoulders',
        equipment: 'Dumbbells',
        order: 1,
      ),
      Exercise(
        id: '2',
        name: 'Dumbbell Lunges',
        description: 'Alternating leg lunges',
        reps: 16,
        sets: 3,
        durationSeconds: null,
        muscleGroup: 'Legs',
        equipment: 'Dumbbells',
        order: 2,
      ),
      Exercise(
        id: '3',
        name: 'Incline Bench Press',
        description: 'Upper chest press',
        reps: 16,
        sets: 3,
        durationSeconds: null,
        muscleGroup: 'Chest',
        equipment: 'Barbell',
        order: 3,
      ),
      Exercise(
        id: '4',
        name: 'Leg Balance Lunges',
        description: 'Single leg balance exercise',
        reps: 16,
        sets: 3,
        durationSeconds: null,
        muscleGroup: 'Legs',
        equipment: 'None',
        order: 4,
      ),
    ];
  }
}

// Singleton instance
final workoutService = WorkoutService();
