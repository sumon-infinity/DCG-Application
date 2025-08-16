import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:dcg_flutter/components/app_button.dart';
import 'package:dcg_flutter/components/app_card.dart';

class MedicalAlertScreen extends StatefulWidget {
  const MedicalAlertScreen({super.key});

  @override
  State<MedicalAlertScreen> createState() => _MedicalAlertScreenState();
}

class _MedicalAlertScreenState extends State<MedicalAlertScreen> {
  final _formKey = GlobalKey<FormState>();
  final _symptomsController = TextEditingController();
  String? _selectedCondition;
  bool _isUrgent = false;

  final _conditions = [
    'Asthma',
    'Diabetes',
    'Heart Condition',
    'Allergic Reaction',
    'Injury',
    'Other',
  ];

  @override
  void dispose() {
    _symptomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FeatherIcons.arrowLeft),
          onPressed: () => context.go('/home'),
        ),
        title: const Text('Medical Alert'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Medical Emergency',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Condition',
                        border: OutlineInputBorder(),
                      ),
                      value: _selectedCondition,
                      items: _conditions
                          .map(
                            (condition) => DropdownMenuItem(
                              value: condition,
                              child: Text(condition),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCondition = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a condition';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _symptomsController,
                      decoration: const InputDecoration(
                        labelText: 'Symptoms',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please describe your symptoms';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Urgent Care Needed'),
                      value: _isUrgent,
                      onChanged: (value) {
                        setState(() {
                          _isUrgent = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      text: 'Send Medical Alert',
                      backgroundColor: Colors.red,
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // TODO: Implement medical alert sending
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Medical Alert Sent'),
                              content: const Text(
                                'Medical services have been notified. Please stay where you are and wait for assistance.',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        }
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
                      'Emergency Medical Contacts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _MedicalContactTile(
                      title: 'Campus Medical Center',
                      phone: '123-456-7890',
                      onTap: () {
                        // TODO: Implement phone call
                      },
                    ),
                    _MedicalContactTile(
                      title: 'Emergency Room',
                      phone: '911',
                      onTap: () {
                        // TODO: Implement phone call
                      },
                    ),
                    _MedicalContactTile(
                      title: 'Campus Nurse',
                      phone: '123-456-7891',
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
      ),
    );
  }
}

class _MedicalContactTile extends StatelessWidget {
  final String title;
  final String phone;
  final VoidCallback onTap;

  const _MedicalContactTile({
    required this.title,
    required this.phone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(FeatherIcons.phone),
      title: Text(title),
      subtitle: Text(phone),
      trailing: IconButton(
        icon: const Icon(FeatherIcons.phoneCall),
        onPressed: onTap,
      ),
    );
  }
}
