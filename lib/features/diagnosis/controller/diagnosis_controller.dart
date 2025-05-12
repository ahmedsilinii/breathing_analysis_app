import 'dart:io';
import 'package:breathing_analysis_app/apis/diagnosis_api.dart';
import 'package:breathing_analysis_app/apis/storage_api.dart';
import 'package:breathing_analysis_app/core/utils.dart';
import 'package:breathing_analysis_app/features/auth/controller/auth_controller.dart';
import 'package:breathing_analysis_app/models/diagnosis_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:record/record.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class DiagnosisState {
  final bool isLoading;
  final bool isRecording;
  final String? recordingPath;
  final String? medicalReportPath;

  DiagnosisState({
    this.isLoading = false,
    this.isRecording = false,
    this.recordingPath,
    this.medicalReportPath,
  });

  DiagnosisState copyWith({
    bool? isRecording,
    String? recordingPath,
    String? medicalReportPath,
    bool? isLoading,
  }) {
    return DiagnosisState(
      isRecording: isRecording ?? this.isRecording,
      isLoading: isLoading ?? this.isLoading,
      recordingPath: recordingPath ?? this.recordingPath,
      medicalReportPath: medicalReportPath ?? this.medicalReportPath,
    );
  }
}

class DiagnosisController extends StateNotifier<DiagnosisState> {
  final DiagnosisAPI _diagnosisAPI;
  final StorageAPI _storageAPI;
  final AudioRecorder audioRecorder = AudioRecorder();
  final Ref _ref;

  DiagnosisController({
    required ref,
    required DiagnosisAPI diagnosisAPI,
    required StorageAPI storageAPI,
  }) : _ref = ref,
       _diagnosisAPI = diagnosisAPI,
       _storageAPI = storageAPI,
       super(DiagnosisState());

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
        final String filePath =
            '${appDocumentsDir.path}/breath_recording_${DateTime.now().millisecondsSinceEpoch}.wav';
        //sinon override every recording
        //final String filePath = '${appDocumentsDir.path}/breath_recording.wav';
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
        state = state.copyWith(medicalReportPath: filePath);
        showSnackBar('File selected: ${file.name}');
        //openFile(file);
      } else {
        showSnackBar('Failed to get file path.');
      }
    } else {
      showSnackBar('No file selected.');
    }
  }

  void diagnose({required BuildContext context}) {
    if (state.recordingPath != null) {
      state = state.copyWith(isLoading: true);
      final userAsync = _ref.watch(currentUserDetailsProvider);
      final user = userAsync.value;
      if (user == null) {
        state = state.copyWith(isLoading: false);
        showSnackBar(context, 'User not loaded. Please try again.');
        return;
      }

      if (state.medicalReportPath != null) {
        _storageAPI.uploadMedicalReport(File(state.medicalReportPath!)).then((
          medicalReportLink,
        ) {
          medicalReportLink = state.medicalReportPath!;
          if (medicalReportLink.isNotEmpty) {
            state = state.copyWith(medicalReportPath: medicalReportLink);
          } else {
            state = state.copyWith(isLoading: false);
            showSnackBar(context, 'Failed to upload medical report.');
            return;
          }
        });
      }

      _storageAPI.uploadBreathingRecords(File(state.recordingPath!)).then((
        audioLink,
      ) {
        audioLink = state.recordingPath!;
        if (audioLink.isNotEmpty) {
          state = state.copyWith(recordingPath: audioLink);
        } else {
          state = state.copyWith(isLoading: false);
          showSnackBar(context, 'Failed to upload breathing record.');
          return;
        }
      });

      DiagnosisModel diagnosis = DiagnosisModel(
        id: '',
        uid: user.uid,
        audioRecordingLink: state.recordingPath!,
        medicalReportLink: state.medicalReportPath ?? '',
        diagnosedAt: DateTime.now(),
        results: ['Waiting for results...'],
      );

      _diagnosisAPI.saveDiagnosis(diagnosis).then((result) {
        result.fold(
          (l) {
            state = state.copyWith(isLoading: false);
            showSnackBar(context, 'Failed to submit diagnosis: ${l.message}');
          },
          (r) {
            state = state.copyWith(isLoading: false);
            showSnackBar(context, 'Diagnosis submitted successfully.');
          },
        );
      });
    } else {
      showSnackBar(context, 'Please record your breath first.');
    }
  }
}

final diagnosisControllerProvider =
    StateNotifierProvider<DiagnosisController, DiagnosisState>(
      (ref) => DiagnosisController(
        ref: ref,
        diagnosisAPI: ref.watch(diagnosisAPIProvider),
        storageAPI: ref.watch(StorageAPIProvider),
      ),
    );
