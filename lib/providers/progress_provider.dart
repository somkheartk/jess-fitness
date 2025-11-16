import 'package:flutter/foundation.dart';
import '../models/progress_model.dart';
import '../services/progress_service.dart';

class ProgressProvider with ChangeNotifier {
  final ProgressService _progressService = progressService;

  List<Progress> _progressList = [];
  WeeklyProgress? _weeklyProgress;
  Progress? _todayProgress;
  bool _isLoading = false;
  String? _errorMessage;

  List<Progress> get progressList => _progressList;
  WeeklyProgress? get weeklyProgress => _weeklyProgress;
  Progress? get todayProgress => _todayProgress;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Load progress data
  Future<void> loadProgress({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _progressList = await _progressService.getProgress(
        startDate: startDate,
        endDate: endDate,
      );
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load weekly progress
  Future<void> loadWeeklyProgress() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Use mock data for demo
      _weeklyProgress = await _progressService.getMockWeeklyProgress();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load monthly progress
  Future<void> loadMonthlyProgress(DateTime month) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _progressList = await _progressService.getMockMonthlyProgress();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Load today's progress
  Future<void> loadTodayProgress() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _todayProgress = await _progressService.getProgressByDate(DateTime.now());
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Save progress
  Future<bool> saveProgress(Progress progress) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final savedProgress = await _progressService.saveProgress(progress);

      // Update the list
      final index = _progressList.indexWhere(
        (p) =>
            p.date.day == savedProgress.date.day &&
            p.date.month == savedProgress.date.month &&
            p.date.year == savedProgress.date.year,
      );

      if (index != -1) {
        _progressList[index] = savedProgress;
      } else {
        _progressList.add(savedProgress);
      }

      // Update today's progress if it's today
      final now = DateTime.now();
      if (savedProgress.date.day == now.day &&
          savedProgress.date.month == now.month &&
          savedProgress.date.year == now.year) {
        _todayProgress = savedProgress;
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

  // Update progress fields
  Future<bool> updateProgress(
    String id,
    Map<String, dynamic> updates,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedProgress =
          await _progressService.updateProgress(id, updates);

      final index = _progressList.indexWhere((p) => p.id == id);
      if (index != -1) {
        _progressList[index] = updatedProgress;
      }

      if (_todayProgress?.id == id) {
        _todayProgress = updatedProgress;
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

  // Get progress statistics
  Map<String, double> getStatistics() {
    if (_progressList.isEmpty) {
      return {
        'avgCalories': 0,
        'totalSteps': 0,
        'avgSleep': 0,
        'avgWeight': 0,
      };
    }

    double totalCalories = 0;
    int totalSteps = 0;
    double totalSleep = 0;
    double totalWeight = 0;
    int caloriesCount = 0;
    int sleepCount = 0;
    int weightCount = 0;

    for (var progress in _progressList) {
      if (progress.caloriesBurned != null) {
        totalCalories += progress.caloriesBurned!;
        caloriesCount++;
      }
      if (progress.steps != null) {
        totalSteps += progress.steps!;
      }
      if (progress.sleepHours != null) {
        totalSleep += progress.sleepHours!;
        sleepCount++;
      }
      if (progress.weight != null) {
        totalWeight += progress.weight!;
        weightCount++;
      }
    }

    return {
      'avgCalories': caloriesCount > 0 ? totalCalories / caloriesCount : 0,
      'totalSteps': totalSteps.toDouble(),
      'avgSleep': sleepCount > 0 ? totalSleep / sleepCount : 0,
      'avgWeight': weightCount > 0 ? totalWeight / weightCount : 0,
    };
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
