import 'dart:convert';
import 'package:flutter/services.dart';

class MockDataService {
  static Map<String, dynamic>? _cachedData;

  static Future<Map<String, dynamic>> loadMockData() async {
    if (_cachedData != null) {
      return _cachedData!;
    }

    try {
      final String jsonString = await rootBundle.loadString('assets/mock_data.json');
      _cachedData = json.decode(jsonString) as Map<String, dynamic>;
      return _cachedData!;
    } catch (e) {
      print('Error loading mock data: $e');
      return {};
    }
  }

  static Future<Map<String, dynamic>> getAppConfig() async {
    final data = await loadMockData();
    return data['app_config'] ?? {};
  }

  static Future<List<dynamic>> getEmergencyContacts() async {
    final data = await loadMockData();
    return data['emergency_contacts'] ?? [];
  }

  static Future<List<dynamic>> getHospitals() async {
    final data = await loadMockData();
    return data['hospitals'] ?? [];
  }

  static Future<List<dynamic>> getPoliceStations() async {
    final data = await loadMockData();
    return data['police_stations'] ?? [];
  }

  static Future<List<dynamic>> getPsychologyServices() async {
    final data = await loadMockData();
    return data['psychology_services'] ?? [];
  }

  static Future<List<dynamic>> getHealthConditions() async {
    final data = await loadMockData();
    return data['health_conditions'] ?? [];
  }

  static Future<List<dynamic>> getSafeZones() async {
    final data = await loadMockData();
    return data['safe_zones'] ?? [];
  }

  static Future<List<dynamic>> getFAQ() async {
    final data = await loadMockData();
    return data['faq'] ?? [];
  }

  static Future<List<dynamic>> getDepartments() async {
    final data = await loadMockData();
    return data['departments'] ?? [];
  }

  static Future<List<dynamic>> getAppointmentSlots() async {
    final data = await loadMockData();
    return data['appointment_slots'] ?? [];
  }

  static Future<List<dynamic>> getCounselingCriteria() async {
    final data = await loadMockData();
    return data['counseling_criteria'] ?? [];
  }

  static Future<Map<String, dynamic>> getUserProfile(String studentId) async {
    final data = await loadMockData();
    final profiles = data['user_profiles'] ?? [];
    return profiles.firstWhere(
      (profile) => profile['student_id'] == studentId,
      orElse: () => {},
    );
  }
}
