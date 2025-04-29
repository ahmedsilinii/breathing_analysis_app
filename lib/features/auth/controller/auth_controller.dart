import 'package:breathing_analysis_app/apis/auth_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    res.fold((l)=> null, (r)=> print(r.name));
  }
}
