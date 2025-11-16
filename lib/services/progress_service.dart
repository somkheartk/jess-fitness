import '../config/constants.dart';
import '../models/progress_model.dart';
import 'api_service.dart';

class ProgressService {
  final ApiService _apiService = apiService;

  // Get all progress records
  Future<List<Progress>> getProgress({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (startDate != null) {
        queryParams['start_date'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['end_date'] = endDate.toIso8601String();
      }

      final response = await _apiService.get(
        ApiConstants.progress,
        queryParams: queryParams,
      );

      return (response as List).map((json) => Progress.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load progress: $e');
    }
  }

  // Get progress by date
  Future<Progress?> getProgressByDate(DateTime date) async {
    try {
      final dateStr = date.toIso8601String().split('T')[0];
      final response = await _apiService.get(
        ApiConstants.progressByDate.replaceAll(':date', dateStr),
      );

      if (response == null) return null;
      return Progress.fromJson(response);
    } catch (e) {
      throw Exception('Failed to load progress: $e');
    }
  }

  // Get weekly progress
  Future<WeeklyProgress> getWeeklyProgress() async {
    try {
      final response = await _apiService.get(
        ApiConstants.weeklyProgress,
      );

      final progressList = (response['daily_progress'] as List)
          .map((json) => Progress.fromJson(json))
          .toList();

      return WeeklyProgress.fromProgressList(progressList);
    } catch (e) {
      throw Exception('Failed to load weekly progress: $e');
    }
  }

  // Get monthly progress
  Future<List<Progress>> getMonthlyProgress(DateTime month) async {
    try {
      final queryParams = {
        'year': month.year.toString(),
        'month': month.month.toString(),
      };

      final response = await _apiService.get(
        ApiConstants.monthlyProgress,
        queryParams: queryParams,
      );

      return (response as List).map((json) => Progress.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load monthly progress: $e');
    }
  }

  // Create or update progress
  Future<Progress> saveProgress(Progress progress) async {
    try {
      final response = await _apiService.post(
        ApiConstants.progress,
        body: progress.toJson(),
      );

      return Progress.fromJson(response);
    } catch (e) {
      throw Exception('Failed to save progress: $e');
    }
  }

  // Update specific fields
  Future<Progress> updateProgress(
    String id,
    Map<String, dynamic> updates,
  ) async {
    try {
      final response = await _apiService.patch(
        '${ApiConstants.progress}/$id',
        body: updates,
      );

      return Progress.fromJson(response);
    } catch (e) {
      throw Exception('Failed to update progress: $e');
    }
  }

  // Mock data (ใช้ก่อนจะมี API จริง)
  Future<WeeklyProgress> getMockWeeklyProgress() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();
    final progressList = <Progress>[];

    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      progressList.add(
        Progress(
          id: 'progress-$i',
          userId: 'demo-user-1',
          date: date,
          weight: 75.0 + (i * 0.1),
          steps: 5000 + (i * 500),
          caloriesBurned: 200 + (i * 50).toDouble(),
          waterIntake: 2000 + (i * 100),
          sleepHours: 7.0 + (i * 0.2),
          workoutsCompleted: i % 2,
          createdAt: date,
        ),
      );
    }

    return WeeklyProgress.fromProgressList(progressList);
  }

  Future<List<Progress>> getMockMonthlyProgress() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();
    final progressList = <Progress>[];

    for (int i = 29; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      progressList.add(
        Progress(
          id: 'progress-$i',
          userId: 'demo-user-1',
          date: date,
          weight: 75.0 - (i * 0.05),
          steps: 4000 + (i * 200),
          caloriesBurned: 180 + (i * 20).toDouble(),
          waterIntake: 1800 + (i * 50),
          sleepHours: 6.5 + (i * 0.05),
          workoutsCompleted: i % 3 == 0 ? 1 : 0,
          createdAt: date,
        ),
      );
    }

    return progressList;
  }
}

// Singleton instance
final progressService = ProgressService();
