import 'package:breathing_analysis_app/apis/auth_api.dart';
import 'package:breathing_analysis_app/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  return AuthController(authAPI: ref.watch(AuthAPIProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI}) : _authAPI = authAPI, super(false);
  // state = isLoading

  void singUp({
    required email,
    required password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    // ignore: avoid_print
    res.fold((l) => showSnackBar(context, l.message), (r) => print(r.email));
  }
}
