import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HasabTtsApi {
  static final String _apiKey = dotenv.env['HASAB_AI_API_KEY'] ?? "";
  static const String _url = "https://hasab.co/api/v1/tts/synthesize";

  /// Sends text to Hasab AI and returns the path to the saved MP3 file
  static Future<String?> synthesizeAmharic(String text) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $_apiKey", // Bearer Token Authentication
        },
        body: jsonEncode(
          {
            "text": text,
            "language": "amh", // Hasab uses 'amh', not 'am'
            "speaker_name":
                "yared" // Options: 'hanna', 'selam', 'aster', 'yared', etc.
          },
        ),
      );

      if (response.statusCode == 200) {
        // Hasab returns the audio file directly (Binary), not JSON
        final bytes = response.bodyBytes;

        if (bytes.isEmpty) {
          throw Exception("Received empty audio file");
        }

        // Save to temporary file
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/hasab_audio.mp3');

        // Write the bytes to the file
        await file.writeAsBytes(bytes);

        return file.path; // Return the path to play
      } else {
        print("Hasab TTS Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Error calling Hasab TTS: $e");
      return null;
    }
  }
}
