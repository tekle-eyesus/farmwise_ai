import 'package:farmwise_ai/language_classes/language_constants.dart';
import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.green.shade50,
            Colors.lightGreen.shade100,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.green.shade100.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.lightGreen.shade100.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo/Icon Container
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.green.shade400,
                        Colors.green.shade600,
                      ],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade300.withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/icons/farm.png",
                      width: 60,
                      height: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                        children: [
                          TextSpan(
                            text: translation(context).introPage1Welcome,
                            style: TextStyle(
                              color: Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: translation(context).introPage1Smart,
                            style: TextStyle(
                              color: Colors.green.shade700,
                            ),
                          ),
                          TextSpan(
                            text: translation(context).introPage1Crop,
                            style: TextStyle(
                              color: Colors.green.shade800,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          TextSpan(
                            text: translation(context).introPage1Ai,
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 60,
                      height: 4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green.shade400,
                            Colors.lightGreen.shade400,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 27,
                  ),
                  child: Text(
                    translation(context).introPage1Description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                      height: 1.6,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.green.shade100,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.shade100.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildFeatureItem(
                        icon: Icons.photo_camera_rounded,
                        text: translation(context).introPage1Feature1,
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureItem(
                        icon: Icons.psychology_rounded,
                        text: translation(context).introPage1Feature2,
                      ),
                      const SizedBox(height: 12),
                      _buildFeatureItem(
                        icon: Icons.video_library_rounded,
                        text: translation(context).introPage1Feature3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.green.shade100,
            ),
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.green.shade600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: DefaultTextStyle(
            style: TextStyle(),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
