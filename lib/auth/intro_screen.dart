import 'package:farmwise_ai/auth/pages/intro_page_one.dart';
import 'package:farmwise_ai/auth/pages/intro_page_two.dart';
import 'package:farmwise_ai/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _pageController = PageController();
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView(
          controller: _pageController,
          onPageChanged: (index) {
            if (index == 1) {
              setState(() {
                isFirst = false;
              });
            } else {
              setState(() {
                isFirst = true;
              });
            }
          },
          children: const [
            PageOne(),
            PageTwo(),
          ],
        ),
        Container(
          alignment: const Alignment(0, 0.80),
          child: SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: WormEffect(
                dotColor: Colors.green.shade200,
                activeDotColor: Colors.green.shade600,
              ),
              onDotClicked: (index) {
                _pageController.jumpToPage(index);
              }),
        ),
        if (isFirst)
          Container(
            alignment: const Alignment(0.9, 0.93),
            child: IconButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Colors.yellow.withOpacity(0.45))),
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn,
                );
              },
              icon: const Icon(
                Icons.navigate_next,
              ),
            ),
          ),
        if (!isFirst)
          Container(
            alignment: const Alignment(0.9, 0.93),
            child: TextButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(
                  EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                ),
                backgroundColor: WidgetStatePropertyAll(
                  Colors.yellow.withOpacity(0.45),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MainScreen();
                    },
                  ),
                );
              },
              child: const Text(
                "Get Started",
                style: TextStyle(
                  color: Color.fromARGB(255, 38, 27, 58),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        if (!isFirst)
          Container(
            alignment: const Alignment(-0.9, 0.93),
            child: IconButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                      Colors.yellow.withOpacity(0.45))),
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeIn,
                );
              },
              icon: const Icon(
                Icons.navigate_before,
              ),
            ),
          ),
        if (isFirst)
          Positioned(
            top: 48,
            right: 10,
            child: TextButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(EdgeInsets.zero),
                backgroundColor: MaterialStatePropertyAll(
                  Color.fromARGB(252, 227, 220, 26),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MainScreen();
                    },
                  ),
                );
              },
              child: Text(
                "Skip",
                style: TextStyle(
                  color: Colors.green.shade900,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
