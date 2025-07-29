import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/farm.png',
            width: 56,
            height: 56,
            color: Colors.green.shade800,
          ),
          SizedBox(height: 13),
          Text(
            "👩‍🌾 I'm your Farm Assistant",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Colors.green.shade900,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Ask me anything about your $title farm.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
