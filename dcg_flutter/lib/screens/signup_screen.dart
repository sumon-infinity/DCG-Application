import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:dcg_flutter/components/app_input_field.dart';
import 'package:dcg_flutter/components/app_button.dart';
import 'package:dcg_flutter/components/dcg_logo.dart';
import 'package:dcg_flutter/components/app_back_button.dart';
import 'package:dcg_flutter/providers/auth_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _studentIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _departmentController = TextEditingController();
  final _semesterController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _nameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _departmentController.dispose();
    _semesterController.dispose();
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const DCGLogo(),
                    AppInputField(
                      label: 'Full Name',
                      controller: _nameController,
                      prefixIcon: FeatherIcons.user,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppInputField(
                      label: 'Student ID',
                      controller: _studentIdController,
                      prefixIcon: FeatherIcons.hash,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your student ID';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppInputField(
                      label: 'Email',
                      controller: _emailController,
                      prefixIcon: FeatherIcons.mail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        if (!value!.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppInputField(
                      label: 'Department',
                      controller: _departmentController,
                      prefixIcon: FeatherIcons.briefcase,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your department';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppInputField(
                      label: 'Semester',
                      controller: _semesterController,
                      prefixIcon: FeatherIcons.calendar,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your semester';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    AppInputField(
                      label: 'Password',
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      prefixIcon: FeatherIcons.lock,
                      suffix: IconButton(
                        icon: Icon(
                          _showPassword
                              ? FeatherIcons.eyeOff
                              : FeatherIcons.eye,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter a password';
                        }
                        if (value!.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    Consumer<AuthProvider>(
                      builder: (context, auth, _) => AppButton(
                        text: 'Sign Up',
                        isLoading: auth.isLoading,
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final success = await auth.signup({
                              'name': _nameController.text,
                              'studentId': _studentIdController.text,
                              'email': _emailController.text,
                              'department': _departmentController.text,
                              'semester': _semesterController.text,
                              'password': _passwordController.text,
                            });

                            if (success && context.mounted) {
                              context.go('/home');
                            } else if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Failed to create account'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () => context.go('/login'),
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppBackButton(onPressed: () => context.go('/')),
        ],
      ),
    );
  }
}
