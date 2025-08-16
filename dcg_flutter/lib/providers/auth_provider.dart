import 'package:flutter/foundation.dart';
import 'package:dcg_flutter/models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> login(String studentId, String password) async {
    setLoading(true);

    try {
      // TODO: Implement actual login API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // Simulated success response
      _user = User(
        id: '1',
        name: 'John Doe',
        studentId: studentId,
        email: 'john.doe@example.com',
        department: 'Computer Science',
        semester: '6th',
      );

      setLoading(false);
      return true;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }

  Future<bool> signup(Map<String, String> userData) async {
    setLoading(true);

    try {
      // TODO: Implement actual signup API call
      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      // Simulated success response
      _user = User(
        id: '1',
        name: userData['name']!,
        studentId: userData['studentId']!,
        email: userData['email']!,
        department: userData['department']!,
        semester: userData['semester']!,
      );

      setLoading(false);
      return true;
    } catch (e) {
      setLoading(false);
      return false;
    }
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}
