class User {
  final String id;
  final String email;
  final String name;
  final String? profileImage;
  final Map<String, dynamic>? stats;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.profileImage,
    this.stats,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      profileImage: json['profileImage'],
      stats: json['stats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profileImage': profileImage,
      'stats': stats,
    };
  }
}
