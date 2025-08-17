import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final Map<String, String> profileData;
  UpdateProfile({required this.profileData});
}

class UpdatePersonalInfo extends ProfileEvent {
  final Map<String, String> personalInfo;
  UpdatePersonalInfo({required this.personalInfo});
}

// States
abstract class ProfileState {
  final bool isLoading;
  final String? error;
  final String? message;
  
  const ProfileState({
    this.isLoading = false,
    this.error,
    this.message,
  });
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {
  const ProfileLoading() : super(isLoading: true);
}

class ProfileLoaded extends ProfileState {
  final UserProfile profile;
  const ProfileLoaded({required this.profile});
}

class ProfileError extends ProfileState {
  const ProfileError({required String error}) : super(error: error);
}

class ProfileUpdated extends ProfileState {
  const ProfileUpdated({required String message}) : super(message: message);
}

// Models
class UserProfile {
  final String studentId;
  final String name;
  final String email;
  final String department;
  final String semester;
  final String batch;
  final String emergencyContact;
  final String? profileImage;
  
  const UserProfile({
    required this.studentId,
    required this.name,
    required this.email,
    required this.department,
    required this.semester,
    required this.batch,
    required this.emergencyContact,
    this.profileImage,
  });
  
  UserProfile copyWith({
    String? studentId,
    String? name,
    String? email,
    String? department,
    String? semester,
    String? batch,
    String? emergencyContact,
    String? profileImage,
  }) {
    return UserProfile(
      studentId: studentId ?? this.studentId,
      name: name ?? this.name,
      email: email ?? this.email,
      department: department ?? this.department,
      semester: semester ?? this.semester,
      batch: batch ?? this.batch,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

// Bloc
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
    on<UpdatePersonalInfo>(_onUpdatePersonalInfo);
  }
  
  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock profile data
      const profile = UserProfile(
        studentId: '201-15-3456',
        name: 'Mahmudul Hasan Sumon',
        email: 'sumon.itm@diu.edu.bd',
        department: 'ITM',
        semester: '7th',
        batch: '6th',
        emergencyContact: '+8801234567890',
      );
      
      emit(const ProfileLoaded(profile: profile));
    } catch (e) {
      emit(ProfileError(error: 'Failed to load profile: ${e.toString()}'));
    }
  }
  
  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      emit(const ProfileUpdated(message: 'Profile updated successfully'));
    } catch (e) {
      emit(ProfileError(error: 'Failed to update profile: ${e.toString()}'));
    }
  }
  
  Future<void> _onUpdatePersonalInfo(UpdatePersonalInfo event, Emitter<ProfileState> emit) async {
    emit(const ProfileLoading());
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      emit(const ProfileUpdated(message: 'Personal information updated successfully'));
    } catch (e) {
      emit(ProfileError(error: 'Failed to update personal information: ${e.toString()}'));
    }
  }
}
