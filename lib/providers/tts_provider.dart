import 'package:farmwise_ai/utils/snackbar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/tts_service.dart';

class TtsProvider with ChangeNotifier {
  final TtsService _ttsService = TtsService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  bool get isPlaying => _ttsService.isPlaying;
  bool get isPaused => _ttsService.isPaused;

  Future<void> speak(String text, BuildContext context) async {
    if (text.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      await _ttsService.speak(text);
      CustomSnackBar.showSuccess(context, "Playing audio...");
    } catch (e) {
      CustomSnackBar.showError(
          context, "Failed to play audio: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> stop(BuildContext context) async {
    try {
      await _ttsService.stop();
      CustomSnackBar.showInfo(context, "Audio stopped");
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showError(context, "Failed to stop audio");
    }
  }

  Future<void> pause(BuildContext context) async {
    try {
      await _ttsService.pause();
      CustomSnackBar.showInfo(context, "Audio paused");
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showError(context, "Failed to pause audio");
    }
  }

  Future<void> resume(BuildContext context) async {
    try {
      await _ttsService.resume();
      CustomSnackBar.showInfo(context, "Audio resumed");
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showError(context, "Failed to resume audio");
    }
  }

  @override
  void dispose() {
    _ttsService.dispose();
    super.dispose();
  }
}
