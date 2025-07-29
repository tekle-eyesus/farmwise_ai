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
      return "Sorry, something went wrong. Please try again.";
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
}
