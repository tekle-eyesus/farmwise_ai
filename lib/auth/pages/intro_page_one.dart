import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromARGB(255, 212, 237, 212),
            const Color.fromARGB(255, 113, 204, 114)
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            child: Image.asset(
              "assets/icons/farm.png",
              height: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          // heTading
          DefaultTextStyle(
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Welcome to ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  TextSpan(
                    text: "Farm",
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.w500,
                      fontSize: 35,
                    ),
                  ),
                  TextSpan(
                    text: "Wise",
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.w500,
                      fontSize: 35,
                    ),
                  ),
                  TextSpan(
                    text: " AI",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 35,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          const DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 27,
            ),
            child: Text(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
                "Smart crop care at your fingertips - diagnose, learn, and grow better, anywhere."),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
