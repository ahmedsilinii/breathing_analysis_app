import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:flutter/material.dart';

class DiagnosisButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const DiagnosisButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Palette.blueColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}


