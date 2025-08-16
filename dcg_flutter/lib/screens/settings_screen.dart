import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:dcg_flutter/components/app_card.dart';
import 'package:dcg_flutter/providers/auth_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _emergencyContactsVisible = true;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FeatherIcons.arrowLeft),
          onPressed: () => context.go('/home'),
        ),
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account Information',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(FeatherIcons.user),
                    title: Text(user?.name ?? ''),
                    subtitle: const Text('Name'),
                  ),
                  ListTile(
                    leading: const Icon(FeatherIcons.mail),
                    title: Text(user?.email ?? ''),
                    subtitle: const Text('Email'),
                  ),
                  ListTile(
                    leading: const Icon(FeatherIcons.hash),
                    title: Text(user?.studentId ?? ''),
                    subtitle: const Text('Student ID'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Enable Notifications'),
                    subtitle: const Text('Receive alerts and updates'),
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Location Services'),
                    subtitle: const Text('Allow access to your location'),
                    value: _locationEnabled,
                    onChanged: (value) {
                      setState(() {
                        _locationEnabled = value;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: const Text('Emergency Contacts Visibility'),
                    subtitle: const Text(
                      'Show your contacts to emergency services',
                    ),
                    value: _emergencyContactsVisible,
                    onChanged: (value) {
                      setState(() {
                        _emergencyContactsVisible = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    leading: const Icon(FeatherIcons.info),
                    title: const Text('Version'),
                    subtitle: const Text('1.0.0'),
                  ),
                  ListTile(
                    leading: const Icon(FeatherIcons.fileText),
                    title: const Text('Terms of Service'),
                    trailing: const Icon(FeatherIcons.chevronRight),
                    onTap: () {
                      // TODO: Show terms of service
                    },
                  ),
                  ListTile(
                    leading: const Icon(FeatherIcons.lock),
                    title: const Text('Privacy Policy'),
                    trailing: const Icon(FeatherIcons.chevronRight),
                    onTap: () {
                      // TODO: Show privacy policy
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () {
                auth.logout();
                context.go('/');
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
