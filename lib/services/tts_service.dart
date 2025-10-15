import 'package:flutter_tts/flutter_tts.dart';

enum TtsState { playing, stopped, paused, error }

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  TtsState _state = TtsState.stopped;
  String? _currentText;
  int _currentWordStart = 0;
  int _currentWordEnd = 0;

  TtsService() {
    _initializeTts();
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);

    _flutterTts.setStartHandler(() {
      _state = TtsState.playing;
    });

    _flutterTts.setCompletionHandler(() {
      _state = TtsState.stopped;
      _currentText = null;
      _currentWordStart = 0;
      _currentWordEnd = 0;
    });

    _flutterTts
        .setProgressHandler((String text, int start, int end, String word) {
      _currentWordStart = start;
      _currentWordEnd = end;
    });

    _flutterTts.setErrorHandler((msg) {
      _state = TtsState.error;
      _currentText = null;
    });
  }

  Future<void> speak(String text) async {
    try {
      if (_state == TtsState.playing) {
        await stop();
      }

      if (text.trim().isEmpty) {
        throw Exception("No text to speak");
      }

      _currentText = text;
      await _flutterTts.speak(text);
    } catch (e) {
      _state = TtsState.error;
      rethrow;
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
      _state = TtsState.stopped;
      _currentText = null;
      _currentWordStart = 0;
      _currentWordEnd = 0;
    } catch (e) {
      _state = TtsState.error;
      rethrow;
    }
  }

  Future<void> pause() async {
    try {
      if (_state == TtsState.playing) {
        await _flutterTts.pause();
        _state = TtsState.paused;
      }
    } catch (e) {
      _state = TtsState.error;
      rethrow;
    }
  }

  Future<void> resume() async {
    try {
      if (_state == TtsState.paused) {
        await _flutterTts.speak(_currentText!);
      }
    } catch (e) {
      _state = TtsState.error;
      rethrow;
    }
  }

  TtsState get state => _state;
  String? get currentText => _currentText;
  bool get isPlaying => _state == TtsState.playing;
  bool get isPaused => _state == TtsState.paused;

  void dispose() {
    _flutterTts.stop();
  }
}
