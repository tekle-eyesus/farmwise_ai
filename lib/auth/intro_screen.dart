import 'package:farmwise_ai/auth/login_screen.dart';
import 'package:farmwise_ai/auth/pages/intro_page_one.dart';
import 'package:farmwise_ai/auth/pages/intro_page_two.dart';
import 'package:farmwise_ai/language_classes/language.dart';
import 'package:farmwise_ai/language_classes/language_constants.dart';
import 'package:farmwise_ai/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _pageController = PageController();
  bool isFirst = true;
  String _selectedLanguage = 'English';

  Future<void> _completeIntro(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isIntroSeen', true);

    if (context.mounted) {
      // Navigate to Login, remove Intro from back stack
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    Locale locale = await getLocale();
    setState(() {
      _selectedLanguage = Language.languageList()
          .firstWhere((lang) => lang.languageCode == locale.languageCode)
          .name;
    });
  }

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
                _completeIntro(context);
              },
              child: Text(
                translation(context).actionGetStarted,
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
                _completeIntro(context);
              },
              child: Text(
                translation(context).actionSkip,
                style: TextStyle(
                  color: Colors.green.shade900,
                ),
              ),
            ),
          ),
        Positioned(
          top: 48,
          left: 10,
          child: SizedBox(
            width: 700,
            height: 36,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Language.languageList().length,
              itemBuilder: (context, index) {
                Language language = Language.languageList()[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                      backgroundColor: _selectedLanguage == language.name
                          ? MaterialStatePropertyAll(
                              Color.fromARGB(252, 227, 220, 26),
                            )
                          : MaterialStatePropertyAll(
                              Colors.grey.shade300,
                            ),
                    ),
                    onPressed: () async {
                      Locale _locale = await setLocale(language.languageCode);
                      MyApp.setLocale(context, _locale);
                      setState(
                        () {
                          _selectedLanguage = language.name;
                        },
                      );
                    },
                    child: Text(
                      language.name,
                      style: TextStyle(
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
