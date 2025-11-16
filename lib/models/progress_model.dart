class Progress {
  final String id;
  final String userId;
  final DateTime date;
  final double? weight;
  final int? steps;
  final double? caloriesBurned;
  final int? waterIntake;
  final double? sleepHours;
  final int? workoutsCompleted;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Progress({
    required this.id,
    required this.userId,
    required this.date,
    this.weight,
    this.steps,
    this.caloriesBurned,
    this.waterIntake,
    this.sleepHours,
    this.workoutsCompleted,
    required this.createdAt,
    this.updatedAt,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      date: DateTime.parse(json['date'] as String),
      weight:
          json['weight'] != null ? (json['weight'] as num).toDouble() : null,
      steps: json['steps'] as int?,
      caloriesBurned: json['calories_burned'] != null
          ? (json['calories_burned'] as num).toDouble()
          : null,
      waterIntake: json['water_intake'] as int?,
      sleepHours: json['sleep_hours'] != null
          ? (json['sleep_hours'] as num).toDouble()
          : null,
      workoutsCompleted: json['workouts_completed'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'date': date.toIso8601String(),
      'weight': weight,
      'steps': steps,
      'calories_burned': caloriesBurned,
      'water_intake': waterIntake,
      'sleep_hours': sleepHours,
      'workouts_completed': workoutsCompleted,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Progress copyWith({
    String? id,
    String? userId,
    DateTime? date,
    double? weight,
    int? steps,
    double? caloriesBurned,
    int? waterIntake,
    double? sleepHours,
    int? workoutsCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Progress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      steps: steps ?? this.steps,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      waterIntake: waterIntake ?? this.waterIntake,
      sleepHours: sleepHours ?? this.sleepHours,
      workoutsCompleted: workoutsCompleted ?? this.workoutsCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class WeeklyProgress {
  final List<Progress> dailyProgress;
  final double averageCalories;
  final int totalSteps;
  final double averageSleepHours;
  final int totalWorkouts;

  WeeklyProgress({
    required this.dailyProgress,
    required this.averageCalories,
    required this.totalSteps,
    required this.averageSleepHours,
    required this.totalWorkouts,
  });

  factory WeeklyProgress.fromProgressList(List<Progress> progressList) {
    double totalCalories = 0;
    int totalSteps = 0;
    double totalSleep = 0;
    int totalWorkouts = 0;
    int daysWithData = 0;

    for (var progress in progressList) {
      if (progress.caloriesBurned != null) {
        totalCalories += progress.caloriesBurned!;
        daysWithData++;
      }
      if (progress.steps != null) {
        totalSteps += progress.steps!;
      }
      if (progress.sleepHours != null) {
        totalSleep += progress.sleepHours!;
      }
      if (progress.workoutsCompleted != null) {
        totalWorkouts += progress.workoutsCompleted!;
      }
    }

    return WeeklyProgress(
      dailyProgress: progressList,
      averageCalories: daysWithData > 0 ? totalCalories / daysWithData : 0,
      totalSteps: totalSteps,
      averageSleepHours: daysWithData > 0 ? totalSleep / daysWithData : 0,
      totalWorkouts: totalWorkouts,
    );
  }
}
