import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartcrop_ai/language_classes/language_constants.dart';
import 'package:smartcrop_ai/utils/snackbar_helper.dart';

class ForgotPasswordSheet extends StatefulWidget {
  const ForgotPasswordSheet({super.key});

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final Color primaryGreen = const Color(0xFF1E5631);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context);
        CustomSnackBar.showSuccess(
          context,
          translation(context).forgotPasswordSuccess,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = translation(context).forgotPasswordErrorGeneral;
      if (e.code == 'user-not-found') {
        errorMessage = translation(context).forgotPasswordErrorNoUser;
      } else if (e.code == 'invalid-email') {
        errorMessage = translation(context).forgotPasswordErrorInvalidFormat;
      }

      if (mounted) {
        CustomSnackBar.showError(context, errorMessage);
      }
    } catch (e) {
      if (mounted) {
        // CustomSnackBar.showError(context, "Error: ${e.toString()}");
        CustomSnackBar.showError(
          context,
          translation(context).forgotPasswordErrorUnexpected,
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.lock_reset, color: primaryGreen, size: 28),
                const SizedBox(width: 10),
                Text(
                  translation(context).forgotPasswordTitle,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              translation(context).forgotPasswordSubtitle,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 20),

            // Email Input
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: translation(context).forgotPasswordEmailLabel,
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: primaryGreen, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return translation(context).forgotPasswordEmailEmpty;
                }
                if (!value.contains('@')) {
                  return translation(context).forgotPasswordEmailInvalid;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Reset Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _resetPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.green,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        translation(context).forgotPasswordActionSend,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
