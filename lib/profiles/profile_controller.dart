import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/cloudinary_service.dart';

final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final userProfileProvider = StreamProvider<UserModel?>((ref) {
  final userAsync = ref.watch(authStateProvider);

  return userAsync.when(
    data: (user) {
      if (user == null) return Stream.value(null);

      return FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists && snapshot.data() != null) {
          return UserModel.fromMap(snapshot.data()!);
        }
        return null;
      });
    },
    loading: () => Stream.value(null),
    error: (_, __) => Stream.value(null),
  );
});

final profileControllerProvider =
    StateNotifierProvider<ProfileController, bool>((ref) {
  return ProfileController();
});

class ProfileController extends StateNotifier<bool> {
  ProfileController() : super(false);

  Future<bool> updateProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phone,
    File? newImageFile,
    String? currentImageUrl,
  }) async {
    state = true; // Start Loading
    try {
      String photoUrl = currentImageUrl ?? "";

      if (newImageFile != null) {
        final uploadedUrl = await CloudinaryService.uploadImage(newImageFile);
        if (uploadedUrl != null) {
          photoUrl = uploadedUrl;
        }
      }

      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phone,
        'profilePic': photoUrl, // Save the URL
      });

      state = false; // Stop Loading
      return true;
    } catch (e) {
      state = false;
      print("Profile Update Error: $e");
      return false;
    }
  }
}
