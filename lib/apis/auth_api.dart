import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:breathing_analysis_app/core/core.dart';
import 'package:breathing_analysis_app/core/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

// get user account --> Account from appwrite
// want to access user related data --> model.Account (old version) --> User (new version)

final AuthAPIProvider = Provider((ref) {
  return AuthAPI(account: ref.watch(appwriteAccountProvider));
});

abstract class IAuthAPI {
  FutureEither<User> signUp({required String email, required String password});
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;
  
  @override
  FutureEither<User> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(account);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(message: e.message ?? 'Unknown error', stackTrace: stackTrace),
      );
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }
}
