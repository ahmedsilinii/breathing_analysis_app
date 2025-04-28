import 'package:breathing_analysis_app/constants/ui_constants.dart';
import 'package:breathing_analysis_app/features/auth/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
    return  Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            AuthField(controller: emailController, hintText: 'Email '),
            const SizedBox(height: 20),
            AuthField(controller: passwordController, hintText: 'Password'),

          ],
        ),
        
      )
    );
  }
}