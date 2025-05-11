import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file/open_file.dart';

class DiagnosisController extends StateNotifier<bool> {
  DiagnosisController() : super(false);

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }

  void diagnose({
    File? medicalReport,
    required File breath,
    required BuildContext context,
  }) {}
}
