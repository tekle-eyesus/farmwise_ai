import 'package:smartcrop_ai/models/chat_answer_model.dart';
import 'package:hive/hive.dart';
import '../models/detection_result_model.dart';

class LocalStorageService {
  static final _box = Hive.box('detection_results');
  static final _answers_box = Hive.box("model_answers");
  static final _chatHistoryBox = Hive.box('chat_history');

  static Future<String> saveResult(SavedDetectionResult result) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await _box.put(id, result.toMap());
    return id;
  }

  static List<MapEntry<String, SavedDetectionResult>> getSavedResults() {
    return _box.toMap().entries.map((entry) {
      final key = entry.key as String;
      final value =
          SavedDetectionResult.fromMap(Map<String, dynamic>.from(entry.value));
      return MapEntry(key, value);
    }).toList();
  }

  static Future<void> deleteResult(String key) async {
    await _box.delete(key);
  }

  // To chat model answers
  static Future<void> saveChatAnswer(SavedChatAnswer answer) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await _answers_box.put(id, answer.toMap());
  }

  static List<MapEntry<String, SavedChatAnswer>> getSavedAnswers() {
    return _answers_box.toMap().entries.map((entry) {
      final key = entry.key as String;
      final value =
          SavedChatAnswer.fromMap(Map<String, dynamic>.from(entry.value));
      return MapEntry(key, value);
    }).toList();
  }

  static Future<void> deleteAnswer(String key) async {
    await _answers_box.delete(key);
  }

// history for chat
  static Future<void> saveChatHistory(
      List<Map<String, dynamic>> messages) async {
    await _chatHistoryBox.put('current_session', messages);
  }

  // 2. Load the conversation
  static List<Map<String, dynamic>> getChatHistory() {
    final data = _chatHistoryBox.get('current_session');
    if (data != null) {
      return List<Map<String, dynamic>>.from(
          (data as List).map((item) => Map<String, dynamic>.from(item)));
    }
    return [];
  }

  // 3. Clear history (Optional: for a "New Chat" button)
  static Future<void> clearChatHistory() async {
    await _chatHistoryBox.delete('current_session');
  }
}
