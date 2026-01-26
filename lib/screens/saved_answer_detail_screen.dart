import 'dart:io';
import 'package:smartcrop_ai/language_classes/language_constants.dart';
import 'package:smartcrop_ai/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:smartcrop_ai/utils/snackbar_helper.dart';

class SavedAnswerDetailScreen extends StatefulWidget {
  final String question;
  final String answer;
  final DateTime savedAt;
  final String? imagePath;
  final String entryKey;

  const SavedAnswerDetailScreen({
    super.key,
    required this.question,
    required this.answer,
    required this.savedAt,
    this.imagePath,
    required this.entryKey,
  });

  @override
  State<SavedAnswerDetailScreen> createState() =>
      _SavedAnswerDetailScreenState();
}

class _SavedAnswerDetailScreenState extends State<SavedAnswerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final bool hasImage = widget.imagePath != null &&
        widget.imagePath!.isNotEmpty &&
        File(widget.imagePath!).existsSync();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: Colors.white,
            expandedHeight: hasImage ? 300.0 : 100.0,
            floating: false,
            pinned: true,
            backgroundColor: const Color.fromARGB(255, 8, 60, 55),
            flexibleSpace: FlexibleSpaceBar(
              title: hasImage
                  ? null
                  : Text(
                      translation(context).detailsTitle,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
              background: hasImage
                  ? GestureDetector(
                      onTap: () =>
                          _openFullScreenImage(context, widget.imagePath!),
                      child: Hero(
                        tag: 'saved_img_${widget.entryKey}',
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              File(widget.imagePath!),
                              fit: BoxFit.cover,
                            ),
                            const DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black54,
                                    Colors.transparent,
                                  ],
                                  stops: [0.0, 0.4],
                                ),
                              ),
                            ),
                            // "Tap to Zoom" indicator
                            Positioned(
                              bottom: 12,
                              right: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.zoom_in,
                                        color: Colors.white, size: 16),
                                    SizedBox(width: 4),
                                    Text(
                                      translation(context).detailsZoom,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 8, 60, 55),
                            Color.fromARGB(255, 32, 84, 35),
                          ],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                        ),
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Header
                  Row(
                    children: [
                      Icon(Icons.calendar_today_rounded,
                          size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Text(
                        DateUtilsHelper.formatReadable(widget.savedAt),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(
                          255, 235, 245, 235), // Light green tint
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: const Color.fromARGB(255, 200, 230, 200)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          translation(context).detailsQuestionLabel,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.question,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        translation(context).detailsAnalysisLabel,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: widget.answer));
                          CustomSnackBar.showSuccess(
                            context,
                            translation(context).detailsCopySuccess,
                          );
                        },
                        icon: const Icon(Icons.copy_rounded),
                        tooltip: translation(context).detailsActionCopy,
                        color: Colors.green[700],
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: MarkdownBody(
                      data: widget.answer,
                      selectable: true,
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                            fontSize: 16, height: 1.6, color: Colors.black87),
                        h1: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        h2: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                        strong: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black), // Bold text color
                        listBullet:
                            TextStyle(color: Colors.green[700], fontSize: 16),
                        code: TextStyle(
                            backgroundColor: Colors.grey[200],
                            fontFamily: 'Courier',
                            fontSize: 14),
                        blockquote: const TextStyle(
                            color: Colors.grey, fontStyle: FontStyle.italic),
                        blockquoteDecoration: BoxDecoration(
                          color: Colors.grey[50],
                          border: Border(
                              left: BorderSide(color: Colors.grey, width: 4)),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper to open full screen image
  void _openFullScreenImage(BuildContext context, String path) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(translation(context).detailsImagePreview,
                style: TextStyle(color: Colors.white)),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Image.file(File(path)),
            ),
          ),
        ),
      ),
    );
  }
}
