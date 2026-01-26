import 'package:cached_network_image/cached_network_image.dart';
import 'package:smartcrop_ai/auth/auth_repository.dart';
import 'package:smartcrop_ai/language_classes/language_constants.dart';
import 'package:smartcrop_ai/profiles/profile_controller.dart';
import 'package:smartcrop_ai/profiles/profile_screen.dart';
import 'package:smartcrop_ai/screens/chat_history_screen.dart';
import 'package:smartcrop_ai/screens/saved_answers_screen.dart';
import 'package:smartcrop_ai/screens/saved_results_screen.dart';
import 'package:smartcrop_ai/screens/setting_screen.dart';
import 'package:smartcrop_ai/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrawerWidget extends ConsumerWidget {
  final Function(List<Map<String, dynamic>> messages, String? docId)
      onChatHistorySelected;
  const DrawerWidget({super.key, required this.onChatHistorySelected});

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
                  : translation(context).drawerUserNameDefault;
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
                  child: CachedNetworkImage(
                    imageUrl: user?.profilePic ??
                        'https://www.gravatar.com/avatar/placeholder?d=mp&s=200',
                    width: 100,
                    height: 100,
                    fit: BoxFit.fill,
                    placeholder: (context, url) => const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
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
            loading: () => UserAccountsDrawerHeader(
              accountName: Text(translation(context).drawerLoading),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(),
            ),
            error: (e, s) => UserAccountsDrawerHeader(
              accountName: Text(translation(context).drawerError),
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
                    translation(context).drawerMenuSavedChats,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
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
                    translation(context).drawerMenuSavedDetections,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
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
                    translation(context).drawerMenuSettings,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AppSettingScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: _buildListTileIcons(
                    Icons.history,
                    Colors.green.shade800,
                  ),
                  title: Text(
                    translation(context).historyChatTitle,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () async {
                    // 1. Close the Drawer first
                    Navigator.pop(context);

                    // 2. Open History Screen and WAIT for result
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatHistoryScreen(),
                      ),
                    );

                    // Check for the new Map structure
                    if (result != null && result is Map) {
                      final messages =
                          result['messages'] as List<Map<String, dynamic>>;
                      final docId = result['id'] as String;

                      // Pass both back to MainScreen
                      onChatHistorySelected(messages, docId);
                    }
                  },
                ),
                ListTile(
                  leading: _buildListTileIcons(
                    Icons.person,
                    Colors.green.shade800,
                  ),
                  title: Text(
                    translation(context).drawerMenuProfile,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
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
                    translation(context).drawerMenuLogout,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    ref.read(authRepositoryProvider).signOut();
                    CustomSnackBar.showSuccess(
                      context,
                      translation(context).drawerLogoutSuccess,
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
