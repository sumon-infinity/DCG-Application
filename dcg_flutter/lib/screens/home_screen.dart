import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:dcg_flutter/providers/auth_provider.dart';
import 'package:dcg_flutter/components/app_card.dart';
import 'package:dcg_flutter/components/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.user;

    if (user == null) {
      context.go('/');
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('DCG App'),
        actions: [
          IconButton(
            icon: const Icon(FeatherIcons.camera),
            onPressed: () => context.go('/qr-scan'),
          ),
          IconButton(
            icon: const Icon(FeatherIcons.settings),
            onPressed: () => context.go('/settings'),
          ),
          IconButton(
            icon: const Icon(FeatherIcons.logOut),
            onPressed: () {
              auth.logout();
              context.go('/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppCard(
              title: 'Welcome back',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.studentId,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _QuickActionCard(
                  icon: FeatherIcons.alertTriangle,
                  title: 'Emergency Alert',
                  onTap: () => context.go('/emergency-alert'),
                ),
                _QuickActionCard(
                  icon: FeatherIcons.mapPin,
                  title: 'Safe Zone',
                  onTap: () => context.go('/safe-zone'),
                ),
                _QuickActionCard(
                  icon: FeatherIcons.phone,
                  title: 'Emergency Call',
                  onTap: () => context.go('/emergency-call'),
                ),
                _QuickActionCard(
                  icon: FeatherIcons.activity,
                  title: 'Medical Alert',
                  onTap: () => context.go('/medical-alert'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
