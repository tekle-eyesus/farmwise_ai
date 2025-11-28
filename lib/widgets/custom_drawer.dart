import 'package:farmwise_ai/screens/saved_answers_screen.dart';
import 'package:farmwise_ai/screens/saved_results_screen.dart';
import 'package:farmwise_ai/screens/setting_screen.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Profile Section
          UserAccountsDrawerHeader(
            accountName: Text(
              "Tekleeyesus Munye",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            accountEmail: Text(
              "tekleeysus21@gmail.com",
              style: TextStyle(
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
