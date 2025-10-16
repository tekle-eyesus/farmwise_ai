import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:farmwise_ai/data/disease_dummy_data.dart';

class RecommendedActionsSection extends StatelessWidget {
  final DiseaseInfo disease;

  const RecommendedActionsSection({
    super.key,
    required this.disease,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade400,
                        Colors.green.shade600,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "Recommended Actions",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade800,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.green.shade200,
                    ),
                  ),
                  child: Text(
                    '${disease.recommendations.length} steps',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // action list
          ...disease.recommendations.asMap().entries.map((entry) {
            final index = entry.key;
            final recommendation = entry.value;
            final isLast = index == disease.recommendations.length - 1;

            return _buildActionCard(
              recommendation: recommendation,
              stepNumber: index + 1,
              isLast: isLast,
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required Recommendation recommendation,
    required int stepNumber,
    required bool isLast,
  }) {
    final IconData icon = _getActionIcon(recommendation.title);

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // Optional
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green.shade50,
                  Colors.lightGreen.shade50,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.green.shade100,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.shade100.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.green.shade200,
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      icon,
                      size: 20,
                      color: Colors.green.shade700,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recommendation.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.green.shade900,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        MarkdownBody(
                          data: recommendation.subtitle,
                          styleSheet: MarkdownStyleSheet(
                            p: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade700,
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                            ),
                            strong: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getActionIcon(String title) {
    final lowerTitle = title.toLowerCase();

    if (lowerTitle.contains('spray') || lowerTitle.contains('apply')) {
      return Icons.clean_hands_rounded;
    } else if (lowerTitle.contains('remove') || lowerTitle.contains('prune')) {
      return Icons.content_cut_rounded;
    } else if (lowerTitle.contains('water') || lowerTitle.contains('irrigat')) {
      return Icons.water_drop_rounded;
    } else if (lowerTitle.contains('fertiliz') ||
        lowerTitle.contains('nutrient')) {
      return Icons.grass_rounded;
    } else if (lowerTitle.contains('monitor') || lowerTitle.contains('check')) {
      return Icons.visibility_rounded;
    } else if (lowerTitle.contains('soil') || lowerTitle.contains('ground')) {
      return Icons.landscape_rounded;
    } else {
      return Icons.agriculture_rounded;
    }
  }
}
