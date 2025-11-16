class Workout {
  final String id;
  final String title;
  final String description;
  final String category;
  final int duration;
  final int exercises;
  final int calories;
  final bool isCompleted;
  final DateTime? completedAt;

  Workout({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.duration,
    required this.exercises,
    required this.calories,
    this.isCompleted = false,
    this.completedAt,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['_id'] ?? json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      duration: json['duration'] ?? 0,
      exercises: json['exercises'] ?? 0,
      calories: json['calories'] ?? 0,
      isCompleted: json['isCompleted'] ?? false,
      completedAt: json['completedAt'] != null 
          ? DateTime.parse(json['completedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'duration': duration,
      'exercises': exercises,
      'calories': calories,
      'isCompleted': isCompleted,
      'completedAt': completedAt?.toIso8601String(),
    };
  }
}
