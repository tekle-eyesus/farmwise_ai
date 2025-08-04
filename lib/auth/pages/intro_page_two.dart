import 'package:farmwise_ai/widgets/intro_features.dart';
import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, String>> features = [
      {
        'title': 'Disease Detection',
        'description':
            'Detect plant leaf diseases in potato, mango, and tomato crops using on-device machine learning.',
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
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color.fromARGB(255, 212, 237, 212),
            const Color.fromARGB(255, 147, 206, 148)
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          text: "What",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 23,
                          ),
                        ),
                        TextSpan(
                          text: " FarmWise AI",
                          style: TextStyle(
                            color: Colors.green.shade900,
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                        TextSpan(
                          text: " Can Do for You?",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 23,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                    fontStyle: FontStyle.italic,
                  ),
                  child: Text(
                    "Empowering Farmers. AI for Every Leaf",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ...features.map((feature) {
                  return Features(
                      title: feature["title"]!, desc: feature["description"]!);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
