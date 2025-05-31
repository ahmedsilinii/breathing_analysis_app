// ignore_for_file: must_be_immutable

import 'package:breathing_analysis_app/common/error_page.dart';
import 'package:breathing_analysis_app/common/loading_page.dart';
import 'package:breathing_analysis_app/constants/constants.dart';
import 'package:breathing_analysis_app/features/auth/controller/auth_controller.dart';
import 'package:breathing_analysis_app/features/chatbot/views/on_boarding.dart';
import 'package:breathing_analysis_app/features/diagnosis/widgets/diagnosis_button.dart';
import 'package:breathing_analysis_app/models/diagnosis_model.dart';
import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:open_file/open_file.dart';

class DiagnosisDetails extends ConsumerWidget {
  DiagnosisModel diagnosis;

  static Route route({required DiagnosisModel diagnosis}) => MaterialPageRoute(
    builder: (context) => DiagnosisDetails(diagnosis: diagnosis),
  );

  DiagnosisDetails({super.key, required this.diagnosis});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserDetailsProvider);

    if (userAsync.isLoading) {
      return const Loader();
    }
    if (userAsync.hasError) {
      return ErrorPage(errorMessage: userAsync.error.toString());
    }
    final user = userAsync.value;

    if (user == null) {
      return ErrorPage(errorMessage: "User not found.");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnosis Details'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(
              AssetsConstants.breathingLogo,
              // ignore: deprecated_member_use
              color: Palette.blueColor,
              height: 30,
            ),
          ),
        ],
        backgroundColor: Palette.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Patient: ${user.name}',
              style: const TextStyle(
                fontSize: 18,
                color: Palette.whiteColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Diagnosis Date: ${diagnosis.diagnosedAt}',
              style: const TextStyle(fontSize: 16, color: Palette.whiteColor),
            ),
            const SizedBox(height: 16),
            Text(
              'Result: ${diagnosis.results[0]}',
              style: const TextStyle(fontSize: 16, color: Palette.whiteColor),
            ),
            const SizedBox(height: 16),
            if (diagnosis.medicalReportLink != null)
              DiagnosisButton(
                onPressed: () {
                  OpenFile.open(diagnosis.medicalReportLink!);
                },
                icon: Icons.picture_as_pdf,
                label: 'View Attached Report',
              ),
            const Spacer(),
            Text(
              'For more information about your results, you can consult our AI assistant below.',
              style: const TextStyle(fontSize: 14, color: Palette.whiteColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to AI Assistant page
                  Navigator.push(context, Onboarding.route());
                },
                icon: const Icon(
                  Icons.chat_bubble_outline,
                  color: Palette.whiteColor,
                ),
                label: const Text(
                  'Consult AI Assistant',
                  style: TextStyle(
                    color: Palette.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.blueColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 4,
                  shadowColor: Palette.blueColor.withOpacity(0.3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
