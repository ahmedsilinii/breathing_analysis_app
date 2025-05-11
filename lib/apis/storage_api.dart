import 'dart:io';

import 'package:appwrite/appwrite.dart';

class StorageApi {
  final Storage _storage;

  StorageApi({required Storage storage}) : _storage = storage;

  Future<List<String>> uploadFiles(List<File> files) async {
    List<String> fileIds = [];
    for (var file in files) {
      try {
        final response = await _storage.createFile(
          bucketId: 'your_bucket_id',
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
}
