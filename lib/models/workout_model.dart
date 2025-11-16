class Workout {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final int durationMinutes;
  final double caloriesBurned;
  final String category;
  final String difficulty;
  final List<Exercise> exercises;
  final DateTime? scheduledDate;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime? updatedAt;

  Workout({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.durationMinutes,
    required this.caloriesBurned,
    required this.category,
    required this.difficulty,
    required this.exercises,
    this.scheduledDate,
    this.isCompleted = false,
    this.completedAt,
    required this.createdAt,
    this.updatedAt,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      durationMinutes: json['duration_minutes'] as int,
      caloriesBurned: (json['calories_burned'] as num).toDouble(),
      category: json['category'] as String,
      difficulty: json['difficulty'] as String,
      exercises: (json['exercises'] as List?)
              ?.map((e) => Exercise.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      scheduledDate: json['scheduled_date'] != null
          ? DateTime.parse(json['scheduled_date'] as String)
          : null,
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
      'duration_minutes': durationMinutes,
      'calories_burned': caloriesBurned,
      'category': category,
      'difficulty': difficulty,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'scheduled_date': scheduledDate?.toIso8601String(),
      'is_completed': isCompleted,
      'completed_at': completedAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Workout copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    int? durationMinutes,
    double? caloriesBurned,
    String? category,
    String? difficulty,
    List<Exercise>? exercises,
    DateTime? scheduledDate,
    bool? isCompleted,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Workout(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
      exercises: exercises ?? this.exercises,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  int get totalExercises => exercises.length;
}

class Exercise {
  final String id;
  final String name;
  final String? description;
  final int reps;
  final int sets;
  final int? durationSeconds;
  final String? imageUrl;
  final String? videoUrl;
  final String muscleGroup;
  final String equipment;
  final int order;

  Exercise({
    required this.id,
    required this.name,
    this.description,
    required this.reps,
    required this.sets,
    this.durationSeconds,
    this.imageUrl,
    this.videoUrl,
    required this.muscleGroup,
    required this.equipment,
    required this.order,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      reps: json['reps'] as int,
      sets: json['sets'] as int,
      durationSeconds: json['duration_seconds'] as int?,
      imageUrl: json['image_url'] as String?,
      videoUrl: json['video_url'] as String?,
      muscleGroup: json['muscle_group'] as String,
      equipment: json['equipment'] as String,
      order: json['order'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'reps': reps,
      'sets': sets,
      'duration_seconds': durationSeconds,
      'image_url': imageUrl,
      'video_url': videoUrl,
      'muscle_group': muscleGroup,
      'equipment': equipment,
      'order': order,
    };
  }

  Exercise copyWith({
    String? id,
    String? name,
    String? description,
    int? reps,
    int? sets,
    int? durationSeconds,
    String? imageUrl,
    String? videoUrl,
    String? muscleGroup,
    String? equipment,
    int? order,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      reps: reps ?? this.reps,
      sets: sets ?? this.sets,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      imageUrl: imageUrl ?? this.imageUrl,
      videoUrl: videoUrl ?? this.videoUrl,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      equipment: equipment ?? this.equipment,
      order: order ?? this.order,
    );
  }
}
