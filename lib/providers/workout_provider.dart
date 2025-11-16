import 'package:flutter/foundation.dart';
import '../models/workout_model.dart';
import '../services/workout_service.dart';

class WorkoutProvider with ChangeNotifier {
  final WorkoutService _workoutService = workoutService;

  List<Workout> _workouts = [];
  Workout? _selectedWorkout;
  List<Exercise> _exercises = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Workout> get workouts => _workouts;
  Workout? get selectedWorkout => _selectedWorkout;
  List<Exercise> get exercises => _exercises;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Get filtered workouts
  List<Workout> getWorkoutsByCategory(String category) {
    return _workouts.where((w) => w.category == category).toList();
  }

  List<Workout> getCompletedWorkouts() {
    return _workouts.where((w) => w.isCompleted).toList();
  }

  List<Workout> getScheduledWorkouts() {
    return _workouts
        .where((w) => !w.isCompleted && w.scheduledDate != null)
        .toList();
  }

  // Load workouts
  Future<void> loadWorkouts({
    String? category,
    String? difficulty,
    bool? completed,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Use mock data for demo
      _workouts = await _workoutService.getMockWorkouts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load workout by ID
  Future<void> loadWorkoutById(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _selectedWorkout = await _workoutService.getWorkoutById(id);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Set selected workout
  void selectWorkout(Workout workout) {
    _selectedWorkout = workout;
    notifyListeners();
  }

  // Create workout
  Future<bool> createWorkout(Workout workout) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newWorkout = await _workoutService.createWorkout(workout);
      _workouts.add(newWorkout);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update workout
  Future<bool> updateWorkout(String id, Workout workout) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedWorkout = await _workoutService.updateWorkout(id, workout);
      final index = _workouts.indexWhere((w) => w.id == id);
      if (index != -1) {
        _workouts[index] = updatedWorkout;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Complete workout
  Future<bool> completeWorkout(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final completedWorkout = await _workoutService.completeWorkout(id);
      final index = _workouts.indexWhere((w) => w.id == id);
      if (index != -1) {
        _workouts[index] = completedWorkout;
      }
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Delete workout
  Future<bool> deleteWorkout(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _workoutService.deleteWorkout(id);
      _workouts.removeWhere((w) => w.id == id);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Load exercises
  Future<void> loadExercises({
    String? muscleGroup,
    String? equipment,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _exercises = await _workoutService.getExercises(
        muscleGroup: muscleGroup,
        equipment: equipment,
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
