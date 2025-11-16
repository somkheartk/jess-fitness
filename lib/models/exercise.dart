class Exercise {
  final String id;
  final String name;
  final String description;
  final String category;
  final String difficulty;
  final String? imageUrl;
  final int? duration;
  final int? sets;
  final int? reps;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.difficulty,
    this.imageUrl,
    this.duration,
    this.sets,
    this.reps,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['_id'] ?? json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      difficulty: json['difficulty'] ?? 'Beginner',
      imageUrl: json['imageUrl'],
      duration: json['duration'],
      sets: json['sets'],
      reps: json['reps'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'difficulty': difficulty,
      'imageUrl': imageUrl,
      'duration': duration,
      'sets': sets,
      'reps': reps,
    };
  }
}
