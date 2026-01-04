import 'package:farmwise_ai/language_classes/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './profile_controller.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(translation(context).profileTitle,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
            child: Text(translation(context).profileError(err.toString()))),
        data: (user) {
          if (user == null)
            return Center(
                child: Text(translation(context).profileUserNotFound));

          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 240,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromARGB(255, 8, 60, 55),
                            const Color.fromARGB(255, 32, 84, 35),
                          ],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    // Avatar
                    Positioned(
                      bottom: -50,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: (user.profilePic != null &&
                                  user.profilePic!.isNotEmpty)
                              ? Image.network(user.profilePic).image
                              : null,
                          child: (user.profilePic == null ||
                                  user.profilePic!.isEmpty)
                              ? const Icon(Icons.person,
                                  size: 60, color: Colors.grey)
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                Text(
                  user.email,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      _buildInfoTile(
                          Icons.phone,
                          translation(context).profilePhoneLabel,
                          user.phoneNumber,
                          context),
                      _buildInfoTile(
                          Icons.email,
                          translation(context).profileEmailLabel,
                          user.email,
                          context),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProfileScreen(user: user),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                      label: Text(translation(context).profileActionEdit,
                          style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F5132),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(
      IconData icon, String label, String value, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.green[800], size: 22),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              const SizedBox(height: 4),
              Text(
                value.isEmpty ? translation(context).profileValueNotSet : value,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
