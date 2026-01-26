import 'package:avatar_glow/avatar_glow.dart';
import 'package:smartcrop_ai/language_classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';

class VoiceInputPanel extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback onClose;

  const VoiceInputPanel({
    super.key,
    required this.textController,
    required this.onClose,
  });

  @override
  State<VoiceInputPanel> createState() => _VoiceInputPanelState();
}

class _VoiceInputPanelState extends State<VoiceInputPanel> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _textBeforeSession = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _initSpeech();
  }

  void _initSpeech() async {
    // Request Permissions
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      widget.onClose(); // Close if rejected
      return;
    }

    // Initialize Logic
    bool available = await _speech.initialize(
      onStatus: (val) {
        if (mounted) {
          setState(() => _isListening = val == 'listening');
        }
      },
      onError: (val) => print('onError: $val'),
    );

    if (available) {
      _startListening();
    }
  }

  void _startListening() {
    // Capture current text so we append to it
    _textBeforeSession = widget.textController.text;
    _speech.listen(
      onResult: (val) {
        String currentWords = val.recognizedWords;
        if (currentWords.isNotEmpty) {
          // If field was not empty, add a space
          String prefix = _textBeforeSession;
          if (prefix.isNotEmpty && !prefix.endsWith(' ')) {
            prefix += " ";
          }

          // Update the controller
          widget.textController.text = "$prefix$currentWords";

          // Move cursor to the end
          widget.textController.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.textController.text.length));
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 5),
      partialResults: true,
      cancelOnError: true,
      listenMode: stt.ListenMode.confirmation, // Better for short phrases
    );
    setState(() => _isListening = true);
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  void _toggleListening() {
    if (_isListening) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E1E),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      height: 230,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Close Strip
          Container(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.grey,
              ),
              onPressed: widget.onClose,
            ),
          ),
          const Spacer(),
          // Mic Button
          GestureDetector(
            onTap: _toggleListening,
            child: AvatarGlow(
              animate: _isListening,
              glowColor: Colors.blue,
              duration: const Duration(milliseconds: 2000),
              repeat: true,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: _isListening ? Colors.red : Colors.grey,
                child: Icon(
                  _isListening ? Icons.mic : Icons.mic_off,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _isListening
                ? translation(context).voiceStatusListening
                : translation(context).voiceStatusTapToTalk,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
