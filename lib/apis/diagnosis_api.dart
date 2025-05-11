import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:breathing_analysis_app/constants/appwrite_constants.dart';
import 'package:breathing_analysis_app/core/core.dart';
import 'package:breathing_analysis_app/models/diagnosis_model.dart';
import 'package:fpdart/fpdart.dart';

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
        documentId: diagnosis.uid,
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
