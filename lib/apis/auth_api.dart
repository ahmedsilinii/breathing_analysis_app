import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:breathing_analysis_app/core/core.dart';
import 'package:breathing_analysis_app/core/providers.dart';
import 'package:breathing_analysis_app/features/auth/controller/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

// get user account --> Account from appwrite
// want to access user related data --> model.Account (old version) --> User (new version)

final authAPIProvider = Provider((ref) {
  return AuthAPI(account: ref.watch(appwriteAccountProvider));
});

final currentUserAccountProvider = FutureProvider((ref) async {
  return ref.watch(authControllerProvider.notifier).currentUser();
});

abstract class IAuthAPI {
  FutureEither<User> signUp({required String email, required String password});
  FutureEither<Session> login({
    required String email,
    required String password,
  });
  Future<User?> currentUserAccount();
}

class AuthAPI implements IAuthAPI {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;

  Future<Session?> getSession() async {
    // Implement the logic to retrieve the current session
    try {
      // Example implementation
      return await _account.getSession(sessionId: 'current');
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteSession() async {
    // Implement the logic to delete the current session
    try {
      await _account.deleteSession(sessionId: 'current');
    } catch (e) {
      // Handle error if needed
    }
  }

  @override
  Future<User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

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

  @override
  FutureEither<Session> login({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(message: e.message ?? 'Unknown error', stackTrace: stackTrace),
      );
    } catch (e, stackTrace) {
      return left(Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }
}
