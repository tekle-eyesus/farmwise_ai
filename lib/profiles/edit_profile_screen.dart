import 'package:farmwise_ai/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import 'profile_controller.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final UserModel user;
  const EditProfileScreen({super.key, required this.user});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController _fnameController;
  late TextEditingController _lnameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Pre-fill fields with existing data
    _fnameController = TextEditingController(text: widget.user.firstName);
    _lnameController = TextEditingController(text: widget.user.lastName);
    _phoneController = TextEditingController(text: widget.user.phoneNumber);
  }

  @override
  void dispose() {
    _fnameController.dispose();
    _lnameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveProfile() async {
    final success =
        await ref.read(profileControllerProvider.notifier).updateProfile(
              uid: widget.user.uid,
              firstName: _fnameController.text.trim(),
              lastName: _lnameController.text.trim(),
              phone: _phoneController.text.trim(),
            );

    if (success && mounted) {
      Navigator.pop(context);
      CustomSnackBar.showSuccess(context, "Profile updated successfully");
    } else if (mounted) {
      CustomSnackBar.showError(context, "Failed to update profile");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _fnameController,
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _lnameController,
                    decoration: const InputDecoration(labelText: 'Last Name'),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _phoneController,
                    decoration:
                        const InputDecoration(labelText: 'Phone Number'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    child: const Text("Save Changes"),
                  ),
                ],
              ),
            ),
    );
  }
}
