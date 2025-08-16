class User {
  final String id;
  final String name;
  final String studentId;
  final String email;
  final String department;
  final String semester;

  User({
    required this.id,
    required this.name,
    required this.studentId,
    required this.email,
    required this.department,
    required this.semester,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      studentId: json['studentId'] as String,
      email: json['email'] as String,
      department: json['department'] as String,
      semester: json['semester'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'studentId': studentId,
      'email': email,
      'department': department,
      'semester': semester,
    };
  }
}
