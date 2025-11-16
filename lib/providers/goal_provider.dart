import 'package:flutter/foundation.dart';
import '../models/goal_model.dart';
import '../services/goal_service.dart';

class GoalProvider with ChangeNotifier {
  final GoalService _goalService = goalService;

  List<Goal> _goals = [];
  List<Goal> _todayGoals = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Goal> get goals => _goals;
  List<Goal> get todayGoals => _todayGoals;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Get filtered goals
  List<Goal> getActiveGoals() {
    return _goals.where((g) => g.isActive).toList();
  }

  List<Goal> getCompletedGoals() {
    return _goals.where((g) => g.isCompleted).toList();
  }

  List<Goal> getGoalsByType(String type) {
    return _goals.where((g) => g.type == type).toList();
  }

  // Load all goals
  Future<void> loadGoals({
    String? type,
    bool? isCompleted,
    bool? isActive,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Use mock data for demo
      _goals = await _goalService.getMockGoals();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load today's goals
  Future<void> loadTodayGoals() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Use mock data for demo
      final allGoals = await _goalService.getMockGoals();
      _todayGoals = allGoals.where((g) => g.type == 'daily').toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create goal
  Future<bool> createGoal(Goal goal) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final newGoal = await _goalService.createGoal(goal);
      _goals.add(newGoal);

      if (newGoal.type == 'daily') {
        _todayGoals.add(newGoal);
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

  // Update goal
  Future<bool> updateGoal(String id, Goal goal) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedGoal = await _goalService.updateGoal(id, goal);

      final index = _goals.indexWhere((g) => g.id == id);
      if (index != -1) {
        _goals[index] = updatedGoal;
      }

      final todayIndex = _todayGoals.indexWhere((g) => g.id == id);
      if (todayIndex != -1) {
        _todayGoals[todayIndex] = updatedGoal;
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

  // Update goal progress
  Future<bool> updateGoalProgress(String id, double newValue) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedGoal = await _goalService.updateGoalProgress(id, newValue);

      final index = _goals.indexWhere((g) => g.id == id);
      if (index != -1) {
        _goals[index] = updatedGoal;
      }

      final todayIndex = _todayGoals.indexWhere((g) => g.id == id);
      if (todayIndex != -1) {
        _todayGoals[todayIndex] = updatedGoal;
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

  // Complete goal
  Future<bool> completeGoal(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final completedGoal = await _goalService.completeGoal(id);

      final index = _goals.indexWhere((g) => g.id == id);
      if (index != -1) {
        _goals[index] = completedGoal;
      }

      final todayIndex = _todayGoals.indexWhere((g) => g.id == id);
      if (todayIndex != -1) {
        _todayGoals[todayIndex] = completedGoal;
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

  // Delete goal
  Future<bool> deleteGoal(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _goalService.deleteGoal(id);
      _goals.removeWhere((g) => g.id == id);
      _todayGoals.removeWhere((g) => g.id == id);

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

  // Get statistics
  Map<String, dynamic> getStatistics() {
    final total = _goals.length;
    final completed = _goals.where((g) => g.isCompleted).length;
    final active = _goals.where((g) => g.isActive).length;
    final expired = _goals.where((g) => g.isExpired).length;

    double avgProgress = 0;
    if (_goals.isNotEmpty) {
      avgProgress = _goals.fold<double>(
            0,
            (sum, goal) => sum + goal.progressPercentage,
          ) /
          _goals.length;
    }

    return {
      'total': total,
      'completed': completed,
      'active': active,
      'expired': expired,
      'avgProgress': avgProgress,
      'completionRate': total > 0 ? (completed / total) * 100 : 0,
    };
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
