import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 24,
      left: 24,
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
        elevation: 4,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(24),
          child: const Padding(
            padding: EdgeInsets.all(12),
            child: Icon(FeatherIcons.arrowLeft, size: 20),
          ),
        ),
      ),
    );
  }
}
