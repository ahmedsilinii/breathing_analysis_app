import 'package:breathing_analysis_app/common/loading_page.dart';
import 'package:breathing_analysis_app/features/diagnosis/controller/diagnosis_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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
                    return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: ListTile(

                      leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.medical_services, color: Theme.of(context).primaryColor),
                      ),
                      title: Text(
                      diagnosis.results[0],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                      ),
                      subtitle: Text(
                      DateFormat.yMMMd().format(diagnosis.diagnosedAt),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      ),
                      trailing: const Icon(Icons.chevron_right, color: Colors.blue),
                      onTap: () {},
                    ),
                    );
                },
              ),
          error: (err, stack) {
            print('Error fetching diagnoses: $err');
            return Center(child: Text('Error: $err'));
          },
          loading: () => const Loader(),
        );
  }
}
