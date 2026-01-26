import 'dart:io';

import 'package:smartcrop_ai/language_classes/language_constants.dart';
import 'package:smartcrop_ai/screens/saved_answer_detail_screen.dart';
import 'package:smartcrop_ai/utils/date_utils.dart';
import 'package:smartcrop_ai/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class SavedAnswersScreen extends StatefulWidget {
  const SavedAnswersScreen({super.key});
  @override
  State<SavedAnswersScreen> createState() => _SavedResultsScreenState();
}

class _SavedResultsScreenState extends State<SavedAnswersScreen> {
  @override
  Widget build(BuildContext context) {
    final savedEntries = LocalStorageService.getSavedAnswers();
    // newest first
    savedEntries.sort((a, b) => b.value.savedAt.compareTo(a.value.savedAt));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        flexibleSpace: Container(
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
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          translation(context).savedTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            letterSpacing: 0.5,
          ),
        ),
      ),
      body: savedEntries.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              itemCount: savedEntries.length,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemBuilder: (context, index) {
                final entry = savedEntries[index];
                final key = entry.key;
                final result = entry.value;

                return _buildModernSavedItem(context, key, result);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.bookmarks_outlined,
              size: 60,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            translation(context).savedEmptyState,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            translation(context).savedEmptySubtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernSavedItem(
      BuildContext context, String key, dynamic result) {
    // Check if image exists and is valid
    bool hasImage = result.imagePath != null &&
        result.imagePath.isNotEmpty &&
        File(result.imagePath).existsSync();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SavedAnswerDetailScreen(
                  question: result.question,
                  answer: result.modelAnswer,
                  savedAt: result.savedAt,
                  imagePath: hasImage
                      ? result.imagePath
                      : null, // Pass imagePath if it exists
                  entryKey: key,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 14,
                          color: Colors.green.shade600,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          DateUtilsHelper.formatReadable(result.savedAt),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () async {
                          final shouldDelete =
                              await _showDeleteConfirmation(context);
                          if (shouldDelete ?? false) {
                            await LocalStorageService.deleteAnswer(key);
                            CustomSnackBar.showSuccess(
                              context,
                              translation(context).savedDeleteSuccess,
                            );
                            setState(() {});
                          }
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.delete_outline_rounded,
                            size: 20,
                            color: Colors.red.shade400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User Question (Headline)
                          Text(
                            result.question,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          // AI Answer Snippet
                          Text(
                            result.modelAnswer.replaceAll('**', ''),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    // Image Thumbnail (Only if image exists)
                    if (hasImage) ...[
                      const SizedBox(width: 12),
                      Hero(
                        tag: 'saved_img_$key', // Unique tag for animation
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                            image: DecorationImage(
                              image: FileImage(File(result.imagePath)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      translation(context).savedActionView,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: Colors.green.shade700,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(translation(context).savedDialogDeleteTitle),
        content: Text(
          translation(context).savedDialogDeleteBody,
          style: const TextStyle(color: Colors.grey),
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(translation(context).no,
                style: const TextStyle(color: Colors.grey)),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade500,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: Text(translation(context).yes),
          ),
        ],
      ),
    );
  }
}
