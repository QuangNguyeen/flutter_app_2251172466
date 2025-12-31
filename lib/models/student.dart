class Student {
  final int id;
  final String email;
  final String fullName;
  final String? phoneNumber;
  final String? dateOfBirth;
  final String? gender;
  final String? avatarUrl;
  final bool isActive;
  final String createdAt;

  Student({
    required this.id,
    required this.email,
    required this.fullName,
    this.phoneNumber,
    this.dateOfBirth,
    this.gender,
    this.avatarUrl,
    required this.isActive,
    required this.createdAt,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      email: json['email'],
      fullName: json['full_name'],
      phoneNumber: json['phone_number'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      avatarUrl: json['avatar_url'],
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'],
    );
  }
}
