import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.health_and_safety_rounded,
        'title': 'Disease Detection',
        'description': 'Identify plant diseases instantly using AI technology',
      },
      {
        'icon': Icons.psychology_rounded,
        'title': 'Expert Advice',
        'description': 'Get personalized recommendations for your crops',
      },
      {
        'icon': Icons.video_library_rounded,
        'title': 'Learning Resources',
        'description': 'Access videos and guides for better farming',
      },
    ];

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Image Section
          Container(
            height: 280,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade200.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Image.asset(
                "assets/images/intro-image.png",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  DefaultTextStyle(
                    style: TextStyle(),
                    child: Text(
                      "What FarmWise AI\nCan Do For You",
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.w700,
                        color: Colors.green.shade800,
                        height: 1.3,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  DefaultTextStyle(
                    style: TextStyle(),
                    child: Text(
                      "AI-powered tools for modern farming",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: Column(
                      children: features.map((feature) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.green.shade100,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    feature['icon'] as IconData,
                                    color: Colors.green.shade600,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DefaultTextStyle(
                                        style: TextStyle(),
                                        child: Text(
                                          feature['title'].toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green.shade800,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      DefaultTextStyle(
                                        style: TextStyle(),
                                        child: Text(
                                          feature['description'].toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
