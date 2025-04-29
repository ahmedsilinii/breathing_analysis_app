import 'package:appwrite/appwrite.dart';
import 'package:breathing_analysis_app/core/core.dart';

// get user account --> Account from appwrite
// want to access user related data --> model.Account

abstract class IAuthAPI {
  FutureEither<Account> signUp({
    required String email,
    required String password,
  });
}

class AuthAPI implements IAuthAPI {
  final Account _account;

  AuthAPI({required Account account}) : _account = account;

  @override
  FutureEither<Account> signUp({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }
}
