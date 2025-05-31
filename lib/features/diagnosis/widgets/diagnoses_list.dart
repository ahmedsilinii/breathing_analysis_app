import 'package:breathing_analysis_app/common/loading_page.dart';
import 'package:breathing_analysis_app/features/diagnosis/controller/diagnosis_controller.dart';
import 'package:breathing_analysis_app/features/diagnosis/widgets/diagnosis_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DiagnosesList extends ConsumerWidget {
  const DiagnosesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(getUserDiagnosesProvider)
        .when(
          data:
              (diagnoses) => ListView.builder(
                reverse: true,
                itemCount: diagnoses.length,
                itemBuilder: (context, index) {
                  final diagnosis = diagnoses[index];
                  return DiagnosisCard(diagnosis: diagnosis, onTap: () {});
                },
              ),
          error: (err, stack) {
            return Center(child: Text('Error: $err'));
          },
          loading: () => const Loader(),
        );
  }
}
