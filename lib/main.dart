import 'package:breathing_analysis_app/apis/auth_api.dart';
import 'package:breathing_analysis_app/common/error_page.dart';
import 'package:breathing_analysis_app/common/loading_page.dart';
import 'package:breathing_analysis_app/features/auth/view/login_view.dart';
import 'package:breathing_analysis_app/features/home/view/home_view.dart';
import 'package:breathing_analysis_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Breathing Analysis App',
      theme: AppTheme.theme,
      home: ref
          .watch(currentUserAccountProvider)
          .when(
            data: (user) {
              if (user != null) {
                return const HomeView();
              }
              return const LoginView();
            },
            error:
                (errorMessage, st) =>
                    ErrorPage(errorMessage: errorMessage.toString()),
            loading: () => const LoadingPage(),
          ),
    );
  }
}
