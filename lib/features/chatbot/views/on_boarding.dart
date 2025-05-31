import 'package:breathing_analysis_app/constants/assets_constants.dart';
import 'package:breathing_analysis_app/features/chatbot/views/chatbot.dart';
import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Onboarding extends StatelessWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => const Onboarding());
  }

  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(
              AssetsConstants.breathingLogo,
              // ignore: deprecated_member_use
              color: Palette.blueColor,
              height: 30,
            ),
          ),
        ],
        backgroundColor: Palette.backgroundColor,
      ),
      backgroundColor: Colors.white, // <-- Force white background here

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  'Using this software, you can ask you questions and receive articles using artificial intelligence assistant',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 32),
            Image.asset('assets/svgs/onboarding.png'),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, ChatBotView.route());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Continue'),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
