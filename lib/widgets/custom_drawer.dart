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
                fontSize: 20,
              ),
            ),
            currentAccountPicture: Image.asset(
              "assets/icons/user.png",
              width: 50,
              height: 50,
              color: Colors.grey,
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
                  leading: Icon(
                    Icons.history,
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
                  leading: Icon(Icons.save_alt_rounded),
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
                  leading: Icon(Icons.settings),
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
}
