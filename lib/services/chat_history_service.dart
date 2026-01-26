import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cloudinary_service.dart';

class ChatHistoryService {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Future<void> saveConversation(List<Map<String, dynamic>> messages,
      {String? docId}) async {
    final user = _auth.currentUser;
    if (user == null || messages.isEmpty) return;

    // Process Images (Same logic as before)
    List<Map<String, dynamic>> processedMessages = [];
    for (var msg in messages) {
      Map<String, dynamic> newMsg = Map.from(msg);
      if (newMsg.containsKey('imagePath') &&
          newMsg['imagePath'] != null &&
          newMsg['imagePath'].toString().isNotEmpty) {
        File localFile = File(newMsg['imagePath']);
        if (localFile.existsSync()) {
          String? cloudUrl = await CloudinaryService.uploadImage(localFile);
          if (cloudUrl != null) {
            newMsg['imageUrl'] = cloudUrl;
          }
        }
        newMsg.remove('imagePath');
      }
      processedMessages.add(newMsg);
    }

    // Decide: UPDATE or CREATE
    final collection =
        _db.collection('users').doc(user.uid).collection('conversations');

    if (docId != null) {
      await collection.doc(docId).update({
        'messages': processedMessages,
        'updatedAt':
            FieldValue.serverTimestamp(), // Update timestamp so it jumps to top
      });
    } else {
      // Create New Conversation
      // Generate Title
      String title = "New Conversation";
      final firstUserMsg =
          messages.firstWhere((m) => m['role'] == 'user', orElse: () => {});
      if (firstUserMsg.isNotEmpty) {
        String content = firstUserMsg['content'] ?? "";
        title =
            content.length > 30 ? "${content.substring(0, 30)}..." : content;
      }

      await collection.add({
        'title': title,
        'messages': processedMessages,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
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
