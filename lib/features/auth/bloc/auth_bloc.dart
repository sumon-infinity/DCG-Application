import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String studentId;
  final String password;
  LoginRequested({required this.studentId, required this.password});
}

class SignupRequested extends AuthEvent {
  final String studentId;
  final String department;
  final String semester;
  final String emergencyContact;
  final String password;
  
  SignupRequested({
    required this.studentId,
    required this.department,
    required this.semester,
    required this.emergencyContact,
    required this.password,
  });
}

class LogoutRequested extends AuthEvent {}

class AuthStatusChanged extends AuthEvent {
  final bool isAuthenticated;
  AuthStatusChanged({required this.isAuthenticated});
}

class ForgotPasswordRequested extends AuthEvent {
  final String email;
  ForgotPasswordRequested({required this.email});
}

class OTPVerificationRequested extends AuthEvent {
  final String otp;
  OTPVerificationRequested({required this.otp});
}

// States
abstract class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
  final String? message;
  
  const AuthState({
    required this.isAuthenticated,
    this.isLoading = false,
    this.error,
    this.message,
  });
}

class AuthInitial extends AuthState {
  const AuthInitial() : super(isAuthenticated: false);
}

class AuthLoading extends AuthState {
  const AuthLoading({required bool isAuthenticated}) : super(isAuthenticated: isAuthenticated, isLoading: true);
}

class AuthAuthenticated extends AuthState {
  final String studentId;
  const AuthAuthenticated({required this.studentId}) : super(isAuthenticated: true);
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated({String? error}) : super(isAuthenticated: false, error: error);
}

class AuthError extends AuthState {
  const AuthError({required String error, required bool isAuthenticated}) 
      : super(isAuthenticated: isAuthenticated, error: error);
}

class AuthSuccess extends AuthState {
  const AuthSuccess({required String message, required bool isAuthenticated}) 
      : super(isAuthenticated: isAuthenticated, message: message);
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreferences prefs;
  
  AuthBloc({required this.prefs}) : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthStatusChanged>(_onAuthStatusChanged);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
    on<OTPVerificationRequested>(_onOTPVerificationRequested);
    
    // Check if user is already logged in
    _checkAuthStatus();
  }
  
  void _checkAuthStatus() {
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    final studentId = prefs.getString('student_id');
    
    if (isLoggedIn && studentId != null) {
      add(AuthStatusChanged(isAuthenticated: true));
    }
  }
  
  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(isAuthenticated: false));
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Simple validation for demo purposes
      if (event.studentId.isNotEmpty && event.password.isNotEmpty) {
        // Save login state
        await prefs.setBool('is_logged_in', true);
        await prefs.setString('student_id', event.studentId);
        
        emit(AuthAuthenticated(studentId: event.studentId));
      } else {
        emit(const AuthUnauthenticated(error: 'Invalid credentials'));
      }
    } catch (e) {
      emit(AuthError(error: e.toString(), isAuthenticated: false));
    }
  }
  
  Future<void> _onSignupRequested(SignupRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(isAuthenticated: false));
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Simple validation for demo purposes
      if (event.studentId.isNotEmpty && event.password.isNotEmpty) {
        // Save user data
        await prefs.setBool('is_logged_in', true);
        await prefs.setString('student_id', event.studentId);
        await prefs.setString('department', event.department);
        await prefs.setString('semester', event.semester);
        await prefs.setString('emergency_contact', event.emergencyContact);
        
        emit(AuthAuthenticated(studentId: event.studentId));
      } else {
        emit(const AuthUnauthenticated(error: 'Please fill all required fields'));
      }
    } catch (e) {
      emit(AuthError(error: e.toString(), isAuthenticated: false));
    }
  }
  
  Future<void> _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(isAuthenticated: true));
    
    try {
      // Clear stored data
      await prefs.clear();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(error: e.toString(), isAuthenticated: true));
    }
  }
  
  Future<void> _onAuthStatusChanged(AuthStatusChanged event, Emitter<AuthState> emit) async {
    if (event.isAuthenticated) {
      final studentId = prefs.getString('student_id') ?? '';
      emit(AuthAuthenticated(studentId: studentId));
    } else {
      emit(const AuthUnauthenticated());
    }
  }
  
  Future<void> _onForgotPasswordRequested(ForgotPasswordRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(isAuthenticated: false));
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      if (event.email.isNotEmpty && event.email.contains('@')) {
        emit(const AuthSuccess(
          message: 'Password reset link sent to your email',
          isAuthenticated: false,
        ));
      } else {
        emit(const AuthError(error: 'Please enter a valid email', isAuthenticated: false));
      }
    } catch (e) {
      emit(AuthError(error: e.toString(), isAuthenticated: false));
    }
  }
  
  Future<void> _onOTPVerificationRequested(OTPVerificationRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading(isAuthenticated: false));
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Simple OTP validation (for demo)
      if (event.otp == '2604') {
        emit(const AuthSuccess(
          message: 'OTP verified successfully',
          isAuthenticated: false,
        ));
      } else {
        emit(const AuthError(error: 'Invalid OTP', isAuthenticated: false));
      }
    } catch (e) {
      emit(AuthError(error: e.toString(), isAuthenticated: false));
    }
  }
}
