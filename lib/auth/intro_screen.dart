import 'package:farmwise_ai/screens/main_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> features = [
      {
        'title': 'Disease Detection',
        'description':
            'Detect plant leaf diseases in coffee, mango, and tomato crops using on-device machine learning.',
      },
      {
        'title': 'Personalized Advice',
        'description':
            'Get personalized agricultural advice tailored to your crops and detected diseases.',
      },
      {
        'title': 'Multimedia Resources',
        'description':
            'Access multimedia resources and best practices to empower farmers and support sustainable farming.',
      }
    ];
    return Scaffold(
      backgroundColor: Colors.green.shade100,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 370,
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/intro-image.png"),
                  ),
                ),
              ),
            ),
            // the title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/farm.png",
                  width: 35,
                  height: 35,
                  color: Colors.green.shade900,
                ),
                const SizedBox(
                  width: 10,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                    children: [
                      TextSpan(
                        text: "Farm",
                        style: TextStyle(
                          color: Colors.green.shade800,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(
                        text: "Wise",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.green.shade400,
                        ),
                      ),
                      TextSpan(
                        text: " AI",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Empowering farmers with AI-driven insights for healthier crops and sustainable agriculture.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: features.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  final feature = features[index];
                  return Card(
                    shadowColor: Colors.transparent,
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    elevation: 2,
                    color: Colors.green.shade200,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feature['title']!,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.green.shade800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            feature['description']!,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
