import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:breathing_analysis_app/models/diagnosis_model.dart';

// ignore: must_be_immutable
class DiagnosisCard extends StatelessWidget {
  DiagnosisModel diagnosis;
  final VoidCallback _onTap;
  DiagnosisCard({
    super.key,
    required this.diagnosis,
    required VoidCallback onTap,
  }) : _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.medical_services,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          diagnosis.results[0],
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(diagnosis.diagnosedAt),
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.blue),
        onTap: _onTap,
      ),
    );
  }
}
