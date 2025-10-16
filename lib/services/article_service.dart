import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ArticleService {
  final _apiKey = dotenv.env["MY_GOOGLE_CUSTOM_SEARCH_API_KEY"];
  final _searchEngineId = dotenv.env["MY_CUSTOM_SEARCH_ENGINE_ID"];

  Future<List<Map<String, String>>> fetchArticles(
    String query, {
    int maxResults = 6,
  }) async {
    try {
      final String searchQuery =
          '$query agriculture farming treatment prevention';

      final response = await http.get(
        Uri.parse('https://www.googleapis.com/customsearch/v1?'
            'key=$_apiKey&'
            'cx=$_searchEngineId&'
            'q=${Uri.encodeQueryComponent(searchQuery)}&'
            'num=$maxResults&'
            'sort=date'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'] as List?;

        if (items == null || items.isEmpty) {
          return _getFallbackArticles(query);
        }

        return items.map<Map<String, String>>((item) {
          return {
            'title': item['title'] ?? 'No Title',
            'link': item['link'] ?? '',
            'snippet': item['snippet'] ?? 'No description available',
            'source': _extractSource(item['displayLink'] ?? ''),
          };
        }).toList();
      } else {
        // Fallback to dummy data if API fails
        return _getFallbackArticles(query);
      }
    } catch (e) {
      // Fallback to dummy data on error
      return _getFallbackArticles(query);
    }
  }

  String _extractSource(String displayLink) {
    // Extract clean source name from URL
    if (displayLink.contains('agriculture.com')) return 'Agriculture.com';
    if (displayLink.contains('fao.org')) return 'FAO';
    if (displayLink.contains('extension.org')) return 'Extension.org';
    if (displayLink.contains('.sciencedirect.')) return 'ScienceDirect';
    if (displayLink.contains('.gov')) return 'Government Resource';

    // Remove www and domain extensions for cleaner display
    return displayLink
        .replaceAll('www.', '')
        .replaceAll('.com', '')
        .replaceAll('.org', '')
        .replaceAll('.edu', '')
        .split('.')
        .first
        .toUpperCase();
  }

  List<Map<String, String>> _getFallbackArticles(String query) {
    // Fallback articles for demo/offline use
    return [
      {
        'title': 'Comprehensive Guide for $query Management',
        'link': 'https://example.com/article1',
        'snippet':
            'Learn about identification, prevention, and treatment methods for $query in agricultural settings.',
        'source': 'AGRICULTURE_GUIDE',
      },
      {
        'title': 'Organic Treatment Options for $query',
        'link': 'https://example.com/article2',
        'snippet':
            'Explore natural and organic methods to control and prevent $query in your crops.',
        'source': 'ORGANIC_FARMING',
      },
      {
        'title': '$query: Symptoms and Solutions',
        'link': 'https://example.com/article3',
        'snippet':
            'Detailed analysis of $query symptoms, lifecycle, and effective control measures.',
        'source': 'CROP_PROTECTION',
      },
    ];
  }
}
