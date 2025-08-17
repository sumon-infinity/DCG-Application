import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class EmergencyEvent {}

class SendEmergencyAlert extends EmergencyEvent {
  final String alertType;
  final String? message;
  final double? latitude;
  final double? longitude;
  
  SendEmergencyAlert({
    required this.alertType,
    this.message,
    this.latitude,
    this.longitude,
  });
}

class GetNearestServices extends EmergencyEvent {
  final String serviceType; // 'hospital', 'police', 'fire'
  final double latitude;
  final double longitude;
  
  GetNearestServices({
    required this.serviceType,
    required this.latitude,
    required this.longitude,
  });
}

class CallEmergencyNumber extends EmergencyEvent {
  final String phoneNumber;
  CallEmergencyNumber({required this.phoneNumber});
}

class MedicalAlertTriggered extends EmergencyEvent {
  final String condition;
  final String notes;
  
  MedicalAlertTriggered({
    required this.condition,
    required this.notes,
  });
}

// States
abstract class EmergencyState {
  final bool isLoading;
  final String? error;
  final String? message;
  
  const EmergencyState({
    this.isLoading = false,
    this.error,
    this.message,
  });
}

class EmergencyInitial extends EmergencyState {}

class EmergencyLoading extends EmergencyState {
  const EmergencyLoading() : super(isLoading: true);
}

class EmergencyAlertSent extends EmergencyState {
  const EmergencyAlertSent({required String message}) : super(message: message);
}

class NearestServicesLoaded extends EmergencyState {
  final List<EmergencyService> services;
  const NearestServicesLoaded({required this.services});
}

class EmergencyError extends EmergencyState {
  const EmergencyError({required String error}) : super(error: error);
}

class EmergencySuccess extends EmergencyState {
  const EmergencySuccess({required String message}) : super(message: message);
}

class EmergencyCallInitiated extends EmergencyState {
  const EmergencyCallInitiated({required String message}) : super(message: message);
}

// Models
class EmergencyService {
  final String id;
  final String name;
  final String type;
  final String address;
  final String phoneNumber;
  final double latitude;
  final double longitude;
  final double distance;
  
  const EmergencyService({
    required this.id,
    required this.name,
    required this.type,
    required this.address,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.distance,
  });
}

// Bloc
class EmergencyBloc extends Bloc<EmergencyEvent, EmergencyState> {
  EmergencyBloc() : super(EmergencyInitial()) {
    on<SendEmergencyAlert>(_onSendEmergencyAlert);
    on<GetNearestServices>(_onGetNearestServices);
    on<CallEmergencyNumber>(_onCallEmergencyNumber);
    on<MedicalAlertTriggered>(_onMedicalAlertTriggered);
  }
  
  Future<void> _onSendEmergencyAlert(SendEmergencyAlert event, Emitter<EmergencyState> emit) async {
    emit(const EmergencyLoading());
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Mock alert sending logic
      emit(const EmergencyAlertSent(
        message: 'Emergency alert sent successfully! Authorities have been notified.',
      ));
    } catch (e) {
      emit(EmergencyError(error: 'Failed to send emergency alert: ${e.toString()}'));
    }
  }
  
  Future<void> _onGetNearestServices(GetNearestServices event, Emitter<EmergencyState> emit) async {
    emit(const EmergencyLoading());
    
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock data - in real app, this would come from API
      List<EmergencyService> mockServices = [];
      
      switch (event.serviceType) {
        case 'hospital':
          mockServices = [
            const EmergencyService(
              id: '1',
              name: 'Daffodil International University Hospital',
              type: 'hospital',
              address: 'Dhanmondi, Dhaka',
              phoneNumber: '+880-2-9670101',
              latitude: 23.7465,
              longitude: 90.3742,
              distance: 2.5,
            ),
            const EmergencyService(
              id: '2',
              name: 'Apollo Hospital',
              type: 'hospital',
              address: 'Plot 81, Block E, Bashundhara R/A, Dhaka',
              phoneNumber: '+880-2-8401661',
              latitude: 23.8103,
              longitude: 90.4125,
              distance: 5.2,
            ),
          ];
          break;
        case 'police':
          mockServices = [
            const EmergencyService(
              id: '3',
              name: 'Dhanmondi Police Station',
              type: 'police',
              address: 'Road 2, Dhanmondi, Dhaka',
              phoneNumber: '+880-2-9661551',
              latitude: 23.7461,
              longitude: 90.3742,
              distance: 1.8,
            ),
          ];
          break;
      }
      
      emit(NearestServicesLoaded(services: mockServices));
    } catch (e) {
      emit(EmergencyError(error: 'Failed to load services: ${e.toString()}'));
    }
  }
  
  Future<void> _onCallEmergencyNumber(CallEmergencyNumber event, Emitter<EmergencyState> emit) async {
    emit(const EmergencyLoading());
    
    try {
      // Simulate call initiation
      await Future.delayed(const Duration(milliseconds: 500));
      
      emit(EmergencyCallInitiated(
        message: 'Calling ${event.phoneNumber}...',
      ));
    } catch (e) {
      emit(EmergencyError(error: 'Failed to initiate call: ${e.toString()}'));
    }
  }
  
  Future<void> _onMedicalAlertTriggered(MedicalAlertTriggered event, Emitter<EmergencyState> emit) async {
    emit(const EmergencyLoading());
    
    try {
      // Simulate sending medical alert
      await Future.delayed(const Duration(seconds: 1));
      
      emit(EmergencySuccess(
        message: 'Medical alert sent! Condition: ${event.condition}${event.notes.isNotEmpty ? '\nNotes: ${event.notes}' : ''}',
      ));
    } catch (e) {
      emit(EmergencyError(error: 'Failed to send medical alert: ${e.toString()}'));
    }
  }
}
