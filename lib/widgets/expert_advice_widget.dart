import 'package:flutter/material.dart';
import 'package:farmwise_ai/services/gemini_chat_service.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lottie/lottie.dart';

class ExpertAdviceWidget extends StatefulWidget {
  final List<Map<String, dynamic>> detectionResult;
  final String cropName;

  const ExpertAdviceWidget({
    super.key,
    required this.detectionResult,
    required this.cropName,
  });

  @override
  State<ExpertAdviceWidget> createState() => _ExpertAdviceWidgetState();
}

class _ExpertAdviceWidgetState extends State<ExpertAdviceWidget> {
  late Future<String> _adviceFuture;

  @override
  void initState() {
    super.initState();
    _adviceFuture = GeminiChatService().getExpertAdvice(
      detections: widget.detectionResult,
      cropName: widget.cropName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _adviceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Lottie.asset(
                "assets/animations/typing.json",
                width: 200,
                height: 100,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "⚠️ Failed to load expert advice.\n${snapshot.error}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/icons/farm.png",
                      width: 24,
                      height: 23,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "AI Expert Advice",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                MarkdownBody(
                  data: snapshot.data!,
                  styleSheet:
                      MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                    p: const TextStyle(fontSize: 16, height: 1.4),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Text("No advice available."),
          );
        }
      },
    );
  }
}
