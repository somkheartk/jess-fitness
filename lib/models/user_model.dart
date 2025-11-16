class User {
  final String id;
  final String email;
  final String name;
  final String? avatarUrl;
  final DateTime? dateOfBirth;
  final double? weight;
  final double? height;
  final String? gender;
  final DateTime createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    this.dateOfBirth,
    this.weight,
    this.height,
    this.gender,
    required this.createdAt,
    this.updatedAt,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'] as String)
          : null,
      weight:
          json['weight'] != null ? (json['weight'] as num).toDouble() : null,
      height:
          json['height'] != null ? (json['height'] as num).toDouble() : null,
      gender: json['gender'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'avatar_url': avatarUrl,
      'date_of_birth': dateOfBirth?.toIso8601String(),
      'weight': weight,
      'height': height,
      'gender': gender,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Create a copy with modified fields
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? avatarUrl,
    DateTime? dateOfBirth,
    double? weight,
    double? height,
    String? gender,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Calculate BMI
  double? get bmi {
    if (weight != null && height != null && height! > 0) {
      return weight! / ((height! / 100) * (height! / 100));
    }
    return null;
  }

  // Get age from date of birth
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }
}
