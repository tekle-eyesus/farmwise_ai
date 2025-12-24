import 'package:farmwise_ai/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_repository.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(authRepository: ref.watch(authRepositoryProvider));
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(false); // false = not loading

  Future<bool> signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    state = true; // Set loading to true
    try {
      await _authRepository.signIn(email, password);
      return true;
    } catch (e) {
      CustomSnackBar.showError(
        context,
        e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    } finally {
      state = false;
    }
  }

  Future<bool> signUp({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required String phoneNumber,
    required bool isTermsAccepted,
    required BuildContext context,
  }) async {
    state = true;
    try {
      await _authRepository.signUp(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
        phoneNumber: phoneNumber,
        isTermsAccepted: isTermsAccepted,
      );

      return true;
    } catch (e) {
      CustomSnackBar.showError(
        context,
        e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    } finally {
      state = false;
    }
  }

  void signOut() {
    _authRepository.signOut();
  }
}
