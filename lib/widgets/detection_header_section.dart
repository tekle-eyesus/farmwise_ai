import 'package:flutter/material.dart';
import 'package:smartcrop_ai/models/disease_response_model.dart'; // Ensure correct path

class DetectionHeaderSection extends StatelessWidget {
  final DiseaseResponse apiResponse;
  final String cropName;

  const DetectionHeaderSection({
    super.key,
    required this.apiResponse,
    required this.cropName,
  });

  // Helper: Format "wheat_stripe_rust" -> "Stripe Rust"
  String _formatLabel(String raw) {
    String label = raw.replaceAll('_', ' ');
    if (label.toLowerCase().startsWith(cropName.toLowerCase())) {
      label = label.substring(cropName.length).trim();
    }
    if (label.isEmpty) return raw; // Fallback
    return label
        .split(' ')
        .map((str) =>
            str.isNotEmpty ? '${str[0].toUpperCase()}${str.substring(1)}' : '')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    print("API Response: ${apiResponse.rawJson}");
    // 1. Prepare Data
    final prediction = apiResponse.disease;
    final severity = apiResponse.severity;
    final segmentation = apiResponse
        .rawJson['segmentation']; // Access raw for leaf area if needed

    // Logic: Healthy vs Disease
    final bool isHealthy =
        prediction.predictedClass.toLowerCase().contains("healthy");
    final String label = _formatLabel(prediction.predictedClass);

    // Math: Convert Confidence 0.76 -> 76.6%
    final String confidencePct =
        "${(prediction.confidence * 100).toStringAsFixed(1)}%";

    // Colors based on result
    final Color mainColor = isHealthy
        ? Colors.green
        : (severity?.level == "High" ? Colors.red : Colors.orange);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- 1. Header Title ---
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 45,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [mainColor.withOpacity(0.6), mainColor],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Diagnosis',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _buildStatCard(
              icon: Icons.analytics_outlined,
              label: "Confidence",
              value: confidencePct,
              color: Colors.blue,
            ),

            // Severity (Only if available)
            if (severity != null)
              _buildStatCard(
                icon: Icons.warning_amber_rounded,
                label: "Severity",
                value: severity.level,
                color: severity.level == "High" ? Colors.red : Colors.orange,
              ),

            // Affected Area (Only if available)
            if (severity != null)
              _buildStatCard(
                icon: Icons.texture,
                label: "Affected Area",
                value: "${severity.affectedPercentage}%",
                color: Colors.purple,
              ),

            if (apiResponse.rawJson['detections'] != null)
              _buildStatCard(
                icon: Icons.bug_report_outlined,
                label: "Detections",
                value: "${apiResponse.rawJson['detections']['count'] ?? 0}",
                color: Colors.brown,
              ),

            //  Leaf Area (Optional context)
            if (segmentation != null && !isHealthy)
              _buildStatCard(
                  icon: Icons.grass,
                  label: "Leaf Size (px)",
                  value: "${(segmentation['leaf_area'] as num).toInt()}",
                  color: Colors.teal),
          ],
        ),
      ],
    );
  }

  // --- Helper Widget for Small Cards ---
  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      width: 163,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16, color: color),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
