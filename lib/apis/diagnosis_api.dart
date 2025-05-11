import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:breathing_analysis_app/constants/appwrite_constants.dart';
import 'package:breathing_analysis_app/core/core.dart';
import 'package:breathing_analysis_app/models/diagnosis_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final diagnosisAPIProvider = Provider((ref) {
  return DiagnosisAPI(db: ref.watch(appwriteDatabaseProvider));
});

abstract class IDiagnosisAPI {
  FutureEither<Document> saveDiagnosis(DiagnosisModel diagnosis);
}

class DiagnosisAPI implements IDiagnosisAPI {
  final Databases _db;
  DiagnosisAPI({required Databases db}) : _db = db;

  @override
  FutureEither<Document> saveDiagnosis(DiagnosisModel diagnosis) async {
    try {
      final Document document = await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.diagnosisCollectionId,
        documentId: ID.unique(),
        data: diagnosis.toMap(),
      );
      return right(document);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(message: 'Failed to share diagnosis', stackTrace: st),
      );
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }
}
