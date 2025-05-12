import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:breathing_analysis_app/constants/appwrite_constants.dart';
import 'package:breathing_analysis_app/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final StorageAPIProvider = Provider<StorageAPI>((ref) {
  final storage = ref.watch(appWriteStorageProvider);
  return StorageAPI(storage: storage);
});

class StorageAPI {
  final Storage _storage;

  StorageAPI({required Storage storage}) : _storage = storage;

  Future<String> uploadFile(File file, String bucketId) async {
    try {
      final response = await _storage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromPath(path: file.path),
      );
      return AppwriteConstants.fileURL(response.$id, bucketId);
    } on AppwriteException catch (e) {
      // ignore: avoid_print
      print('Failed to upload file: ${e.message}');
      return '';
    }
  }

  Future<String> uploadMedicalReport(File file) {
    return uploadFile(file, AppwriteConstants.medicalReportsBuckedId);
  }

  Future<String> uploadBreathingRecords(File file) {
    return uploadFile(file, AppwriteConstants.breathingRecordsBucketId);
  }
}
