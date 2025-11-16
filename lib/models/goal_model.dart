class Goal {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final String type; // 'daily', 'weekly', 'monthly', 'custom'
  final double targetValue;
  final double currentValue;
  final String unit; // 'minutes', 'calories', 'kg', 'workouts', 'steps'
  final DateTime startDate;
  final DateTime endDate;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Goal({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.type,
    required this.targetValue,
    required this.currentValue,
    required this.unit,
    required this.startDate,
    required this.endDate,
    this.isCompleted = false,
    this.completedAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory Goal.fromJson(Map<String, dynamic> json) {
    return Goal(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      type: json['type'] as String,
      targetValue: (json['target_value'] as num).toDouble(),
      currentValue: (json['current_value'] as num).toDouble(),
      unit: json['unit'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      isCompleted: json['is_completed'] as bool? ?? false,
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'] as String)
          : null,
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
      'name': name,
      'description': description,
      'type': type,
      'target_value': targetValue,
      'current_value': currentValue,
      'unit': unit,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'is_completed': isCompleted,
      'completed_at': completedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Goal copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    String? type,
    double? targetValue,
    double? currentValue,
    String? unit,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCompleted,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Goal(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      unit: unit ?? this.unit,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Calculate progress percentage
  double get progressPercentage {
    if (targetValue == 0) return 0;
    final percentage = (currentValue / targetValue) * 100;
    return percentage > 100 ? 100 : percentage;
  }

  // Check if goal is active
  bool get isActive {
    final now = DateTime.now();
    return !isCompleted &&
        now.isAfter(startDate) &&
        now.isBefore(endDate.add(const Duration(days: 1)));
  }

  // Check if goal is expired
  bool get isExpired {
    return !isCompleted && DateTime.now().isAfter(endDate);
  }

  // Days remaining
  int get daysRemaining {
    final now = DateTime.now();
    if (now.isAfter(endDate)) return 0;
    return endDate.difference(now).inDays;
  }
}
