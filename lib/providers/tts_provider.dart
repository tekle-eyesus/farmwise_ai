import 'package:smartcrop_ai/utils/snackbar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/tts_service.dart';

class TtsProvider with ChangeNotifier {
  final TtsService _ttsService = TtsService();
  bool _isLoading = false;

  // Combine internal loading state with service loading state
  bool get isLoading => _isLoading || _ttsService.isLoading;
  bool get isPlaying => _ttsService.isPlaying;
  bool get isPaused => _ttsService.isPaused;

  /// Updated to accept languageCode
  Future<void> speak(
      String text, BuildContext context, String languageCode) async {
    if (text.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      // Pass the language code (e.g., 'am' or 'en')
      await _ttsService.speak(text, languageCode);
    } catch (e) {
      CustomSnackBar.showError(context, "Audio Error: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> stop(BuildContext context) async {
    await _ttsService.stop();
    notifyListeners();
  }

  Future<void> pause(BuildContext context) async {
    await _ttsService.pause();
    notifyListeners();
  }

  Future<void> resume(BuildContext context) async {
    await _ttsService.resume();
    notifyListeners();
  }

  @override
  void dispose() {
    _ttsService.dispose();
    super.dispose();
  }
}
