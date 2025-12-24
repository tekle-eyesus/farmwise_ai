import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

final currentUserIdProvider = Provider<String?>((ref) {
  return FirebaseAuth.instance.currentUser?.uid;
});

final userProfileProvider = StreamProvider<UserModel?>((ref) {
  final uid = ref.watch(currentUserIdProvider);

  if (uid == null) {
    return Stream.value(null);
  }

  return FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .snapshots()
      .map((snapshot) {
    if (snapshot.exists && snapshot.data() != null) {
      return UserModel.fromMap(snapshot.data()!);
    }
    return null;
  });
});

// class for Edit actions
final profileControllerProvider =
    StateNotifierProvider<ProfileController, bool>((ref) {
  return ProfileController();
});

class ProfileController extends StateNotifier<bool> {
  ProfileController() : super(false); // false = not loading

  Future<bool> updateProfile({
    required String uid,
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    state = true; // Loading
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phone,
      });
      state = false;
      return true;
    } catch (e) {
      state = false;
      return false;
    }
  }
}
