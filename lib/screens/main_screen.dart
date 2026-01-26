import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:smartcrop_ai/language_classes/language_constants.dart';
import 'package:smartcrop_ai/models/disease_response_model.dart';
import 'package:smartcrop_ai/providers/tts_provider.dart';
import 'package:smartcrop_ai/screens/detect_result_screen.dart';
import 'package:smartcrop_ai/services/chat_history_service.dart';
import 'package:smartcrop_ai/services/context_service.dart';
import 'package:smartcrop_ai/services/disease_detection_service.dart';
import 'package:smartcrop_ai/services/gemini_chat_service.dart';
import 'package:smartcrop_ai/services/local_storage_service.dart';
import 'package:smartcrop_ai/utils/snackbar_helper.dart';
import 'package:smartcrop_ai/widgets/custom_drawer.dart';
import 'package:smartcrop_ai/widgets/save_chat_button.dart';
import 'package:smartcrop_ai/widgets/voice_input_panel.dart';
import 'package:smartcrop_ai/widgets/welcome_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // Need this to control keyboard
  bool _showVoicePanel = false; // State to toggle panel
  final ScrollController _scrollController = ScrollController();
  final GeminiChatService _geminiService = GeminiChatService();
  final List<Map<String, dynamic>> _messages = [];
  String? question;
  bool _isLoading = false;
  late String selectedCrop = translation(context).commonCrop;
  late XFile? pickedCropImage = null;
  String? _currentConversationId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedCrop = translation(context).commonCrop;
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty && pickedCropImage == null) return;

    final String? imagePathToSend = pickedCropImage?.path;

    setState(() {
      final Map<String, dynamic> userMsg = {
        'role': 'user',
        'content': text,
        'imagePath': imagePathToSend,
      };

      _messages.add(userMsg);
      _messages.add({'role': 'bot', 'content': 'typing...'});
      _isLoading = true;

      pickedCropImage = null;
      _controller.clear();
    });

    LocalStorageService.saveChatHistory(_messages);

    if (imagePathToSend != null) {
      CustomSnackBar.showProcessing(context);
    }

    _scrollToBottom();

    // backend process to get location and weather
    String locationInfo = "Ethiopia (Location not detected)";
    String weatherInfo = "Weather data not available";

    try {
      Position? pos = await ContextService.determinePosition();
      if (pos != null) {
        locationInfo = await ContextService.getAddressFromLatLng(pos);
        weatherInfo = await ContextService.fetchWeatherData(
            pos); // not accurate as need to be tested

        print("Location: $locationInfo");
        print("Weather Data: $weatherInfo");
      }
    } catch (e) {
      print("Context Error: $e");
    }
    // Use imagePathToSend for the File object
    final File? imageFile =
        imagePathToSend != null ? File(imagePathToSend) : null;

    // Call LLM service
    final reply = await _geminiService.getResponse(
      userMessage: text,
      selectedCrop: selectedCrop,
      previousMessages: _messages,
      imageFile: imageFile,
      locationName: locationInfo,
      weatherData: weatherInfo,
    );

    setState(() {
      _messages.removeLast(); // Remove "typing..."

      // Add Bot Reply
      _messages.add({'role': 'bot', 'content': reply});
      _isLoading = false;
    });

    // Save to Hive again (Save the bot's reply)
    LocalStorageService.saveChatHistory(_messages);

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }

  Future<String?> showCropSelector(BuildContext context, String selectedCrop) {
    final List<Map<String, String>> cropTypes = [
      {
        'icon': 'assets/icons/tomato.png',
        'label': translation(context).cropTomato
      },
      {
        'icon': 'assets/icons/potato.png',
        'label': translation(context).cropPotato
      },
      {
        'icon': 'assets/icons/mango.png',
        'label': translation(context).cropMango
      },
    ];

    String tempSelection = selectedCrop; // Default to current selection

    return showModalBottomSheet<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              height: MediaQuery.of(context).size.height * 0.26,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.green[800],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    translation(context).mainSelectCropTitle,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: cropTypes.map((item) {
                        bool isSelected = tempSelection == item['label'];
                        return GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                tempSelection = item['label']!;
                                CustomSnackBar.showInfo(
                                  context,
                                  translation(context)
                                      .mainCropSelectedSnackbar(tempSelection),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue[100]
                                  : const Color.fromARGB(22, 0, 0, 0),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? const Color.fromARGB(97, 81, 170, 242)
                                    : const Color.fromARGB(26, 189, 189, 189),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item['icon']!,
                                  width: 40,
                                  height: 40,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item['label']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected
                                        ? Colors.blue[800]
                                        : Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      return tempSelection;
    });
  }

  // void _onDetectPressed(String option) async {
  //   final picker = ImagePicker();
  //   final picked = (option == "camera")
  //       ? await picker.pickImage(source: ImageSource.camera)
  //       : await picker.pickImage(source: ImageSource.gallery);

  //   if (picked != null) {
  //     File image = File(picked.path);

  //     CustomSnackBar.showProcessing(context);

  //     // Call the New API Service
  //     final service = DiseaseDetectionService();
  //     final DiseaseResponse? result = await service.detectDisease(image);

  //     if (result != null && result.success) {
  //       if (!mounted) return;
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => DetectResultScreen(
  //             cropName: selectedCrop, // e.g., "Wheat"
  //             image: image,
  //             apiResponse: result, // Pass the full object
  //           ),
  //         ),
  //       );
  //     } else {
  //       if (!mounted) return;
  //       CustomSnackBar.showError(
  //           context, "Failed to analyze image. Try again.");
  //     }
  //   }
  // }

  void _onDetectPressed(String option) async {
    // Pick Image
    final picker = ImagePicker();
    final picked = (option == "camera")
        ? await picker.pickImage(source: ImageSource.camera)
        : await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      File image = File(picked.path);
      CustomSnackBar.showProcessing(context);

      // gatekeeper: Gemini Crop Identification
      final String identifiedCrop = await _geminiService.identifyCrop(image);

      // Handle Gemini Errors
      if (identifiedCrop == "ERROR") {
        CustomSnackBar.showError(
            context, "Connection failed. Please try again.");
        return;
      }

      // Handle Invalid Images
      if (identifiedCrop == "INVALID") {
        if (!mounted) return;
        _showInvalidImageDialog();
        return;
      }

      CustomSnackBar.showProcessing(context);

      final service = DiseaseDetectionService();
      final DiseaseResponse? result = await service.detectDisease(image);

      if (result != null && result.success) {
        if (!mounted) return;

        // setState(() {
        //   selectedCrop = identifiedCrop;
        // });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetectResultScreen(
              cropName: identifiedCrop,
              image: image,
              apiResponse: result,
            ),
          ),
        );
      } else {
        if (!mounted) return;
        CustomSnackBar.showError(
            context, "Failed to analyze image. Try again.");
      }
    }
  }

  void _onImageUploadPressed(String option) async {
    final picker = ImagePicker();
    final picked;
    if (option == "camera") {
      picked = await picker.pickImage(source: ImageSource.camera);
    } else {
      picked = await picker.pickImage(source: ImageSource.gallery);
    }

    if (picked != null) {
      setState(() {
        pickedCropImage = picked;
      });
    }
  }

  void _showInvalidImageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.error_outline_rounded, color: Colors.red, size: 28),
            const SizedBox(width: 10),
            Text(translation(context).errorInvalidImageTitle),
          ],
        ),
        content: Text(
          translation(context).errorInvalidImageBody,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(translation(context).videoActionTryAgain,
                style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // TFLiteService().loadModel("Tomato");
    // Listen to focus changes to hide/show voice panel
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() => _showVoicePanel = false);
      }
    });

    // Load previous chat
    final history = LocalStorageService.getChatHistory();
    if (history.isNotEmpty) {
      setState(() {
        _messages.addAll(history);
      });
      // Optional: Scroll to bottom after a slight delay
      Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
    }
  }

  @override
  void dispose() {
    // TFLiteService().disposeAll();
    _focusNode.dispose();
    super.dispose();
  }

  void _onMicPressed() {
    // couses the selected crops to reset

    // FocusScope.of(context).unfocus(); // Hide keyboard
    // Future.delayed(const Duration(milliseconds: 200), () {
    //   setState(() {
    //     _showVoicePanel = true;
    //   });
    // });

    setState(() {
      _showVoicePanel = true;
    });
  }

  Future<void> _handleNewChat() async {
    // Check if there are messages to save
    if (_messages.isEmpty) {
      CustomSnackBar.showWarning(
        context,
        translation(context).mainStartConversationFirst,
      );
      return;
    }

    // Show Loading (Uploading images takes time)
    CustomSnackBar.showProcessing(context);
    setState(() => _isLoading = true);

    try {
      // Save to Firestore (Uploads images internally)
      await ChatHistoryService.saveConversation(
        _messages,
        docId: _currentConversationId,
      );

      // Clear Local State
      setState(() {
        _messages.clear();
        _currentConversationId = null;
        _isLoading = false;
      });

      // Clear Hive (Local persistence)
      await LocalStorageService.clearChatHistory();

      CustomSnackBar.showSuccess(
        context,
        translation(context).mainChatSavedAndCleared,
      );
    } catch (e) {
      setState(() => _isLoading = false);
      CustomSnackBar.showError(context, "Failed to save chat: $e");
    }
  }

  //  Load History Logic
  void _loadRestoredChat(List<Map<String, dynamic>> history, String? docId) {
    setState(() {
      _messages.clear();
      _messages.addAll(history);
      _currentConversationId = docId; // Track the ID of the loaded chat
    });

    LocalStorageService.saveChatHistory(_messages);

    Future.delayed(const Duration(milliseconds: 300), _scrollToBottom);
    CustomSnackBar.showSuccess(
      context,
      translation(context).historyConversationLoaded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(
        onChatHistorySelected: (restoredMessages, docId) {
          _loadRestoredChat(restoredMessages, docId);
        },
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(13.0),
            child: InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset(
                "assets/icons/align-right.png",
                color: Colors.green.shade200,
              ),
            ),
          ),
        ),
        title: Text(
          // translation(context).mainTitle,
          "SmartCrop AI",
          style: TextStyle(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 8, 60, 55),
                const Color.fromARGB(255, 32, 84, 35),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        actions: [
          Tooltip(
            message: translation(context).mainNewAssistanceTooltip,
            child: InkWell(
              onTap: _handleNewChat, // Call the new function
              child: Image.asset(
                "assets/icons/add-chat.png",
                width: 30,
                height: 30,
                color: Colors.green.shade200,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? WelcomeMessage(
                    title: selectedCrop,
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(
                      top: 16,
                      bottom: 100,
                    ), // Add bottom padding for input area
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final isUser = msg['role'] == 'user';
                      final String? localPath = msg['imagePath'];
                      final String? remoteUrl = msg['imageUrl'];
                      final bool hasImage =
                          (localPath != null && localPath.isNotEmpty) ||
                              (remoteUrl != null && remoteUrl.isNotEmpty);
                      final hasText = msg['content'] != null &&
                          msg['content'].toString().isNotEmpty;

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: isUser
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            if (hasImage)
                              Container(
                                margin: EdgeInsets.only(bottom: 6),
                                child: InkWell(
                                  onTap: () {
                                    // Open Full Screen (Pass either file or URL)
                                    _openFullScreenImage(
                                      context,
                                      localPath,
                                      remoteUrl,
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: _buildImageWidget(
                                      localPath,
                                      remoteUrl,
                                    ), // Helper function
                                  ),
                                ),
                              ),
                            // --------------------------
                            // 2. TEXT BUBBLES
                            // --------------------------
                            if (hasText || msg['content'] == 'typing...')
                              Row(
                                mainAxisAlignment: isUser
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  msg['content'] == "typing..."
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset(
                                              "assets/icons/farm.png",
                                              width: 27,
                                              height: 27,
                                            ),
                                            Lottie.asset(
                                              "assets/animations/circle.json",
                                              width: 60,
                                              height: 60,
                                              repeat: true,
                                            ),
                                          ],
                                        )
                                      : Flexible(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 10),
                                            decoration: BoxDecoration(
                                                color: isUser
                                                    ? Color.fromARGB(
                                                        255, 200, 230, 201)
                                                    : Colors.white, // Bot White
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(16),
                                                  topRight: Radius.circular(16),
                                                  bottomLeft: isUser
                                                      ? Radius.circular(16)
                                                      : Radius.circular(4),
                                                  bottomRight: isUser
                                                      ? Radius.circular(4)
                                                      : Radius.circular(16),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.black12,
                                                      blurRadius: 2,
                                                      offset: Offset(0, 1))
                                                ]),
                                            child: isUser
                                                ? Text(
                                                    msg['content'],
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black87),
                                                  )
                                                : MarkdownBody(
                                                    data: msg['content'],
                                                    styleSheet:
                                                        MarkdownStyleSheet(
                                                      p: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.black87,
                                                          height: 1.5),
                                                      strong: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                      em: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color:
                                                              Colors.grey[700]),
                                                      blockquote: TextStyle(
                                                          color:
                                                              Colors.grey[600],
                                                          fontStyle:
                                                              FontStyle.italic),
                                                      code: TextStyle(
                                                        backgroundColor:
                                                            Colors.grey[100],
                                                        fontFamily: 'monospace',
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                        ),
                                ],
                              ),
                            if (!isUser && msg['content'] != "typing...")
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 5),
                                child: Row(
                                  children: [
                                    Tooltip(
                                      message:
                                          translation(context).actionCopyText,
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color:
                                              Colors.black45.withOpacity(0.11),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: InkWell(
                                          hoverColor: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          onTap: () async {
                                            try {
                                              await Clipboard.setData(
                                                ClipboardData(
                                                  text: msg["content"],
                                                ),
                                              );
                                              CustomSnackBar.showSuccess(
                                                context,
                                                translation(context)
                                                    .actionTextCopied,
                                              );
                                            } catch (e) {
                                              CustomSnackBar.showError(
                                                context,
                                                translation(context)
                                                    .actionCopyFailed,
                                              );
                                            }
                                          },
                                          child: Image.asset(
                                            "assets/icons/copy.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Consumer<TtsProvider>(
                                      builder: (context, ttsProvider, child) {
                                        return Tooltip(
                                          message: ttsProvider.isPlaying
                                              ? translation(context)
                                                  .actionStopAudio
                                              : translation(context)
                                                  .actionListenAudio,
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: Colors.black45
                                                  .withOpacity(0.11),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              onTap: () async {
                                                final String textToSpeak =
                                                    msg["content"];

                                                if (textToSpeak.isEmpty) {
                                                  CustomSnackBar.showWarning(
                                                    context,
                                                    translation(context)
                                                        .actionNoTextToSpeak,
                                                  );
                                                  return;
                                                }

                                                // GET THE CURRENT LANGUAGE
                                                Locale currentLocale =
                                                    Localizations.localeOf(
                                                        context);
                                                String langCode = currentLocale
                                                    .languageCode; // 'am' or 'en'

                                                try {
                                                  if (ttsProvider.isPlaying) {
                                                    await ttsProvider
                                                        .stop(context);
                                                  } else if (ttsProvider
                                                      .isPaused) {
                                                    await ttsProvider
                                                        .resume(context);
                                                  } else {
                                                    // PASS LANGUAGE TO PROVIDER
                                                    await ttsProvider.speak(
                                                        textToSpeak,
                                                        context,
                                                        langCode);
                                                  }
                                                } catch (e) {
                                                  CustomSnackBar.showError(
                                                    context,
                                                    translation(context)
                                                        .actionAudioFailed,
                                                  );
                                                }
                                              },
                                              child: Stack(
                                                children: [
                                                  Image.asset(
                                                    "assets/icons/audio-maximum.png",
                                                    width: 20,
                                                    height: 20,
                                                    color: ttsProvider.isPlaying
                                                        ? Colors.blue
                                                        : null,
                                                  ),
                                                  // SHOW LOADING INDICATOR (While Hasab API is fetching)
                                                  if (ttsProvider.isLoading)
                                                    Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: Container(
                                                        width: 8,
                                                        height: 8,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.blue,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final previousMsg = index > 0
                                            ? _messages[index - 1]
                                            : null;

                                        String questionText =
                                            "Crop Image Analysis";
                                        String imagePath = "";

                                        if (previousMsg != null &&
                                            previousMsg['role'] == 'user') {
                                          questionText =
                                              previousMsg['content'] ??
                                                  "Crop Image Analysis";
                                          if (questionText.trim().isEmpty)
                                            questionText =
                                                "Image Analysis Result";

                                          imagePath =
                                              previousMsg['imagePath'] ?? "";
                                        }
                                        // Call the SaveChatButton widget
                                        return SaveChatButton(
                                          question: questionText,
                                          botResponse: msg['content'] ?? "",
                                          imagePath: imagePath,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Divider(
            height: 1,
            color: Colors.transparent,
          ),
          SafeArea(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(33, 0, 0, 0),
                  offset: Offset(0, -2), // shadow only at the top
                  blurRadius: 0.7,
                )
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(27),
                topRight: Radius.circular(27),
              ),
            ),
            child: Column(
              children: [
                // uploaded image preview
                if (pickedCropImage != null)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(pickedCropImage!.path),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            pickedCropImage!.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              pickedCropImage = null;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText:
                          translation(context).inputFieldHint(selectedCrop),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          _buildDetectBtn(
                            translation(context).buttonDetectDisease(
                              selectedCrop,
                            ),
                            "assets/icons/image.png",
                            _onDetectPressed,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          _buildImagUploadButton(
                            "assets/icons/add-image.png",
                            _onImageUploadPressed,
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          InkWell(
                            onTap: _onMicPressed, // Use the new logic
                            child: CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(104, 200, 230, 201),
                              child: Icon(Icons.mic, color: Colors.blue),
                            ),
                          ),
                          const SizedBox(
                            width: 7,
                          ),
                          // -------- NOT FOUND IN CURRTNT IMPLEMENTATION ---------
                          // InkWell(
                          //   onTap: () async {
                          //     String? result = await showCropSelector(
                          //       context,
                          //       selectedCrop,
                          //     );

                          //     setState(() {
                          //       selectedCrop = result!;
                          //       // _messages.removeWhere((item) => true);
                          //     });
                          //     // await TFLiteService().loadModel(selectedCrop);
                          //   },
                          //   child: CircleAvatar(
                          //     backgroundColor:
                          //         const Color.fromARGB(104, 200, 230, 201),
                          //     child: Image.asset(
                          //       "assets/icons/menu.png",
                          //       width: 20,
                          //       height: 20,
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(
                          //   width: 7,
                          // ),
                          InkWell(
                            onTap: _sendMessage,
                            child: CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.green.shade900,
                              child: _isLoading
                                  ? Center(
                                      child: Lottie.asset(
                                        "assets/animations/loading.json",
                                        width: 90,
                                        height: 90,
                                        repeat: true,
                                      ),
                                    )
                                  : Icon(
                                      Icons.arrow_upward,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_showVoicePanel)
                  VoiceInputPanel(
                    textController: _controller,
                    onClose: () {
                      setState(
                        () => _showVoicePanel = false,
                      );
                    },
                  ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String? localPath, String? remoteUrl) {
    if (localPath != null && File(localPath).existsSync()) {
      // Case 1: Local File (Fresh Chat)
      return Image.file(
        File(localPath),
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      );
    } else if (remoteUrl != null && remoteUrl.isNotEmpty) {
      // Case 2: Remote URL (Restored History)
      return CachedNetworkImage(
        imageUrl: remoteUrl,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
            width: 200,
            height: 200,
            color: Colors.grey[200],
            child: Center(child: CircularProgressIndicator())),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    }
    return SizedBox();
  }

  void _openFullScreenImage(
      BuildContext context, String? localPath, String? remoteUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.white)),
          body: Center(
            child: InteractiveViewer(
              child: (localPath != null && File(localPath).existsSync())
                  ? Image.file(File(localPath))
                  : CachedNetworkImage(imageUrl: remoteUrl ?? ''),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetectBtn(
      String title, String icon, void Function(String option) detect) {
    return PopupMenuButton(
      offset: Offset(16, -119),
      color: Colors.grey.shade100,
      onSelected: (option) => detect(option),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "camera",
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.green,
                  size: 22,
                ),
              ),
              SizedBox(width: 8),
              Text(
                translation(context).actionCamera,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: "Gallery",
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.photo,
                  color: Colors.red,
                  size: 22,
                ),
              ),
              SizedBox(width: 8),
              Text(
                translation(context).actionGallery,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.green.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 23,
              height: 23,
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagUploadButton(
      String icon, void Function(String option) detect) {
    return PopupMenuButton(
      offset: Offset(130, -122),
      color: Colors.grey.shade100,
      onSelected: (option) => detect(option),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: "camera",
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.green,
                  size: 22,
                ),
              ),
              SizedBox(width: 8),
              Text(
                translation(context).actionCamera,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: "Gallery",
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.photo,
                  color: Colors.red,
                  size: 22,
                ),
              ),
              SizedBox(width: 8),
              Text(
                translation(context).actionGallery,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
      child: CircleAvatar(
        backgroundColor: const Color.fromARGB(104, 200, 230, 201),
        child: Image.asset(
          icon,
          width: 23,
          height: 23,
        ),
      ),
    );
  }
}
