import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String errorMessage;
  const ErrorText({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage));
  }
}

class ErrorPage extends StatelessWidget {
  final String errorMessage;
  const ErrorPage({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ErrorText(errorMessage: errorMessage)
      ),
    );
  }
}