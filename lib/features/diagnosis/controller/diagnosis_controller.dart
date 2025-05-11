import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:record/record.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class DiagnosisState {
  final bool isLoading;
  final bool isRecording;
  final String? recordingPath;
  final String? pdfPath;

  DiagnosisState({
    this.isLoading = false,
    this.isRecording = false,
    this.recordingPath,
    this.pdfPath,
  });

  DiagnosisState copyWith({
    bool? isRecording,
    String? recordingPath,
    String? pdfPath,
    bool? isLoading,
  }) {
    return DiagnosisState(
      isRecording: isRecording ?? this.isRecording,
      isLoading: isLoading ?? this.isLoading,
      recordingPath: recordingPath ?? this.recordingPath,
      pdfPath: pdfPath ?? this.pdfPath,
    );
  }
}

class DiagnosisController extends StateNotifier<DiagnosisState> {
  final AudioRecorder audioRecorder = AudioRecorder();

  DiagnosisController() : super(DiagnosisState());

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  Future<void> record(Function(String) showSnackBar) async {
    if (state.isRecording) {
      String? filePath = await audioRecorder.stop();
      if (filePath != null) {
        state = state.copyWith(isRecording: false, recordingPath: filePath);
        showSnackBar('Recording stopped.');
      }
    } else {
      if (await audioRecorder.hasPermission()) {
        final Directory appDocumentsDir = await getApplicationCacheDirectory();
        //ken t7eb tsajel kol recording
        //final String filePath = '${appDocumentsDir.path}/breath_recording_${DateTime.now().millisecondsSinceEpoch}.wav';
        //sinon override every recording
        final String filePath = '${appDocumentsDir.path}/breath_recording.wav';
        await audioRecorder.start(const RecordConfig(), path: filePath);
        state = state.copyWith(isRecording: true, recordingPath: null);
        showSnackBar('Recording started. Tap again to stop.');
      }
    }
  }

  Future<void> upload(Function(String) showSnackBar) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
      allowMultiple: false,
    );
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      final filePath = file.path;
      if (filePath != null) {
        state = state.copyWith(pdfPath: filePath);
        showSnackBar('File selected: ${file.name}');
        //openFile(file);
      } else {
        showSnackBar('Failed to get file path.');
      }
    } else {
      showSnackBar('No file selected.');
    }
  }

  void diagnose(Function(String) showSnackBar) {
    if (state.recordingPath != null) {
      // state = state.copyWith(isLoading: true);
      showSnackBar('Diagnosis submitted.');
    } else {
      showSnackBar('Please record your breath first.');
    }
  }
}

final diagnosisControllerProvider =
    StateNotifierProvider<DiagnosisController, DiagnosisState>(
      (ref) => DiagnosisController(),
    );
