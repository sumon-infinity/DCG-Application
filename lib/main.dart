import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/router/app_router.dart';
import 'app/theme/app_theme.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/emergency/bloc/emergency_bloc.dart';
import 'features/profile/bloc/profile_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Initialize shared preferences
  final prefs = await SharedPreferences.getInstance();
  
  runApp(DCGApp(prefs: prefs));
}

class DCGApp extends StatelessWidget {
  final SharedPreferences prefs;
  
  const DCGApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc(prefs: prefs)),
        BlocProvider(create: (context) => EmergencyBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
      ],
      child: MaterialApp.router(
        title: 'DCG - Daffodil CrisisGuard',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
