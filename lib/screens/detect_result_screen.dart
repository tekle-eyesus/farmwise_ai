import 'dart:io';
import 'package:farmwise_ai/data/disease_dummy_data.dart';
import 'package:farmwise_ai/models/detection_result_model.dart';
import 'package:farmwise_ai/screens/online_video_section.dart';
import 'package:farmwise_ai/services/local_storage_service.dart';
import 'package:farmwise_ai/utils/snackbar_helper.dart';
import 'package:farmwise_ai/widgets/article_section.dart';
import 'package:farmwise_ai/widgets/disease_confidence_chart.dart';
import 'package:farmwise_ai/widgets/expert_advice_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
        backgroundColor: Colors.green.shade100,
        title: Text(
          "Detection Result",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
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
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: Image.file(
                    image,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: label == "Healthy"
                          ? Colors.green
                          : const Color.fromARGB(188, 244, 40, 25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: CircularPercentIndicator(
                    radius: 30.0,
                    lineWidth: 7.0,
                    animation: true,
                    animationDuration: 2300,
                    percent: result['confidence'] / 100,
                    linearGradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 8, 60, 55),
                        Colors.lightGreenAccent
                      ],
                    ),
                    center: CircleAvatar(
                      radius: 23,
                      backgroundColor: const Color.fromARGB(191, 0, 0, 0),
                      child: Text(
                        confidence.toStringAsFixed(1) + "%",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    footer: Container(
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 7),
                      margin: EdgeInsets.only(top: 3),
                      child: Text(
                        "confidence",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 17),
              decoration: BoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    disease!.title,
                    style: TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MarkdownBody(
                    data: disease.description,
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                        .copyWith(
                      p: const TextStyle(fontSize: 16, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            DiseaseConfidenceChart(
              results: detectionResult.map((e) {
                return {
                  'label': e['label'],
                  'confidence': e['confidence'] ?? 0.0,
                };
              }).toList(),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommended Actions",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ...disease.recommendations.map((Recommendation r) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: const Color.fromARGB(167, 200, 230, 201),
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          "assets/icons/right.png",
                          width: 38,
                          height: 38,
                        ),
                        title: Text(
                          r.title,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: MarkdownBody(
                          data: r.subtitle,
                          styleSheet: MarkdownStyleSheet.fromTheme(
                            Theme.of(
                              context,
                            ),
                          ).copyWith(
                            p: TextStyle(
                              fontSize: 16,
                              height: 1.4,
                              color: Colors.green.shade900,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
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
