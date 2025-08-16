import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:dcg_flutter/components/app_button.dart';
import 'package:dcg_flutter/components/app_card.dart';

class SafeZoneScreen extends StatelessWidget {
  const SafeZoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FeatherIcons.arrowLeft),
          onPressed: () => context.go('/home'),
        ),
        title: const Text('Safe Zone'),
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
                    'Current Location',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        FeatherIcons.map,
                        size: 48,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    text: 'Share Location',
                    icon: FeatherIcons.share2,
                    onPressed: () {
                      // TODO: Implement location sharing
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Location shared with emergency contacts',
                          ),
                        ),
                      );
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
                    'Nearby Safe Zones',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _SafeZoneItem(
                    name: 'Campus Security Office',
                    distance: '50m',
                    icon: FeatherIcons.shield,
                    onTap: () {
                      // TODO: Show directions
                    },
                  ),
                  _SafeZoneItem(
                    name: 'Student Center',
                    distance: '100m',
                    icon: FeatherIcons.home,
                    onTap: () {
                      // TODO: Show directions
                    },
                  ),
                  _SafeZoneItem(
                    name: 'Library',
                    distance: '150m',
                    icon: FeatherIcons.bookOpen,
                    onTap: () {
                      // TODO: Show directions
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement SOS alert
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('SOS Alert'),
              content: const Text(
                'This will send your current location to emergency services and your emergency contacts.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('SOS Alert sent'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                  child: const Text(
                    'Send SOS',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        },
        icon: const Icon(FeatherIcons.alertTriangle),
        label: const Text('SOS'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

class _SafeZoneItem extends StatelessWidget {
  final String name;
  final String distance;
  final IconData icon;
  final VoidCallback onTap;

  const _SafeZoneItem({
    required this.name,
    required this.distance,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(name),
      subtitle: Text('Distance: $distance'),
      trailing: const Icon(FeatherIcons.chevronRight),
      onTap: onTap,
    );
  }
}
