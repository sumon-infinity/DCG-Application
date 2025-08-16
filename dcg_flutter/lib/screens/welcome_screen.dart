import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dcg_flutter/components/app_button.dart';
import 'package:dcg_flutter/components/app_card.dart';
import 'package:feather_icons/feather_icons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Center(
                child: Column(
                  children: [
                    Icon(
                      FeatherIcons.shield,
                      size: 64,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Welcome to DCG',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your trusted healthcare companion',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AppButton(
                text: 'Get Started',
                onPressed: () => context.go('/signup'),
                icon: FeatherIcons.arrowRight,
              ),
              const SizedBox(height: 16),
              AppButton(
                text: 'I already have an account',
                onPressed: () => context.go('/login'),
                backgroundColor: Colors.transparent,
                textColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
