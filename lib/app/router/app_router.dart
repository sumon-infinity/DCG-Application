import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/screens/welcome_screen.dart';
import '../../features/auth/screens/qr_scan_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/forgot_password_sent_screen.dart';
import '../../features/auth/screens/otp_verification_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/personal_info_screen.dart';
import '../../features/profile/screens/settings_screen.dart';
import '../../features/emergency/screens/emergency_alert_screen.dart';
import '../../features/emergency/screens/safe_zone_screen.dart';
import '../../features/emergency/screens/emergency_call_screen.dart';
import '../../features/medical/screens/medical_alert_screen.dart';
import '../../features/medical/screens/nearest_medical_screen.dart';
import '../../features/medical/screens/health_condition_screen.dart';
import '../../features/psychology/screens/psychology_services_screen.dart';
import '../../features/psychology/screens/make_appointment_screen.dart';
import '../../features/psychology/screens/counseling_form_screen.dart';
import '../../features/help/screens/faq_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      // Welcome & Auth Routes
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/qr-scan',
        name: 'qr-scan',
        builder: (context, state) => const QRScanScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        name: 'forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/forgot-password-sent',
        name: 'forgot-password-sent',
        builder: (context, state) => const ForgotPasswordSentScreen(),
      ),
      GoRoute(
        path: '/otp-verification',
        name: 'otp-verification',
        builder: (context, state) => const OTPVerificationScreen(),
      ),
      
      // Profile Routes
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/personal-info',
        name: 'personal-info',
        builder: (context, state) => const PersonalInfoScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      
      // Emergency Routes
      GoRoute(
        path: '/emergency-alert',
        name: 'emergency-alert',
        builder: (context, state) => const EmergencyAlertScreen(),
      ),
      GoRoute(
        path: '/safe-zone',
        name: 'safe-zone',
        builder: (context, state) => const SafeZoneScreen(),
      ),
      GoRoute(
        path: '/emergency-call',
        name: 'emergency-call',
        builder: (context, state) => const EmergencyCallScreen(),
      ),
      
      // Medical Routes
      GoRoute(
        path: '/medical-alert',
        name: 'medical-alert',
        builder: (context, state) => const MedicalAlertScreen(),
      ),
      GoRoute(
        path: '/nearest-medical',
        name: 'nearest-medical',
        builder: (context, state) => const NearestMedicalScreen(),
      ),
      GoRoute(
        path: '/health-condition',
        name: 'health-condition',
        builder: (context, state) => const HealthConditionScreen(),
      ),
      
      // Psychology Routes
      GoRoute(
        path: '/psychology-services',
        name: 'psychology-services',
        builder: (context, state) => const PsychologyServicesScreen(),
      ),
      GoRoute(
        path: '/make-appointment',
        name: 'make-appointment',
        builder: (context, state) => const MakeAppointmentScreen(),
      ),
      GoRoute(
        path: '/counseling-form',
        name: 'counseling-form',
        builder: (context, state) => const CounselingFormScreen(),
      ),
      
      // Help Routes
      GoRoute(
        path: '/faq',
        name: 'faq',
        builder: (context, state) => const FAQScreen(),
      ),
    ],
  );
}
