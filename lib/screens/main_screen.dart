import 'dart:io';

import 'package:farmwise_ai/screens/detect_result_screen.dart';
import 'package:farmwise_ai/services/gemini_chat_service.dart';
import 'package:farmwise_ai/services/tflite_service.dart';
import 'package:farmwise_ai/widgets/custom_drawer.dart';
import 'package:farmwise_ai/widgets/welcome_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GeminiChatService _geminiService = GeminiChatService();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  var selectedCrop = "Tomato";

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': text});
      _isLoading = true;

      // Optional: add temporary "Typing..." placeholder
      _messages.add({'role': 'bot', 'content': 'typing...'});
    });

    _controller.clear();
    _scrollToBottom();

    final reply = await _geminiService.getResponse(
      userMessage: text,
      selectedCrop: selectedCrop,
      previousMessages: _messages, // for future follow-ups
    );

    setState(() {
      // // Remove "typing..." placeholder
      _messages.removeLast();

      _messages.add({'role': 'bot', 'content': reply});
      _isLoading = false;
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 200), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Future<String?> showCropSelector(BuildContext context, String selectedCrop) {
    final List<Map<String, String>> cropTypes = [
      {'icon': 'assets/icons/tomato.png', 'label': 'Tomato'},
      {'icon': 'assets/icons/coffee-bean.png', 'label': 'Coffee'},
      {'icon': 'assets/icons/mangoo.png', 'label': 'Mango'},
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
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    "Select Crop to Assist",
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

  void _onDetectPressed() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      File image = File(picked.path);

      // Run model
      var result = await TFLiteService.detectImage(image);

      if (result != null && result.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetectResultScreen(
              image: image,
              detectionResult: result,
            ),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    TFLiteService.loadModel(); // Load model once
  }

  @override
  void dispose() {
    TFLiteService.disposeModel(); // Free up resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
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
              ),
            ),
          ),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "FarmWise AI",
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade100,
        actions: [
          Tooltip(
            message: "New Assistance",
            child: InkWell(
              onTap: () {
                setState(() {
                  _messages.removeWhere((item) => true);
                });
              },
              child: Image.asset(
                "assets/icons/add-chat.png",
                width: 30,
                height: 30,
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
                    padding: EdgeInsets.only(top: 8),
                    controller: _scrollController,
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final msg = _messages[index];
                      final isUser = msg['role'] == 'user';
                      return Container(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: isUser
                            ? Container(
                                margin: EdgeInsets.only(left: 55),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(162, 200, 230, 201),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                child: Text(
                                  msg['content'] ?? '',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                              )
                            : msg['content'] == "typing..."
                                ? Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        "assets/icons/farm.png",
                                        width: 27,
                                        height: 27,
                                      ),
                                    ],
                                  )
                                : Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 8),
                                    child: MarkdownBody(
                                      data: msg['content'] ?? '',
                                      styleSheet: MarkdownStyleSheet(
                                        p: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                            height: 1.5),
                                        strong: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                        em: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey[700]),
                                        blockquote: TextStyle(
                                            color: Colors.grey[600],
                                            fontStyle: FontStyle.italic),
                                        code: TextStyle(
                                          backgroundColor: Colors.grey[100],
                                          fontFamily: 'monospace',
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ask About Your ${selectedCrop} farm...',
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
                            "Detect Disease",
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
                          InkWell(
                            onTap: () async {
                              String? result =
                                  await showCropSelector(context, selectedCrop);
                              setState(
                                () {
                                  selectedCrop = result!;
                                },
                              );
                            },
                            child: Image.asset(
                              "assets/icons/menu.png",
                              width: 20,
                              height: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
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
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildDetectBtn(String title, String icon, void Function() detect) {
    return InkWell(
      onTap: detect,
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
}
