import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../shared/services/mock_data_service.dart';

class SafeZoneScreen extends StatefulWidget {
  const SafeZoneScreen({super.key});

  @override
  State<SafeZoneScreen> createState() => _SafeZoneScreenState();
}

class _SafeZoneScreenState extends State<SafeZoneScreen> {
  List<Map<String, dynamic>> safeZones = [];
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'University', 'Public', 'Medical', 'Police'];

  @override
  void initState() {
    super.initState();
    _loadSafeZoneData();
  }

  void _loadSafeZoneData() async {
    final data = await MockDataService.loadMockData();
    setState(() {
      safeZones = List<Map<String, dynamic>>.from(
        data['safeZones'] ?? _getDefaultSafeZones()
      );
    });
  }

  List<Map<String, dynamic>> _getDefaultSafeZones() {
    return [
      {
        'id': '1',
        'name': 'University Security Office',
        'category': 'University',
        'address': 'Main Campus, Ground Floor, Admin Building',
        'phone': '+880-2-9138234',
        'latitude': 23.7465,
        'longitude': 90.3763,
        'distance': '0.2 km',
        'open_24_7': true,
        'safety_features': ['Security Guards', 'CCTV', 'Emergency Phone'],
      },
      {
        'id': '2',
        'name': 'Dhanmondi Police Station',
        'category': 'Police',
        'address': 'Road 2, Dhanmondi, Dhaka',
        'phone': '999',
        'latitude': 23.7461,
        'longitude': 90.3742,
        'distance': '0.8 km',
        'open_24_7': true,
        'safety_features': ['Police Officers', 'Emergency Response', '24/7 Service'],
      },
      {
        'id': '3',
        'name': 'Square Hospital',
        'category': 'Medical',
        'address': '18/F, Bir Uttam Qazi Nuruzzaman Sarak, Dhaka',
        'phone': '+880-2-8159457',
        'latitude': 23.7508,
        'longitude': 90.3734,
        'distance': '1.2 km',
        'open_24_7': true,
        'safety_features': ['Medical Staff', 'Emergency Care', 'Ambulance Service'],
      },
      {
        'id': '4',
        'name': 'Student Counseling Center',
        'category': 'University',
        'address': 'Campus, 2nd Floor, Student Services Building',
        'phone': '+880-2-9138234',
        'latitude': 23.7469,
        'longitude': 90.3759,
        'distance': '0.3 km',
        'open_24_7': false,
        'safety_features': ['Professional Counselors', 'Mental Health Support', 'Crisis Intervention'],
      },
      {
        'id': '5',
        'name': 'Community Center',
        'category': 'Public',
        'address': 'Dhanmondi 8/A, Community Hall',
        'phone': '+880-2-8613579',
        'latitude': 23.7445,
        'longitude': 90.3721,
        'distance': '0.9 km',
        'open_24_7': false,
        'safety_features': ['Public Shelter', 'Community Support', 'Meeting Point'],
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final filteredZones = selectedCategory == 'All'
        ? safeZones
        : safeZones.where((zone) => zone['category'] == selectedCategory).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Safe Zones'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(LucideIcons.arrowLeft),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Header
          Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade400,
                  Colors.teal.shade400,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Icon(
                  LucideIcons.shield,
                  color: Colors.white,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Find Safe Zones',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Locate nearby safe places and emergency shelters',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = category == selectedCategory;
                
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedCategory = category;
                      });
                    },
                    backgroundColor: Colors.transparent,
                    selectedColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                    checkmarkColor: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Safe Zones List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: filteredZones.length,
              itemBuilder: (context, index) {
                return _buildSafeZoneCard(filteredZones[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Opening map view...'),
              backgroundColor: Colors.green,
            ),
          );
        },
        icon: const Icon(LucideIcons.map),
        label: const Text('Map View'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildSafeZoneCard(Map<String, dynamic> zone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(zone['category']).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getCategoryIcon(zone['category']),
                      color: _getCategoryColor(zone['category']),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          zone['name'],
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(zone['category']).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            zone['category'],
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: _getCategoryColor(zone['category']),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (zone['open_24_7'] == true)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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

              const SizedBox(height: 16),

              Row(
                children: [
                  Icon(
                    LucideIcons.mapPin,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      zone['address'],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Icon(
                    LucideIcons.navigation,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    zone['distance'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Safety Features
              Text(
                'Safety Features:',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: (zone['safety_features'] as List).map<Widget>((feature) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      feature,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Calling ${zone['name']}...')),
                        );
                      },
                      icon: const Icon(LucideIcons.phone, size: 16),
                      label: const Text('Call'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Getting directions to ${zone['name']}...')),
                        );
                      },
                      icon: const Icon(LucideIcons.navigation, size: 16),
                      label: const Text('Directions'),
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

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'University':
        return Colors.blue;
      case 'Police':
        return Colors.indigo;
      case 'Medical':
        return Colors.red;
      case 'Public':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'University':
        return LucideIcons.graduationCap;
      case 'Police':
        return LucideIcons.shield;
      case 'Medical':
        return LucideIcons.cross;
      case 'Public':
        return LucideIcons.building;
      default:
        return LucideIcons.mapPin;
    }
  }
}
