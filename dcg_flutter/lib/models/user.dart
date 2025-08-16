class User {
  final String id;
  final String name;
  final String studentId;
  final String email;
  final String phone;
  final String department;
  final String semester;

  User({
    required this.id,
    required this.name,
    required this.studentId,
    required this.email,
    required this.phone,
    required this.department,
    required this.semester,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      studentId: json['studentId'],
      email: json['email'],
      phone: json['phone'],
      department: json['department'],
      semester: json['semester'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'studentId': studentId,
      'email': email,
      'phone': phone,
      'department': department,
      'semester': semester,
    };
  }
}
