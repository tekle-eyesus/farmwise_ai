import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'profile_controller.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Profile")),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
        data: (user) {
          if (user == null) return const Center(child: Text("User not found"));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/icons/profile_pic.png'),
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),

                // Display Info
                _buildInfoTile("First Name", user.firstName),
                _buildInfoTile("Last Name", user.lastName),
                _buildInfoTile("Email", user.email),
                _buildInfoTile("Phone", user.phoneNumber),

                const SizedBox(height: 30),

                // Edit Button
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditProfileScreen(user: user),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profile"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(
          value.isEmpty ? "Not set" : value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
