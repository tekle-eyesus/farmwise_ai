import 'dart:io';
import 'package:farmwise_ai/data/disease_dummy_data.dart';
import 'package:farmwise_ai/models/detection_result_model.dart';
import 'package:farmwise_ai/screens/online_video_section.dart';
import 'package:farmwise_ai/services/local_storage_service.dart';
import 'package:farmwise_ai/utils/snackbar_helper.dart';
import 'package:farmwise_ai/widgets/article_section.dart';
import 'package:farmwise_ai/widgets/contact_support_section.dart';
import 'package:farmwise_ai/widgets/detection_header_section.dart';
import 'package:farmwise_ai/widgets/detection_image_overlay.dart';
import 'package:farmwise_ai/widgets/disease_confidence_chart.dart';
import 'package:farmwise_ai/widgets/expert_advice_widget.dart';
import 'package:farmwise_ai/widgets/recommended_actions_section.dart';
import 'package:flutter/material.dart';

class DetectResultScreen extends StatelessWidget {
  final String cropName;
  final File image;
  final List<Map<String, dynamic>> detectionResult;

  const DetectResultScreen({
    required this.cropName,
    required this.image,
    required this.detectionResult,
  });

  @override
  Widget build(BuildContext context) {
    final result = detectionResult[0];
    final label = result['label'];
    final confidence = result['confidence'];
    final Map<String, DiseaseInfo>? cropMap =
        cropDiseases[cropName.toLowerCase()];
    final DiseaseInfo? disease = cropMap?["${label.split('(')[0].trim()}"];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 8, 60, 55),
                const Color.fromARGB(255, 32, 84, 35),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        title: Text(
          "Detection Result",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.green.shade200,
            ),
            onPressed: () async {
              final result = SavedDetectionResult(
                cropName: cropName,
                imagePath: image.path,
                detectionResult: detectionResult,
                savedAt: DateTime.now(),
              );

              await LocalStorageService.saveResult(result);
              CustomSnackBar.showSuccess(
                context,
                "Result saved successfully!",
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DetectionImageOverlay(
              image: image,
              label: label,
              confidence: confidence,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetectionHeaderSection(
                    disease: disease!,
                    cropName: cropName,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DiseaseConfidenceChart(
                      results: detectionResult.map((e) {
                    return {
                      'label': e['label'],
                      'confidence': e['confidence'] ?? 0.0,
                    };
                  }).toList()),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RecommendedActionsSection(disease: disease),
                ],
              ),
            ),
            if (label != "Unknown")
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section header is now handled inside OnlineVideoSection
                    OnlineVideoSection(label: label),
                  ],
                ),
              ),
            if (label != "Unknown")
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ArticleSection(
                      diseaseLabel: label,
                      cropName: cropName,
                    ),
                  ],
                ),
              ),
            if (label != "Unknown")
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ContactSupportSection(
                      detectionResult: detectionResult,
                      diseaseLabel: label,
                      cropName: cropName,
                    ),
                  ],
                ),
              ),
            if (label != "Unknown")
              Container(
                margin: const EdgeInsets.symmetric(vertical: 3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpertAdviceWidget(
                      detectionResult: detectionResult,
                      cropName: cropName,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
