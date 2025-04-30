import 'package:breathing_analysis_app/apis/auth_api.dart';
import 'package:breathing_analysis_app/common/error_page.dart';
import 'package:breathing_analysis_app/common/loading_page.dart';
import 'package:breathing_analysis_app/features/auth/view/signup_view.dart';
import 'package:breathing_analysis_app/features/home/view/home_view.dart';
import 'package:breathing_analysis_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: ref
          .watch(currentUserAccountProvider)
          .when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              } else {
                return const SignupView();
              }
            },
            error: (errorMessage, st) => ErrorPage(errorMessage: errorMessage.toString()),
            loading: () => const LoadingPage(),
          ),
    );
  }
}
