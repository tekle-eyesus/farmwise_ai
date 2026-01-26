import 'package:smartcrop_ai/language_classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/saved_chats_provider.dart';
import '../utils/snackbar_helper.dart';

class SaveChatButton extends ConsumerWidget {
  final String question;
  final String botResponse;
  final String imagePath;

  const SaveChatButton({
    super.key,
    required this.question,
    required this.botResponse,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(savedChatsProvider);

    final isSaved =
        ref.read(savedChatsProvider.notifier).isMessageSaved(botResponse);

    return Tooltip(
      message: isSaved
          ? translation(context).actionRemoveChat
          : translation(context).actionSaveChat,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isSaved
              ? Colors.green.withOpacity(0.15) // Subtle green bg if saved
              : Colors.black45.withOpacity(0.11),
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            // 3. Call the Toggle Logic
            final wasSaved =
                await ref.read(savedChatsProvider.notifier).toggleSave(
                      question: question,
                      answerText: botResponse,
                      imagePath: imagePath,
                    );

            // 4. Show Feedback
            if (context.mounted) {
              if (wasSaved) {
                CustomSnackBar.showSuccess(
                  context,
                  translation(context).actionSaveSuccess,
                );
              } else {
                CustomSnackBar.showInfo(
                  context,
                  translation(context).actionSaveRemoveSuccess,
                );
              }
            }
          },
          child: Image.asset(
            isSaved
                ? "assets/icons/save_filled.png"
                : "assets/icons/save_outlined.png",
            width: 20,
            height: 20,
            color: isSaved ? Colors.green : null, // Tint icon green if saved
          ),
        ),
      ),
    );
  }
}
