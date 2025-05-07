import 'package:breathing_analysis_app/constants/constants.dart';
import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateDiagnosisScreen extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateDiagnosisScreen());
  const CreateDiagnosisScreen({super.key});

  @override
  ConsumerState<CreateDiagnosisScreen> createState() =>
      _CreateDiagnosisScreenState();
}

class _CreateDiagnosisScreenState extends ConsumerState<CreateDiagnosisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SvgPicture.asset(
              AssetsConstants.breathingLogo,
              // ignore: deprecated_member_use
              color: Palette.blueColor,
              height: 30,
            ),
            const SizedBox(width: 20),
            const Text('New Diagnosis'),
          ],
        ),
        backgroundColor: Palette.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Record your breath to analyze potential respiratory issues.\nFor enhanced accuracy, you can also attach a medical report, if you have one available.',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16.0, color: Palette.whiteColor),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.blueColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                // TODO: Implement recording functionality
              },
              icon: const Icon(Icons.mic),
              label: const Text('Record Breath'),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.blueColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                // TODO: Implement file attachment functionality
              },
              icon: const Icon(Icons.attach_file),
              label: const Text('Attach Medical Report'),
            ),
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.blueColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              onPressed: () {
                // TODO: Implement diagnosis functionality
              },
              child: const Text('Diagnose'),
            ),
          ],
        ),
      ),
    );
  }
}
