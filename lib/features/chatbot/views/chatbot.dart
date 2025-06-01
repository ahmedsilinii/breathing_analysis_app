import 'package:breathing_analysis_app/constants/assets_constants.dart';
import 'package:breathing_analysis_app/models/messsage_model.dart';
import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatBotView extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const ChatBotView());
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final TextEditingController _controller = TextEditingController();

  final List<Message> _messages = [
    Message(text: "Hello! How can I assist you today?", isUser: false),
  ];

  callGeminiModel() async {
    try {
      final prompt = _controller.text.trim();

      if (prompt.isEmpty) return;

      setState(() {
        _messages.add(Message(text: prompt, isUser: true));
      });

      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: dotenv.env['API_KEY']!,
        safetySettings: [
          SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
        ],
      );

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      setState(() {
        _messages.add(Message(text: response.text!, isUser: false));
      });

      _controller.clear();
    } catch (e) {
      setState(() {
        _messages.add(Message(text: 'An error occurred: $e', isUser: false));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('AI Assistant'),
          ],
        ),
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
      body: Column(
        children: [
          //msg list
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment:
                        message.isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: message.isUser ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: message.isUser ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          //input field
          Padding(
            padding: const EdgeInsets.only(
              bottom: 32.0,
              left: 16.0,
              right: 16.0,
            ),

            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        hintText: "Type a message",
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: callGeminiModel,
                      child: Image.asset('assets/svgs/send.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
