import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class YouTubeService {
  static Future<List<Map<String, String>>> fetchVideos(String query) async {
    try {
      final apiKey = dotenv.env['YOUTUBE_API_KEY']!;
      final response = await http.get(Uri.parse(
        'https://www.googleapis.com/youtube/v3/search?part=snippet&type=video&maxResults=5&q=$query&safeSearch=moderate&key=$apiKey',
      ));

      final data = jsonDecode(response.body);
      final items = data['items'] as List;

      return items.map<Map<String, String>>((item) {
        return {
          'id': item['id']['videoId'],
          'title': item['snippet']['title'],
          'thumbnail': item['snippet']['thumbnails']['high']['url'],
        };
      }).toList();
    } catch (e) {
      print('YouTube fetch error: $e');
      return [];
    }
  }
}
