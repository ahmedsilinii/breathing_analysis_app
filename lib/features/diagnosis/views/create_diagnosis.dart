import 'dart:io';

import 'package:breathing_analysis_app/common/loading_page.dart';
import 'package:breathing_analysis_app/constants/constants.dart';
import 'package:breathing_analysis_app/core/utils.dart';
import 'package:breathing_analysis_app/features/auth/controller/auth_controller.dart';
import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class CreateDiagnosisScreen extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const CreateDiagnosisScreen());
  const CreateDiagnosisScreen({super.key});

  @override
  ConsumerState<CreateDiagnosisScreen> createState() =>
      _CreateDiagnosisScreenState();
}

class _CreateDiagnosisScreenState extends ConsumerState<CreateDiagnosisScreen> {
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
      showSnackBar(context, 'File selected: ${file.name}');
      } else {
      showSnackBar(context, 'Failed to get file path.');
      }
    } else {
      showSnackBar(context, 'No file selected.');
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
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Palette.blueColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                      ),
                      onPressed: _onRecord,
                      icon: Icon(isRecording ? Icons.stop : Icons.mic),
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
                      onPressed: _onUpload,
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
                      onPressed: _onUpload,
                      child: const Text('Diagnose'),
                    ),
                  ],
                ),
              ),
    );
  }
}
