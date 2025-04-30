import 'package:appwrite/appwrite.dart';
import 'package:breathing_analysis_app/constants/appwrite_constants.dart';
import 'package:breathing_analysis_app/core/failure.dart';
import 'package:breathing_analysis_app/core/type_defs.dart';
import 'package:breathing_analysis_app/models/user_model.dart';
import 'package:fpdart/fpdart.dart';

abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);
}

class UserAPI implements IUserAPI {
  final Databases _db;

  UserAPI({required Databases db}) : _db = db;

  @override
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollectionId,
        documentId: ID.unique(),
        data: userModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(Failure(message: 'Failed to save user data', stackTrace: st));
    } catch (e, st) {
      return left(Failure(message: e.toString(), stackTrace: st));
    }
  }
}
