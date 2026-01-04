import 'dart:io';
import 'package:farmwise_ai/language_classes/language_constants.dart';
import 'package:farmwise_ai/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../models/user_model.dart';
import './profile_controller.dart';

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

  File? _pickedImage;

  @override
  void initState() {
    super.initState();
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

  // Logic to Pick Image
  Future<void> _pickImage() async {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.photo_library,
                  color: Colors.red[800],
                  size: 22,
                ),
              ),
              title: Text(
                translation(context).editProfilePhotoLibrary,
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => _getImage(ImageSource.gallery),
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.green[800],
                  size: 22,
                ),
              ),
              title: Text(
                translation(context).editProfileCamera,
                style: TextStyle(fontSize: 16),
              ),
              onTap: () => _getImage(ImageSource.camera),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getImage(ImageSource source) async {
    Navigator.of(context).pop();
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 70);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _saveProfile() async {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    final success =
        await ref.read(profileControllerProvider.notifier).updateProfile(
              uid: widget.user.uid,
              firstName: _fnameController.text.trim(),
              lastName: _lnameController.text.trim(),
              phone: _phoneController.text.trim(),
              newImageFile: _pickedImage,
              currentImageUrl: widget.user.profilePic,
            );

    if (success && mounted) {
      Navigator.pop(context);
      CustomSnackBar.showSuccess(
          context, translation(context).editProfileSuccess);
    } else if (mounted) {
      CustomSnackBar.showError(
          context, translation(context).editProfileFailure);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).editProfileTitle),
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage!) as ImageProvider
                              : (widget.user.profilePic != null &&
                                      widget.user.profilePic!.isNotEmpty)
                                  ? Image.network(widget.user.profilePic!).image
                                  : null,
                          child: (_pickedImage == null &&
                                  (widget.user.profilePic == null ||
                                      widget.user.profilePic!.isEmpty))
                              ? const Icon(Icons.person,
                                  size: 55, color: Colors.grey)
                              : null,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green[800],
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.camera_alt,
                                size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField(translation(context).editProfileFirstName,
                    _fnameController, Icons.person_outline),
                const SizedBox(height: 15),
                _buildTextField(translation(context).editProfileLastName,
                    _lnameController, Icons.person_outline),
                const SizedBox(height: 15),
                _buildTextField(translation(context).editProfilePhone,
                    _phoneController, Icons.phone_android),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F5132),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(translation(context).editProfileActionSave,
                        style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black45,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: Colors.green),
                      SizedBox(height: 10),
                      Text(translation(context).editProfileSaving),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
