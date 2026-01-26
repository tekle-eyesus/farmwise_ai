import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetectionImageOverlay extends StatelessWidget {
  final File image;
  final String label;
  final double confidence;
  final Map<dynamic, dynamic>? segmentationData;

  const DetectionImageOverlay({
    super.key,
    required this.image,
    required this.label,
    required this.confidence,
    required this.segmentationData,
  });

  @override
  Widget build(BuildContext context) {
    final bool isHealthy = label.toLowerCase().contains("healthy");
    final double confidencePercent = confidence / 100;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Image.file(
            image,
            height: 230,
            fit: BoxFit.cover,
          ),
        ),

        Positioned(
          left: 16,
          top: 16,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isHealthy
                    ? [
                        Colors.green.shade600,
                        Colors.green.shade400,
                      ]
                    : [
                        Colors.orange.shade600,
                        Colors.red.shade500,
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isHealthy
                      ? Icons.check_circle_rounded
                      : Icons.warning_rounded,
                  size: 16,
                  color: Colors.white,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 12,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Confidence Text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${confidence.toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                        color: _getConfidenceColor(confidence),
                      ),
                    ),
                    Text(
                      'Confidence',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                CircularPercentIndicator(
                  radius: 20.0,
                  lineWidth: 4.0,
                  animation: true,
                  percent: confidencePercent,
                  circularStrokeCap: CircularStrokeCap.round,
                  backgroundColor: Colors.grey.shade200,
                  linearGradient: LinearGradient(
                    colors: _getConfidenceGradient(confidence),
                  ),
                  center: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getConfidenceColor(confidence).withOpacity(0.1),
                    ),
                    child: Icon(
                      confidence >= 80
                          ? Icons.verified_rounded
                          : confidence >= 60
                              ? Icons.trending_up_rounded
                              : Icons.info_outline_rounded,
                      size: 14,
                      color: _getConfidenceColor(confidence),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // fot segmentation overlay
        if (segmentationData != null)
          Positioned(
            bottom: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                "Leaf area: ${segmentationData!["leaf_area"].toString()} px²",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
        // bootom shadow
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.4),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 80) return Colors.green;
    if (confidence >= 60) return Colors.orange;
    return Colors.red;
  }

  List<Color> _getConfidenceGradient(double confidence) {
    if (confidence >= 80) {
      return [Colors.green.shade400, Colors.green.shade600];
    } else if (confidence >= 60) {
      return [Colors.orange.shade400, Colors.orange.shade600];
    } else {
      return [Colors.red.shade400, Colors.red.shade600];
    }
  }
}
