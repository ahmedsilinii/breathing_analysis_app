import 'package:breathing_analysis_app/common/loading_page.dart';
import 'package:breathing_analysis_app/constants/constants.dart';
import 'package:breathing_analysis_app/core/utils.dart';
import 'package:breathing_analysis_app/features/auth/controller/auth_controller.dart';
import 'package:breathing_analysis_app/features/diagnosis/controller/diagnosis_controller.dart';
import 'package:breathing_analysis_app/features/diagnosis/widgets/diagnosis_button.dart';
import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateDiagnosisView extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateDiagnosisView());
  const CreateDiagnosisView({super.key});

  @override
  ConsumerState<CreateDiagnosisView> createState() =>
      _CreateDiagnosisViewState();
}

class _CreateDiagnosisViewState extends ConsumerState<CreateDiagnosisView> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _onRecord() async {
    final diagnosisController = ref.read(diagnosisControllerProvider.notifier);
    await diagnosisController.record((msg) => showSnackBar(context, msg));
  }

  Future<void> _onUpload() async {
    final diagnosisController = ref.read(diagnosisControllerProvider.notifier);
    await diagnosisController.upload((msg) => showSnackBar(context, msg));
  }

  void _onDiagnose() {
    final diagnosisController = ref.read(diagnosisControllerProvider.notifier);
    diagnosisController.diagnose((msg) => showSnackBar(context, msg));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currrentUserAccountProvider).value;
    final isRecording = ref.watch(diagnosisControllerProvider).isRecording;

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Diagnosis'),
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
      body:
          currentUser == null
              ? const Loader()
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Record your breath to analyze potential respiratory issues.\nFor enhanced accuracy, you can also attach a medical report, if you have one available.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Palette.whiteColor,
                      ),
                    ),
                    const SizedBox(height: 40),
                    DiagnosisButton(
                      onPressed: _onRecord,
                      icon: isRecording ? Icons.stop : Icons.mic,
                      label: 'Record Breath',
                    ),
                    const SizedBox(height: 30),
                    DiagnosisButton(
                      onPressed: _onUpload,
                      icon: Icons.attach_file,
                      label: 'Attach Medical Report',
                    ),
                    const Spacer(),
                    DiagnosisButton(
                      onPressed: _onDiagnose,
                      icon: FontAwesomeIcons.stethoscope,
                      label: 'Diagnose',
                    ),
                  ],
                ),
              ),
    );
  }
}
