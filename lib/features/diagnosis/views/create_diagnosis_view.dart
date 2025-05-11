import 'dart:io';

import 'package:breathing_analysis_app/common/loading_page.dart';
import 'package:breathing_analysis_app/constants/constants.dart';
import 'package:breathing_analysis_app/core/utils.dart';
import 'package:breathing_analysis_app/features/auth/controller/auth_controller.dart';
import 'package:breathing_analysis_app/features/diagnosis/widgets/diagnosis_button.dart';
import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class CreateDiagnosisView extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateDiagnosisView());
  const CreateDiagnosisView({super.key});

  @override
  ConsumerState<CreateDiagnosisView> createState() =>
      _CreateDiagnosisViewState();
}

class _CreateDiagnosisViewState extends ConsumerState<CreateDiagnosisView> {
  bool isRecording = false;
  final audioRecorder = AudioRecorder();
  String? recordingPath;
  String? pdfPath;

 
  Future<void> _onRecord() async {
    if (isRecording) {
      String? filePath = await audioRecorder.stop();
      if (filePath != null) {
        setState(() {
          isRecording = false;
          recordingPath = filePath;
        });
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'Recording stopped.');
      }
    } else {
      if (await audioRecorder.hasPermission()) {
        final Directory appDocumentsDir = await getApplicationCacheDirectory();
        //ken t7eb tsajel kol recording
        //final String filePath = '${appDocumentsDir.path}/breath_recording_${DateTime.now().millisecondsSinceEpoch}.wav';
        //sinon override every recording
        final String filePath = '${appDocumentsDir.path}/breath_recording.wav';
        await audioRecorder.start(const RecordConfig(), path: filePath);
        setState(() {
          isRecording = true;
          recordingPath = null;
        });
        showSnackBar(
          // ignore: use_build_context_synchronously
          context,
          'Recording started. Tap again to stop.',
        );
      }
    }
  }

  Future<void> _onUpload() async {
    final result = FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );

    final picked = await result;
    if (picked != null && picked.files.isNotEmpty) {
      final file = picked.files.first;
      final filePath = file.path;
      if (filePath != null) {
        setState(() {
          pdfPath = filePath;
        });
        // openFile(file);
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'File selected: ${file.name}');
      } else {
        // ignore: use_build_context_synchronously
        showSnackBar(context, 'Failed to get file path.');
      }
    } else {
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'No file selected.');
    }
  }

  void _onDiagnose() {
    if (recordingPath != null) {
      // Handle the diagnosis submission
      // You can use the recordingPath and pdfPath as needed
      showSnackBar(context, 'Diagnosis submitted.');
    } else {
      showSnackBar(context, 'Please record your breath first.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currrentUserAccountProvider).value;

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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.blueColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      onPressed: _onDiagnose,
                      child: const Text('Diagnose'),
                    ),
                  ],
                ),
              ),
    );
  }
}
