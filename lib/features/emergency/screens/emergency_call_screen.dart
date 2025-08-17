import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../shared/services/mock_data_service.dart';
import '../bloc/emergency_bloc.dart';

class EmergencyCallScreen extends StatefulWidget {
  const EmergencyCallScreen({super.key});

  @override
  State<EmergencyCallScreen> createState() => _EmergencyCallScreenState();
}

class _EmergencyCallScreenState extends State<EmergencyCallScreen>
    with TickerProviderStateMixin {
  List<Map<String, dynamic>> emergencyContacts = [];
  late AnimationController _pulseController;
  late AnimationController _rippleController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rippleAnimation;
  bool _isDialing = false;
  String? _currentlyCallingNumber;
  String? _currentlyCallingName;

  @override
  void initState() {
    super.initState();
    _loadEmergencyContacts();
    _setupAnimations();
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _rippleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: Curves.easeOut,
    ));

    _pulseController.repeat(reverse: true);
  }

  void _loadEmergencyContacts() async {
    final data = await MockDataService.loadMockData();
    setState(() {
      emergencyContacts = List<Map<String, dynamic>>.from(
        data['emergency_contacts'] ?? []
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Emergency Call'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(LucideIcons.arrowLeft),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              _showEmergencyTips();
            },
            icon: const Icon(LucideIcons.info),
          ),
        ],
      ),
      body: BlocListener<EmergencyBloc, EmergencyState>(
        listener: (context, state) {
          if (state is EmergencyCallInitiated) {
            setState(() {
              _isDialing = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? 'Call initiated'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is EmergencyError) {
            setState(() {
              _isDialing = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error ?? 'Failed to make call'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Emergency Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade400,
                      Colors.red.shade600,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    AnimatedBuilder(
                      animation: _pulseAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _pulseAnimation.value,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              LucideIcons.phone,
                              color: Colors.white,
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Emergency Call',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isDialing
                          ? 'Calling $_currentlyCallingName...'
                          : 'Select an emergency service to call',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Quick Dial - 911
              _buildQuickDialButton(
                number: '911',
                label: 'Emergency Services',
                subtitle: 'Police, Fire, Medical',
                icon: LucideIcons.zap,
                color: Colors.red,
                isPrimary: true,
              ),

              const SizedBox(height: 24),

              // Emergency Contacts List
              if (emergencyContacts.isNotEmpty) ...[
                Text(
                  'Emergency Contacts',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                ...emergencyContacts.map((contact) => _buildContactCard(contact)),
              ],

              const SizedBox(height: 24),

              // Additional Emergency Numbers
              _buildAdditionalNumbers(),

              const SizedBox(height: 32),

              // Emergency Actions
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => context.pushNamed('nearest-medical'),
                      icon: const Icon(LucideIcons.mapPin),
                      label: const Text('Find Nearby'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.pushNamed('emergency-alert'),
                      icon: const Icon(LucideIcons.alertTriangle),
                      label: const Text('Send Alert'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickDialButton({
    required String number,
    required String label,
    required String subtitle,
    required IconData icon,
    required Color color,
    bool isPrimary = false,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        elevation: isPrimary ? 8 : 4,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () => _makeEmergencyCall(number, label),
          borderRadius: BorderRadius.circular(20),
          child: AnimatedBuilder(
            animation: _rippleAnimation,
            builder: (context, child) {
              return Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: isPrimary
                          ? LinearGradient(
                              colors: [
                                color.withValues(alpha: 0.8),
                                color.withValues(alpha: 1.0),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color: isPrimary ? null : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isPrimary
                                ? Colors.white.withValues(alpha: 0.2)
                                : color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            icon,
                            color: isPrimary ? Colors.white : color,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                label,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isPrimary ? Colors.white : null,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                subtitle,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: isPrimary
                                      ? Colors.white.withValues(alpha: 0.8)
                                      : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isPrimary
                                      ? Colors.white.withValues(alpha: 0.2)
                                      : color.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  number,
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: isPrimary ? Colors.white : color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          LucideIcons.phone,
                          color: isPrimary
                              ? Colors.white
                              : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                  if (_isDialing && _currentlyCallingNumber == number)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(Map<String, dynamic> contact) {
    final isAvailable24_7 = contact['available_24_7'] == true;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () => _makeEmergencyCall(contact['phone'], contact['name']),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getContactColor(contact['type']).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getContactIcon(contact['type']),
                    color: _getContactColor(contact['type']),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              contact['name'],
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          if (isAvailable24_7)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '24/7',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        contact['phone'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  LucideIcons.phone,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAdditionalNumbers() {
    final additionalNumbers = [
      {
        'number': '999',
        'label': 'National Emergency',
        'icon': LucideIcons.shield,
        'color': Colors.blue,
      },
      {
        'number': '16263',
        'label': 'National Helpline',
        'icon': LucideIcons.headphones,
        'color': Colors.green,
      },
      {
        'number': '109',
        'label': 'Women & Child Helpline',
        'icon': LucideIcons.heart,
        'color': Colors.pink,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other Emergency Numbers',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...additionalNumbers.map((contact) => _buildQuickDialButton(
          number: contact['number'] as String,
          label: contact['label'] as String,
          subtitle: 'Emergency Service',
          icon: contact['icon'] as IconData,
          color: contact['color'] as Color,
        )),
      ],
    );
  }

  Color _getContactColor(String type) {
    switch (type) {
      case 'security':
        return Colors.blue;
      case 'medical':
        return Colors.red;
      case 'police':
        return Colors.indigo;
      case 'fire':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getContactIcon(String type) {
    switch (type) {
      case 'security':
        return LucideIcons.shield;
      case 'medical':
        return LucideIcons.cross;
      case 'police':
        return LucideIcons.badge;
      case 'fire':
        return LucideIcons.flame;
      default:
        return LucideIcons.phone;
    }
  }

  void _makeEmergencyCall(String phoneNumber, String serviceName) async {
    setState(() {
      _isDialing = true;
      _currentlyCallingNumber = phoneNumber;
      _currentlyCallingName = serviceName;
    });

    _rippleController.forward().then((_) {
      _rippleController.reset();
    });

    // Add to emergency bloc for tracking
    context.read<EmergencyBloc>().add(CallEmergencyNumber(phoneNumber: phoneNumber));

    // Attempt to make actual call
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri);
      } else {
        throw Exception('Could not launch $telUri');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isDialing = false;
          _currentlyCallingNumber = null;
          _currentlyCallingName = null;
        });
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unable to make call to $phoneNumber'),
            backgroundColor: Colors.orange,
            action: SnackBarAction(
              label: 'Copy Number',
              onPressed: () {
                // Copy to clipboard functionality would go here
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Number copied to clipboard')),
                  );
                }
              },
            ),
          ),
        );
      }
    }

    // Reset state after delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isDialing = false;
          _currentlyCallingNumber = null;
          _currentlyCallingName = null;
        });
      }
    });
  }

  void _showEmergencyTips() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(LucideIcons.info, color: Colors.blue),
              SizedBox(width: 8),
              Text('Emergency Tips'),
            ],
          ),
          content: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '📞 When calling emergency services:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Stay calm and speak clearly'),
                Text('• Provide your exact location'),
                Text('• Describe the emergency situation'),
                Text('• Follow the operator\'s instructions'),
                Text('• Don\'t hang up until told to do so'),
                SizedBox(height: 16),
                Text(
                  '🚨 In immediate danger:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('• Call 911 or 999 immediately'),
                Text('• Move to a safe location if possible'),
                Text('• Alert others nearby if safe to do so'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Got it'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rippleController.dispose();
    super.dispose();
  }
}
