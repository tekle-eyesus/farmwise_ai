import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiChatService {
  final _apiKey = dotenv.env['GEMINI_API_KEY']!;
  late final GenerativeModel _model;

  GeminiChatService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: _apiKey,
    );
  }

  Future<String> getResponse({
    required String userMessage,
    required String selectedCrop,
    List<Map<String, String>> previousMessages = const [],
  }) async {
    try {
      final prompt = _buildPrompt(userMessage, selectedCrop, previousMessages);

      final response = await _model.generateContent([
        Content.text(prompt),
      ]);

      return response.text ?? "No response received.";
    } catch (e) {
      return "Sorry, something went wrong. Please try again.$e";
    }
  }

  String _buildPrompt(
      String message, String crop, List<Map<String, String>> previousMessages) {
    return '''
You are a specialized agricultural assistant AI with expertise in $crop farming.

📌 Your job is to answer user questions about:
- Best farming practices
- Disease identification, symptoms, treatment, and prevention
- Harvesting and post-harvest
- Seasonal recommendations
- Environmental conditions and fertilizers

🌱 Instructions:
- Respond only to questions related to $crop.
- If user asks about **another crop**, reply: "I'm focused on $crop for now. I can't assist with [that crop] yet."
- If user asks **non-agricultural topics**, respond: "I'm an agricultural assistant and not trained for that topic."
- Use farmer-friendly tone, simple and clear.
- Keep answers concise but informative.
- Maintain context from past questions.

🧠 Context: ${previousMessages.map((m) => "${m['role']}: ${m['content']}").join('\n')}

👤 User Question: $message
''';
  }

  /// Generates expert agricultural advice from detection results
  Future<String> getExpertAdvicePrompt({
    required List<Map<String, dynamic>> detections,
    required String cropName,
  }) {
    final buffer = StringBuffer();
    buffer.writeln(
        "You are a certified agricultural expert. Based on the image analysis results, give practical expert advice to a smallholder farmer growing $cropName.\n");

    buffer.writeln("The detection result includes:");
    for (var detection in detections) {
      final label = detection['label'] ?? 'Unknown Disease';
      final confidence = ((detection['confidence'] ?? 0.0)).toStringAsFixed(1);
      buffer.writeln("- $label: $confidence%");
    }

    buffer.writeln("\nAdvice must include:");
    buffer.writeln("1. Immediate treatment or action steps.");
    buffer.writeln("2. Preventive measures for future.");
    buffer.writeln(
        "3. Monitoring tips (e.g., how often to check, what to observe).");
    buffer.writeln("4. Low-cost or natural treatment options if relevant.");
    buffer.writeln("5. Keep it short and clear.");

    return Future.value(buffer.toString());
  }

  /// Gemini-powered advice generation
  Future<String> getExpertAdvice({
    required List<Map<String, dynamic>> detections,
    required String cropName,
  }) async {
    try {
      final prompt = await getExpertAdvicePrompt(
        detections: detections,
        cropName: cropName,
      );

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(content);

      if (response.text != null && response.text!.isNotEmpty) {
        return response.text!;
      } else {
        return "No expert advice could be generated. Please try again.";
      }
    } catch (e) {
      return "Failed to get expert advice: $e";
    }
  }
}
