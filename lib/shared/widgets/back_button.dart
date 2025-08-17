import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;
  
  const CustomBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 24,
      left: 24,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(
            LucideIcons.arrowLeft,
            size: 20,
          ),
          style: IconButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            padding: const EdgeInsets.all(12),
          ),
        ),
      ),
    );
  }
}
