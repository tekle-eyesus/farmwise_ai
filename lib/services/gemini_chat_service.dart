import 'dart:io';
import 'package:smartcrop_ai/language_classes/language.dart' as lang;
import 'package:smartcrop_ai/language_classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mime/mime.dart';

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
    File? imageFile,
    required String locationName,
    required String weatherData,
  }) async {
    Locale locale = await getLocale();
    String selectedLanguage = lang.Language.languageList()
        .firstWhere((lang) => lang.languageCode == locale.languageCode)
        .name;

    try {
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        final mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';

        // 1. Construct the robust prompt with all context variables
        final imagePrompt = '''
You are SmartCrop AI, an expert agricultural consultant for farmers in **Ethiopia**. 
You are analyzing an image uploaded by a farmer.

🛑 **STRICT LANGUAGE CONTROL:**
- **Target Language:** $selectedLanguage
- **Rule 1:** You MUST provide your entire response in **$selectedLanguage** ONLY.
- **Rule 2:** Ignore the language the user types in. Even if the user asks in English, answer in **$selectedLanguage**.

📍 **ENVIRONMENTAL CONTEXT (Crucial for Advice):**
- **Location:** $locationName
- **Current Weather & Forecast:** $weatherData
- **Instruction:** Use this weather data to adjust your recommendations. (e.g., If rain is forecast, advise NOT to spray chemicals. If hot/dry, advise on irrigation).

📸 **IMAGE ANALYSIS TASK:**
1. **Relevance Check:** First, verify if the image is of a plant, crop, soil, or farm pest. If the image is unrelated (e.g., a person, car, building), politely refuse in **$selectedLanguage** saying you can only analyze agricultural images.
2. **Diagnosis:** Identify the crop, growth stage, and any signs of disease, pests, or nutrient deficiency.
3. **User Intent:** The user might have asked a specific question below. Address it specifically. If the user said nothing, provide a comprehensive health check.

👤 **USER INPUT:**
- **User Question/Note:** "${userMessage.isEmpty ? 'No specific question asked. Please provide a general health analysis.' : userMessage}"
- **Previous Context:** ${previousMessages.map((m) => "${m['role']}: ${m['content']}").join(' | ')}

🧠 **ADVISORY LOGIC:**
Based on the **Visual Evidence** AND the **Weather Context**:
1. **Diagnosis:** What is wrong? (Or confirm it is healthy).
2. **Immediate Action:** What should the farmer do TODAY? 
   - *Logic:* If prescribing a spray, check the `$weatherData`. Is it safe to spray? If not, warn them.
3. **Treatment:** Step-by-step cure (Organic first, then Chemical).

⚠️ **SAFETY & FORMATTING:**
- If suggesting chemicals, mention safety gear and pre-harvest intervals.
- Use **Bold** for key terms.
- Use Bullet points for steps.
- **Conciseness:** Be direct. Do not introduce yourself. Go straight to the diagnosis.
''';

        // 2. Build Content
        final content = [
          Content.multi(
            [
              TextPart(imagePrompt),
              DataPart(mimeType, bytes),
            ],
          )
        ];

        final response = await _model.generateContent(content);
        return response.text ?? "No response received.";
      } else {
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
      }
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

// Inside your class
  Future<String> identifyCrop(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      final mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';

      // 1. Strict System Prompt
      final prompt = '''
    You are an agricultural image classifier.
    
    TARGET CROPS: [Wheat, Potato, Pepper, Orange, Maize, Apple]

    TASK:
    1. Analyze the uploaded image.
    2. Determine if it is a leaf, fruit, or plant of one of the TARGET CROPS.
    3. If it is one of them, return ONLY the crop name (e.g., "Wheat").
    4. If it is NOT one of these crops, or if it is a non-plant object (person, car, animal, blur), return "INVALID".

    OUTPUT FORMAT:
    Return a single word string. Do not add punctuation.
    ''';

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart(mimeType, bytes),
        ])
      ];

      // 2. Generate
      final response = await _model.generateContent(content);
      final text = response.text?.trim() ?? "INVALID";

      // 3. Clean up result just in case
      // (Gemini might sometimes say "The crop is Wheat", we just want "Wheat")
      for (String crop in [
        "Wheat",
        "Potato",
        "Pepper",
        "Orange",
        "Maize",
        "Apple"
      ]) {
        if (text.toLowerCase().contains(crop.toLowerCase())) {
          return crop;
        }
      }

      return "INVALID";
    } catch (e) {
      print("Gemini Identification Error: $e");
      // Fallback: If internet fails or Gemini fails, we might want to
      // allow the user to proceed manually or return INVALID.
      // Returning "ERROR" allows the UI to handle it.
      return "ERROR";
    }
  }
}
