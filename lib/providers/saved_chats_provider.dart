import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/chat_answer_model.dart';
import '../services/local_storage_service.dart';

// Provider to manage saved chats
final savedChatsProvider = StateNotifierProvider<SavedChatsNotifier,
    List<MapEntry<String, SavedChatAnswer>>>((ref) {
  return SavedChatsNotifier();
});

class SavedChatsNotifier
    extends StateNotifier<List<MapEntry<String, SavedChatAnswer>>> {
  SavedChatsNotifier() : super([]) {
    loadSavedChats();
  }

// Load saved chats from local storage
  void loadSavedChats() {
    final results = LocalStorageService.getSavedAnswers();
    state = results;
  }

  Future<bool> toggleSave({
    required String question,
    required String answerText,
    required String imagePath,
  }) async {
// Check if this message is already saved
    final existingEntry = state.firstWhere(
      (entry) =>
          entry.value.modelAnswer == answerText &&
          entry.value.question == question,
      orElse: () => MapEntry(
        '',
        SavedChatAnswer(
          question: '',
          modelAnswer: '',
          savedAt: DateTime.fromMillisecondsSinceEpoch(0),
          imagePath: '',
        ),
      ), // Return dummy if not found
    );

    try {
      if (existingEntry.key.isNotEmpty) {
        // --- REMOVE ---
        await LocalStorageService.deleteAnswer(existingEntry.key);
        loadSavedChats();
        return false;
      } else {
        // --- SAVE ---
        final newAnswer = SavedChatAnswer(
          question: question,
          modelAnswer: answerText,
          savedAt: DateTime.now(),
          imagePath: imagePath,
        );
        await LocalStorageService.saveChatAnswer(newAnswer);
        // Refresh state
        loadSavedChats();
        return true;
      }
    } catch (e) {
      print("Error toggling save: $e");
      return false;
    }
  }

  // Helper to check status for UI
  bool isMessageSaved(String answerText) {
    return state.any((entry) => entry.value.modelAnswer == answerText);
  }
}
