import '../config/constants.dart';
import '../models/goal_model.dart';
import 'api_service.dart';

class GoalService {
  final ApiService _apiService = apiService;

  // Get all goals
  Future<List<Goal>> getGoals({
    String? type,
    bool? isCompleted,
    bool? isActive,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (type != null) queryParams['type'] = type;
      if (isCompleted != null) {
        queryParams['is_completed'] = isCompleted.toString();
      }
      if (isActive != null) queryParams['is_active'] = isActive.toString();

      final response = await _apiService.get(
        ApiConstants.goals,
        queryParams: queryParams,
      );

      return (response as List).map((json) => Goal.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load goals: $e');
    }
  }

  // Get goal by ID
  Future<Goal> getGoalById(String id) async {
    try {
      final response = await _apiService.get(
        ApiConstants.goalDetail.replaceAll(':id', id),
      );

      return Goal.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load goal: $e');
    }
  }

  // Create goal
  Future<Goal> createGoal(Goal goal) async {
    try {
      final response = await _apiService.post(
        ApiConstants.createGoal,
        body: goal.toJson(),
      );

      return Goal.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create goal: $e');
    }
  }

  // Update goal
  Future<Goal> updateGoal(String id, Goal goal) async {
    try {
      final response = await _apiService.put(
        ApiConstants.updateGoal.replaceAll(':id', id),
        body: goal.toJson(),
      );

      return Goal.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update goal: $e');
    }
  }

  // Update goal progress
  Future<Goal> updateGoalProgress(String id, double newValue) async {
    try {
      final response = await _apiService.patch(
        ApiConstants.updateGoal.replaceAll(':id', id),
        body: {'current_value': newValue},
      );

      return Goal.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update goal progress: $e');
    }
  }

  // Delete goal
  Future<void> deleteGoal(String id) async {
    try {
      await _apiService.delete(
        ApiConstants.deleteGoal.replaceAll(':id', id),
      );
    } catch (e) {
      throw Exception('Failed to delete goal: $e');
    }
  }

  // Complete goal
  Future<Goal> completeGoal(String id) async {
    try {
      final response = await _apiService.post(
        ApiConstants.completeGoal.replaceAll(':id', id),
      );

      return Goal.fromJson(response);
    } catch (e) {
      throw Exception('Failed to complete goal: $e');
    }
  }

  // Get active goals
  Future<List<Goal>> getActiveGoals() async {
    return getGoals(isActive: true, isCompleted: false);
  }

  // Get today's goals
  Future<List<Goal>> getTodayGoals() async {
    return getGoals(type: 'daily', isCompleted: false);
  }

  // Mock data (ใช้ก่อนจะมี API จริง)
  Future<List<Goal>> getMockGoals() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return [
      Goal(
        id: '1',
        userId: 'demo-user-1',
        name: 'Running',
        description: 'Morning run in the park',
        type: 'daily',
        targetValue: 30,
        currentValue: 22,
        unit: 'minutes',
        startDate: today,
        endDate: today,
        isCompleted: false,
        createdAt: today,
      ),
      Goal(
        id: '2',
        userId: 'demo-user-1',
        name: 'Cycling',
        description: 'Evening cycling session',
        type: 'daily',
        targetValue: 40,
        currentValue: 15,
        unit: 'minutes',
        startDate: today,
        endDate: today,
        isCompleted: false,
        createdAt: today,
      ),
      Goal(
        id: '3',
        userId: 'demo-user-1',
        name: 'Water Intake',
        description: 'Drink 2 liters of water',
        type: 'daily',
        targetValue: 2000,
        currentValue: 1200,
        unit: 'ml',
        startDate: today,
        endDate: today,
        isCompleted: false,
        createdAt: today,
      ),
      Goal(
        id: '4',
        userId: 'demo-user-1',
        name: 'Weekly Workouts',
        description: 'Complete 5 workouts this week',
        type: 'weekly',
        targetValue: 5,
        currentValue: 3,
        unit: 'workouts',
        startDate: today.subtract(Duration(days: today.weekday - 1)),
        endDate: today.add(Duration(days: 7 - today.weekday)),
        isCompleted: false,
        createdAt: today,
      ),
      Goal(
        id: '5',
        userId: 'demo-user-1',
        name: 'Weight Loss',
        description: 'Lose 2kg this month',
        type: 'monthly',
        targetValue: 2,
        currentValue: 0.8,
        unit: 'kg',
        startDate: DateTime(now.year, now.month, 1),
        endDate: DateTime(now.year, now.month + 1, 0),
        isCompleted: false,
        createdAt: today,
      ),
    ];
  }
}

// Singleton instance
final goalService = GoalService();
