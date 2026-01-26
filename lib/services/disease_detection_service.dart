import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/disease_response_model.dart';

class DiseaseDetectionService {
  // Ngrok URL
  static const String _apiUrl =
      "https://castled-renato-snakily.ngrok-free.dev/predictwithseverity";

  Future<DiseaseResponse?> detectDisease(File imageFile) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(_apiUrl));

      // Add the image file (Key is 'file')
      request.files
          .add(await http.MultipartFile.fromPath('file', imageFile.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body);
        return DiseaseResponse.fromJson(jsonMap);
      } else {
        print("API Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Detection Connection Error: $e");
      return null;
    }
  }
}
