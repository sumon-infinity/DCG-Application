import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:dcg_flutter/components/app_button.dart';
import 'package:dcg_flutter/components/app_card.dart';

class EmergencyAlertScreen extends StatelessWidget {
  const EmergencyAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FeatherIcons.arrowLeft),
          onPressed: () => context.go('/home'),
        ),
        title: const Text('Emergency Alert'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Warning',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Only use this feature in case of a real emergency. This will alert campus security and nearby authorities.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    text: 'Send Emergency Alert',
                    backgroundColor: Colors.red,
                    onPressed: () {
                      // TODO: Implement emergency alert logic
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Alert Sent'),
                          content: const Text(
                            'Emergency services have been notified. Stay calm and wait for assistance.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Emergency Contacts',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _EmergencyContactTile(
                    icon: FeatherIcons.shield,
                    title: 'Campus Security',
                    phone: '123-456-7890',
                    onTap: () {
                      // TODO: Implement phone call
                    },
                  ),
                  _EmergencyContactTile(
                    icon: FeatherIcons.phone,
                    title: 'Police',
                    phone: '911',
                    onTap: () {
                      // TODO: Implement phone call
                    },
                  ),
                  _EmergencyContactTile(
                    icon: FeatherIcons.activity,
                    title: 'Medical Emergency',
                    phone: '911',
                    onTap: () {
                      // TODO: Implement phone call
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmergencyContactTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String phone;
  final VoidCallback onTap;

  const _EmergencyContactTile({
    required this.icon,
    required this.title,
    required this.phone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title),
        subtitle: Text(phone),
        trailing: IconButton(
          icon: const Icon(FeatherIcons.phoneCall),
          onPressed: onTap,
        ),
      ),
    );
  }
}
