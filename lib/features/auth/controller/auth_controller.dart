import 'package:appwrite/models.dart';
import 'package:breathing_analysis_app/apis/auth_api.dart';
import 'package:breathing_analysis_app/apis/user_api.dart';
import 'package:breathing_analysis_app/core/utils.dart';
import 'package:breathing_analysis_app/features/auth/view/login_view.dart';
import 'package:breathing_analysis_app/features/home/view/home_view.dart';
import 'package:breathing_analysis_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authControllerProvider = StateNotifierProvider<AuthController, bool>((
  ref,
) {
  return AuthController(
    authAPI: ref.watch(authAPIProvider),
    userAPI: ref.watch(userAPIProvider),
  );
});

final currrentUserAccountProvider = FutureProvider((ref) async {
  return ref.watch(authControllerProvider.notifier).currentUser();
});

class AuthController extends StateNotifier<bool> {
  final UserAPI _userAPI;
  final AuthAPI _authAPI;
  AuthController({required AuthAPI authAPI, required UserAPI userAPI})
    : _authAPI = authAPI,
      _userAPI = userAPI,
      super(false);
  // state = isLoading

  Future<User?> currentUser() => _authAPI.currentUserAccount();

  void singUp({
    required email,
    required password,
    required BuildContext context,
  }) async {
    state = true;
    final res = await _authAPI.signUp(email: email, password: password);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) async {
      UserModel user = UserModel(
        email: email,
        name: email.split('@')[0],
        followers: [],
        following: [],
        profilePicture: '',
        bannerPic: '',
        bio: '',
        uid: r.$id,
        isDoctor: false,
      );
      final res2 = await _userAPI.saveUserData(user);
      res2.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, 'Account created successfully! Please login.');
        Navigator.push(context, LoginView.route());
      });
    });
  }

  void login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = true;

    try {
      // Check for an active session
      final session = await _authAPI.getSession();
      if (session != null) {
        // Delete the active session
        await _authAPI.deleteSession();
      }

      // Create a new session
      final res = await _authAPI.login(email: email, password: password);
      state = false;

      res.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, 'Login successful!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeView()),
        );
      });
    } catch (e) {
      state = false;
      showSnackBar(context, e.toString());
    }
  }
}
