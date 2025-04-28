import 'package:breathing_analysis_app/features/auth/view/login_view.dart';
import 'package:breathing_analysis_app/features/auth/view/signup_view.dart';
import 'package:breathing_analysis_app/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: const SignupView(),
    );
  }
}
