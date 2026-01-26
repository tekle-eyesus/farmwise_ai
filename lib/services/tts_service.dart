import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'hasab_tts_api.dart'; // Import the Hasab service

enum TtsState { playing, stopped, paused, error, loading }

class TtsService {
  // Engine 1: English (Offline)
  final FlutterTts _flutterTts = FlutterTts();

  // Engine 2: Amharic (Hasab AI)
  final AudioPlayer _audioPlayer = AudioPlayer();

  TtsState _state = TtsState.stopped;
  String? _currentText;

  // Track which engine is currently active so we know which one to pause/stop
  bool _isHasabMode = false;

  TtsService() {
    _initializeFlutterTts();
    _initializeAudioPlayer();
  }

  // --- Init English Engine ---
  void _initializeFlutterTts() {
    _flutterTts.setLanguage("en-US");
    _flutterTts.setSpeechRate(0.5);

    _flutterTts.setStartHandler(() => _state = TtsState.playing);
    _flutterTts.setCompletionHandler(() {
      _state = TtsState.stopped;
      _currentText = null;
    });
    _flutterTts.setErrorHandler((msg) => _state = TtsState.error);
  }

  // --- Init Amharic Engine ---
  void _initializeAudioPlayer() {
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.playing) {
        _state = TtsState.playing;
      } else if (state == PlayerState.completed ||
          state == PlayerState.stopped) {
        _state = TtsState.stopped;
        _currentText = null;
      }
    });
  }

  // --- MAIN SPEAK FUNCTION ---
  Future<void> speak(String text, String languageCode) async {
    try {
      // 1. Stop anything currently playing
      await stop();
      _currentText = text;

      // 2. Check Language (Flutter sends 'am', Hasab needs 'amh')
      if (languageCode == 'am' || languageCode == 'amh') {
        // --- AMHARIC PATH (Hasab AI) ---
        _isHasabMode = true;
        _state = TtsState.loading;

        final filePath = await HasabTtsApi.synthesizeAmharic(text);

        if (filePath != null) {
          // Play the file we just downloaded
          await _audioPlayer.play(DeviceFileSource(filePath));
        } else {
          throw Exception("Failed to fetch Amharic audio from Hasab AI");
        }
      } else {
        // --- ENGLISH PATH (Offline) ---
        _isHasabMode = false;
        await _flutterTts.speak(text);
      }
    } catch (e) {
      _state = TtsState.error;
      rethrow;
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
      await _audioPlayer.stop();
      _state = TtsState.stopped;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> pause() async {
    if (_state == TtsState.playing) {
      if (_isHasabMode) {
        await _audioPlayer.pause();
      } else {
        await _flutterTts.pause();
      }
      _state = TtsState.paused;
    }
  }

  Future<void> resume() async {
    if (_state == TtsState.paused) {
      if (_isHasabMode) {
        await _audioPlayer.resume();
      } else {
        // FlutterTts resume fallback
        if (_currentText != null) {
          await _flutterTts.speak(_currentText!);
        }
      }
      _state = TtsState.playing;
    }
  }

  bool get isPlaying => _state == TtsState.playing;
  bool get isPaused => _state == TtsState.paused;
  bool get isLoading => _state == TtsState.loading;

  void dispose() {
    _flutterTts.stop();
    _audioPlayer.dispose();
  }
}
