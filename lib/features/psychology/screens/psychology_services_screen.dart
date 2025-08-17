import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../shared/services/mock_data_service.dart';

class PsychologyServicesScreen extends StatefulWidget {
  const PsychologyServicesScreen({super.key});

  @override
  State<PsychologyServicesScreen> createState() => _PsychologyServicesScreenState();
}

class _PsychologyServicesScreenState extends State<PsychologyServicesScreen> {
  List<Map<String, dynamic>> psychologyServices = [];

  @override
  void initState() {
    super.initState();
    _loadPsychologyData();
  }

  void _loadPsychologyData() async {
    final data = await MockDataService.loadMockData();
    setState(() {
      psychologyServices = List<Map<String, dynamic>>.from(
        data['psychologyServices'] ?? []
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Psychology Services'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(LucideIcons.arrowLeft),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade400,
                    Colors.purple.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    LucideIcons.brain,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Mental Health Support',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Professional counseling and therapy services for your mental well-being',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Quick Actions
            Row(
              children: [
                Expanded(
                  child: _buildActionCard(
                    icon: LucideIcons.calendar,
                    title: 'Book Appointment',
                    subtitle: 'Schedule with therapist',
                    color: Colors.green,
                    onTap: () => context.pushNamed('make-appointment'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionCard(
                    icon: LucideIcons.fileText,
                    title: 'Assessment',
                    subtitle: 'Mental health form',
                    color: Colors.orange,
                    onTap: () => context.pushNamed('counseling-form'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Services List
            Text(
              'Available Services',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            if (psychologyServices.isNotEmpty)
              ...psychologyServices.map((service) => _buildServiceCard(service))
            else
              _buildDefaultServices(),

            const SizedBox(height: 32),

            // Emergency Mental Health
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        LucideIcons.alertTriangle,
                        color: Colors.red.shade600,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Crisis Support',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'If you\'re experiencing a mental health crisis, please reach out immediately.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.red.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Call crisis hotline
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Calling crisis hotline...')),
                            );
                          },
                          icon: const Icon(LucideIcons.phone),
                          label: const Text('Crisis Hotline'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 32,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getServiceIcon(service['type']),
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service['name'],
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          service['specialization'],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                service['description'],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    LucideIcons.clock,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    service['availability'],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => context.pushNamed('make-appointment'),
                    child: const Text('Book Now'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultServices() {
    final defaultServices = [
      {
        'name': 'Individual Therapy',
        'type': 'therapy',
        'specialization': 'Personal counseling',
        'description': 'One-on-one sessions with licensed therapists for personal issues, anxiety, depression, and life challenges.',
        'availability': 'Mon-Fri, 9 AM - 6 PM',
      },
      {
        'name': 'Group Therapy',
        'type': 'group',
        'specialization': 'Group sessions',
        'description': 'Supportive group environment for shared experiences and peer support.',
        'availability': 'Tue, Thu, Sat 7 PM - 8:30 PM',
      },
      {
        'name': 'Crisis Intervention',
        'type': 'crisis',
        'specialization': 'Emergency support',
        'description': 'Immediate support for mental health emergencies and crisis situations.',
        'availability': '24/7 Emergency Line',
      },
    ];

    return Column(
      children: defaultServices.map((service) => _buildServiceCard(service)).toList(),
    );
  }

  IconData _getServiceIcon(String type) {
    switch (type) {
      case 'therapy':
        return LucideIcons.userCheck;
      case 'group':
        return LucideIcons.users;
      case 'crisis':
        return LucideIcons.alertTriangle;
      default:
        return LucideIcons.brain;
    }
  }
}
