import 'package:farmwise_ai/auth/auth_repository.dart';
import 'package:farmwise_ai/profiles/profile_controller.dart';
import 'package:farmwise_ai/profiles/profile_screen.dart';
import 'package:farmwise_ai/screens/saved_answers_screen.dart';
import 'package:farmwise_ai/screens/saved_results_screen.dart';
import 'package:farmwise_ai/screens/setting_screen.dart';
import 'package:farmwise_ai/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          userAsync.when(
            data: (user) {
              final displayName = (user != null && user.firstName.isNotEmpty)
                  ? "${user.firstName} ${user.lastName}"
                  : "FarmWise User";
              final email = user?.email ?? "";

              return UserAccountsDrawerHeader(
                accountName: Text(
                  displayName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                accountEmail: Text(
                  email,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                currentAccountPicture: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.asset(
                    "assets/icons/profile_pic.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 8, 60, 55),
                      const Color.fromARGB(255, 32, 84, 35),
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
              );
            },
            loading: () => const UserAccountsDrawerHeader(
              accountName: Text("Loading..."),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(),
            ),
            error: (e, s) => const UserAccountsDrawerHeader(
              accountName: Text("Error"),
              accountEmail: Text(""),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: _buildListTileIcons(
                    Icons.history,
                    Colors.green.shade800,
                  ),
                  title: Text(
                    "Saved Chats",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SavedAnswersScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: _buildListTileIcons(
                    Icons.save_alt_rounded,
                    Colors.green.shade800,
                  ),
                  title: Text(
                    "Saved Detection Results",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SavedResultsScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: _buildListTileIcons(
                    Icons.settings,
                    Colors.green.shade800,
                  ),
                  title: Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AppSettingScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: _buildListTileIcons(
                    Icons.person,
                    Colors.green.shade800,
                  ),
                  title: Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer first
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: _buildListTileIcons(
                    Icons.logout,
                    Colors.green.shade800,
                  ),
                  title: Text(
                    "Log out",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    ref.read(authRepositoryProvider).signOut();
                    CustomSnackBar.showSuccess(
                      context,
                      "Logged out successfully",
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTileIcons(IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
