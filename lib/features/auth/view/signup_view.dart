import 'package:breathing_analysis_app/common/common.dart';
import 'package:breathing_analysis_app/constants/constants.dart';
import 'package:breathing_analysis_app/features/auth/controller/auth_controller.dart';
import 'package:breathing_analysis_app/features/auth/view/login_view.dart';
import 'package:breathing_analysis_app/features/auth/widgets/auth_field.dart';
import 'package:breathing_analysis_app/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupView extends ConsumerStatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => const SignupView());
  }

  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  void onSignUp() {
    ref
        .read(authControllerProvider.notifier)
        .singUp(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body:
          isLoading
              ? Loader()
              : Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      AuthField(
                        obscureText: 'false',
                        controller: emailController,
                        hintText: 'Email ',
                      ),
                      const SizedBox(height: 25),
                      AuthField(
                        obscureText: 'true',
                        controller: passwordController,
                        hintText: 'Password',
                      ),
                      const SizedBox(height: 25),
                      AuthField(
                        obscureText: 'true',
                        controller: confirmPasswordController,
                        hintText: 'Confirm Password',
                      ),
                      const SizedBox(height: 40),
                      Align(
                        alignment: Alignment.topRight,
                        child: RoundedSmallButton(
                          onTap: onSignUp,
                          label: 'Done',
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                          text: 'Already have an account?',
                          style: const TextStyle(
                            color: Palette.greyColor,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: ' Login',
                              style: const TextStyle(
                                color: Palette.blueColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer:
                                  TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacement(
                                        context,
                                        LoginView.route(),
                                      );
                                    },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
