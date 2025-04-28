import 'package:breathing_analysis_app/common/common.dart';
import 'package:breathing_analysis_app/constants/constants.dart';
import 'package:breathing_analysis_app/features/auth/view/login_view.dart';
import 'package:breathing_analysis_app/features/auth/widgets/auth_field.dart';
import 'package:breathing_analysis_app/theme/theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignupView extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => const SignupView());
  }
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
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
                child: RoundedSmallButton(onTap: () {}, label: 'Done'),
              ),
              const SizedBox(height: 20),
              RichText(text: TextSpan(
                text: 'Already have an account?',
                style: const TextStyle(
                  color: Pallete.greyColor,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: ' Login',
                    style: const TextStyle(
                      color: Pallete.blueColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          LoginView.route(), 
                        );
                      },
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
