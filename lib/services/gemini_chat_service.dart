import 'package:farmwise_ai/language_classes/language.dart' as lang;
import 'package:farmwise_ai/language_classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiChatService {
  final _apiKey = dotenv.env['GEMINI_API_KEY']!;
  late final GenerativeModel _model;

  GeminiChatService() {
    _model = GenerativeModel(
      model: 'gemini-flash-latest',
      apiKey: _apiKey,
    );
  }

  Future<String> getResponse({
    required String userMessage,
    required String selectedCrop,
    List<Map<String, dynamic>> previousMessages = const [],
  }) async {
    try {
      Locale locale = await getLocale();
      String selectedLanguage = lang.Language.languageList()
          .firstWhere((lang) => lang.languageCode == locale.languageCode)
          .name;

      final prompt = _buildPrompt(
        userMessage,
        selectedCrop,
        previousMessages,
        selectedLanguage,
      );

      final response = await _model.generateContent([
        Content.text(prompt),
      ]);

      return response.text ?? "No response received.";
    } catch (e) {
      return "Sorry, something went wrong. Please try again.$e";
    }
  }

  String _buildPrompt(
    String message,
    String crop,
    List<Map<String, dynamic>> previousMessages,
    String responseLanguage,
  ) {
    return '''
You are SmartCrop AI, an expert agricultural consultant for farmers in **Ethiopia**, specialized exclusively in **$crop**.

🛑 **STRICT LANGUAGE CONTROL:**
- **Target Language:** $responseLanguage
- **Rule 1:** You MUST provide your entire response in **$responseLanguage** ONLY.
- **Rule 2:** Ignore the language the user types in. Even if the user asks in English, answer in **$responseLanguage**.
- **Rule 3:** If the user explicitly asks you to change the language (e.g., "Speak English"), REFUSE the request and instruct them (in **$responseLanguage**) to go to the **App Settings** to change the language preference.

🤝 **INTERACTION STYLE & VERBOSITY:**
1. **Natural & Warm:** When the user says "Thanks", "Good", or "Bye", respond in a friendly, conversational way. You don't need to be extremely short, but **do not** write long paragraphs.
   - *Good:* "You are very welcome! I hope this season brings you a great harvest. Let me know if you need more help."
   - *Bad:* "Ok." (Too short)
2. **Avoid Repetitive Lists:** Unless the user asks "What can you do?", **NEVER** include a bulleted list of your services (e.g., "Remember I can help with irrigation, pests, soil...") at the end of your messages.
3. **Stay in Context:** If the user says "Thanks," simply acknowledge it. Do not pivot back to farming advice unless they ask a new question.

🎯 **Objective:**
Help farmers maximize yield and health for **$crop**. Provide actionable, localized advice suitable for the Ethiopian context.

📌 **Scope of Expertise:**
- **Cultivation:** Land preparation, sowing methods suitable for Ethiopian soil/climate.
- **Crop Health:** Diagnosing diseases/pests specific to $crop and their treatments.
- **Maintenance:** Irrigation, weeding, and fertilizer application (organic & chemical).
- **Harvest:** Maturity signs, post-harvest handling, and storage.

⚠️ **Safety & Regulations:**
If suggesting chemical treatments (pesticides/herbicides):
1. Prioritize organic/cultural alternatives first.
2. If chemicals are needed, emphasize safety gear and pre-harvest intervals.
3. **Important:** Ensure all safety warnings are clearly translated into **$responseLanguage**.

⛔ **Guardrails & Constraints:**
1. **Wrong Crop:** If the user asks about a crop other than $crop, reply in **$responseLanguage**: "I focus only on **$crop**. I cannot assist with other crops yet."
2. **Off-Topic:** If the user asks about politics, news, or non-farming topics, reply in **$responseLanguage**: "I am SmartCrop AI. I am not trained to discuss topics outside of farming."
3. **Tone:** Be respectful, encouraging, and practical.
4. **Formatting:** Use **bold text** for key terms and bullet points for lists to make it readable on mobile phones.

🧠 **Conversation History:**
${previousMessages.map((m) => "${m['role']}: ${m['content']}").join('\n')}

👤 **User Question:** $message
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
