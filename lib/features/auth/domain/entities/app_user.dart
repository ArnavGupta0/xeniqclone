enum UserRole {
  consumer,
  provider,
}

class AppUser {
  final String id;
  final String email;
  final String? name;
  final UserRole? role;

  const AppUser({
    required this.id,
    required this.email,
    this.name,
    this.role,
  });

  bool get hasRole => role != null;

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String?,
      role: json['role'] != null 
          ? UserRole.values.firstWhere((e) => e.name == json['role']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'role': role?.name,
    };
  }
}
