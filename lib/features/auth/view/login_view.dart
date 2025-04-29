import 'package:breathing_analysis_app/common/rounded_small_button.dart';
import 'package:breathing_analysis_app/constants/ui_constants.dart';
import 'package:breathing_analysis_app/features/auth/controller/auth_controller.dart';
import 'package:breathing_analysis_app/features/auth/view/signup_view.dart';
import 'package:breathing_analysis_app/features/auth/widgets/auth_field.dart';
import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => const LoginView());
  }

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
    ref
        .read(authControllerProvider.notifier)
        .login(
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              AuthField(controller: emailController, hintText: 'Email '),
              const SizedBox(height: 25),
              AuthField(controller: passwordController, hintText: 'Password'),
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.topRight,
                child: RoundedSmallButton(onTap: onLogin, label: 'Done'),
              ),
              const SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account?',
                  style: const TextStyle(
                    color: Pallete.greyColor,
                    fontSize: 16,
                  ),
                  children: [
                    TextSpan(
                      text: ' Sign Up',
                      style: const TextStyle(
                        color: Pallete.blueColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context, SignupView.route());
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
