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
              "John Doe",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            accountEmail: Text(
              "johndoe@example.com",
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
                  Colors.green.shade900,
                  Colors.green.shade800,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text(
                    "Saved Chats",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  onTap: () {
                    // Navigate to saved chats screen
                  },
                ),
                ListTile(
                  leading: Icon(Icons.scatter_plot_rounded),
                  title: Text(
                    "Saved Detection Results",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  onTap: () {
                    // Navigate to saved detections screen
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
