import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:breathing_analysis_app/constants/appwrite_constants.dart';
import 'package:breathing_analysis_app/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storageAPIProvider = Provider<StorageApi>((ref) {
  final storage = ref.watch(appWriteStorageProvider);
  return StorageApi(storage: storage);
});

class StorageApi {
  final Storage _storage;

  StorageApi({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadFiles(List<File> files, String bucketId) async {
    List<String> fileIds = [];
    for (var file in files) {
      try {
        final response = await _storage.createFile(
          bucketId: bucketId,
          fileId: ID.unique(),
          file: InputFile.fromPath(path: file.path),
        );
        fileIds.add(response.$id);
      } on AppwriteException catch (e) {
        // ignore: avoid_print
        print('Failed to upload file: ${e.message}');
      }
    }
    return fileIds;
  }

  Future<List<String>> uploadMedicalReports (List<File> files) {
    return uploadFiles(files, AppwriteConstants.medicalReportsBuckedId);
  }

  Future<List<String>> uploadBreathingRecords (List<File> files) {
    return uploadFiles(files, AppwriteConstants.breathingRecordsBucketId);
  }
}
