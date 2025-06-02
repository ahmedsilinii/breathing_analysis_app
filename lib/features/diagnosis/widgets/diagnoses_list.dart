import 'package:breathing_analysis_app/common/loading_page.dart';
import 'package:breathing_analysis_app/features/diagnosis/controller/diagnosis_controller.dart';
import 'package:breathing_analysis_app/features/diagnosis/views/diagnosis_details.dart';
import 'package:breathing_analysis_app/features/diagnosis/widgets/diagnosis_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiagnosesList extends ConsumerWidget {
  const DiagnosesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserDiagnosesProvider).when(
      data: (diagnoses) {
      if (diagnoses.isEmpty) {
        return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.sentiment_dissatisfied, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            'No diagnoses found',
            style: TextStyle(
            fontSize: 20,
            color: Colors.grey[700],
            fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You have not made any diagnoses yet.',
            style: TextStyle(
            fontSize: 16,
            color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
          ],
        ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
          'Your Previous Diagnoses',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
        Expanded(
          child: ListView.builder(
          itemCount: diagnoses.length,
          itemBuilder: (context, index) {
            final diagnosis = diagnoses[index];
            return DiagnosisCard(
            diagnosis: diagnosis,
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                  DiagnosisDetails(diagnosis: diagnosis),
              ),
              );
            },
            );
          },
          ),
        ),
        ],
      );
      },
      error: (err, stack) {
      return Center(child: Text('Error: $err'));
      },
      loading: () => const Loader(),
    );
}
}