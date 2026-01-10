import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cloudinary_service.dart';

class ChatHistoryService {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  /// save conversation to Firestore
  static Future<void> saveConversation(
      List<Map<String, dynamic>> messages) async {
    final user = _auth.currentUser;
    if (user == null || messages.isEmpty) return;

    //  Generate a Title (First user message or default)
    String title = "New Conversation";
    final firstUserMsg = messages.firstWhere(
      (m) => m['role'] == 'user',
      orElse: () => {},
    );
    if (firstUserMsg.isNotEmpty && firstUserMsg['content'] != null) {
      String content = firstUserMsg['content'];
      // Take first 30 chars
      title = content.length > 30 ? "${content.substring(0, 30)}..." : content;
    }

    List<Map<String, dynamic>> processedMessages = [];

    for (var msg in messages) {
      Map<String, dynamic> newMsg = Map.from(msg);

      // Check if there is a LOCAL image path
      if (newMsg.containsKey('imagePath') &&
          newMsg['imagePath'] != null &&
          newMsg['imagePath'].toString().isNotEmpty) {
        File localFile = File(newMsg['imagePath']);

        if (localFile.existsSync()) {
          // UPLOAD to Cloudinary
          String? cloudUrl = await CloudinaryService.uploadImage(localFile);

          if (cloudUrl != null) {
            newMsg['imageUrl'] = cloudUrl;
          }
        }
        newMsg.remove('imagePath');
      }

      processedMessages.add(newMsg);
    }

    await _db
        .collection('users')
        .doc(user.uid)
        .collection('conversations')
        .add({
      'title': title,
      'messages': processedMessages,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Get All Conversations (Stream for Drawer)
  static Stream<QuerySnapshot> getHistoryStream() {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _db
        .collection('users')
        .doc(user.uid)
        .collection('conversations')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Delete a specific conversation history
  static Future<void> deleteConversation(String docId) async {
    final user = _auth.currentUser;
    if (user != null) {
      await _db
          .collection('users')
          .doc(user.uid)
          .collection('conversations')
          .doc(docId)
          .delete();
    }
  }
}
