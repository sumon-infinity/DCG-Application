import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:dcg_flutter/components/app_input_field.dart';
import 'package:dcg_flutter/components/app_button.dart';
import 'package:dcg_flutter/components/dcg_logo.dart';
import 'package:dcg_flutter/components/app_back_button.dart';
import 'package:dcg_flutter/providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _studentIdController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _studentIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const DCGLogo(),
                  const SizedBox(height: 32),
                  AppInputField(
                    label: 'Student ID',
                    controller: _studentIdController,
                    prefixIcon: FeatherIcons.user,
                  ),
                  const SizedBox(height: 16),
                  AppInputField(
                    label: 'Password',
                    controller: _passwordController,
                    obscureText: !_showPassword,
                    prefixIcon: FeatherIcons.lock,
                    suffix: IconButton(
                      icon: Icon(
                        _showPassword ? FeatherIcons.eyeOff : FeatherIcons.eye,
                      ),
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.go('/forgot-password'),
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Consumer<AuthProvider>(
                    builder: (context, auth, _) => AppButton(
                      text: 'Login',
                      isLoading: auth.isLoading,
                      onPressed: () async {
                        if (_studentIdController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in all fields'),
                            ),
                          );
                          return;
                        }

                        final success = await auth.login(
                          _studentIdController.text,
                          _passwordController.text,
                        );

                        if (success && context.mounted) {
                          context.go('/home');
                        } else if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Invalid credentials'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () => context.go('/signup'),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AppBackButton(onPressed: () => context.go('/')),
        ],
      ),
    );
  }
}
