import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:dcg_flutter/theme/app_theme.dart';
import 'package:dcg_flutter/screens/welcome_screen.dart';
import 'package:dcg_flutter/screens/login_screen.dart';
import 'package:dcg_flutter/screens/signup_screen.dart';
import 'package:dcg_flutter/screens/home_screen.dart';
import 'package:dcg_flutter/screens/emergency_alert_screen.dart';
import 'package:dcg_flutter/screens/safe_zone_screen.dart';
import 'package:dcg_flutter/screens/medical_alert_screen.dart';
import 'package:dcg_flutter/screens/settings_screen.dart';
import 'package:dcg_flutter/screens/qr_scan_screen.dart';
import 'package:dcg_flutter/providers/auth_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AuthProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => authProvider.isAuthenticated
              ? const HomeScreen()
              : const WelcomeScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => authProvider.isAuthenticated
              ? const HomeScreen()
              : const LoginScreen(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => authProvider.isAuthenticated
              ? const HomeScreen()
              : const SignUpScreen(),
        ),
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/emergency-alert',
          builder: (context, state) => const EmergencyAlertScreen(),
        ),
        GoRoute(
          path: '/safe-zone',
          builder: (context, state) => const SafeZoneScreen(),
        ),
        GoRoute(
          path: '/medical-alert',
          builder: (context, state) => const MedicalAlertScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: '/qr-scan',
          builder: (context, state) => const QRScanScreen(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'DCG App',
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
