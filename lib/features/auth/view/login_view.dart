import 'package:breathing_analysis_app/constants/ui_constants.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final appbar = UIConstants.appBar();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            

          ],
        ),
        
      )
    );
  }
}