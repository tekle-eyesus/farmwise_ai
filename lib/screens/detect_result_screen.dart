import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smartcrop_ai/language_classes/language_constants.dart';
import 'package:smartcrop_ai/models/detection_result_model.dart';
import 'package:smartcrop_ai/models/disease_response_model.dart'; // Import New Model
import 'package:smartcrop_ai/screens/online_video_section.dart';
import 'package:smartcrop_ai/services/local_storage_service.dart';
import 'package:smartcrop_ai/utils/snackbar_helper.dart';
import 'package:smartcrop_ai/widgets/article_section.dart';
import 'package:smartcrop_ai/widgets/detection_header_section.dart';
import 'package:smartcrop_ai/widgets/detection_image_overlay.dart';
import 'package:smartcrop_ai/widgets/disease_confidence_chart.dart';

class DetectResultScreen extends StatefulWidget {
  final String cropName;
  final File image;
  final DiseaseResponse apiResponse; // Changed from List<Map>
  final String? existingKey;

  const DetectResultScreen({
    super.key,
    required this.cropName,
    required this.image,
    required this.apiResponse,
    this.existingKey,
  });

  @override
  State<DetectResultScreen> createState() => _DetectResultScreenState();
}

class _DetectResultScreenState extends State<DetectResultScreen> {
  String? _savedKey;
  bool get _isSaved => _savedKey != null;
  // Helper to format API string "wheat_stripe_rust" -> "Stripe Rust"
  String _formatDiseaseName(String apiClass) {
    if (apiClass.toLowerCase() == "healthy") return "Healthy";

    // Remove crop name if it exists in the label to find the disease name
    String clean = apiClass.replaceAll('_', ' ');
    String lowerCrop = widget.cropName.toLowerCase();

    if (clean.startsWith(lowerCrop)) {
      clean = clean.substring(lowerCrop.length).trim();
    }

    return clean
        .split(' ')
        .map((str) =>
            str.length > 0 ? '${str[0].toUpperCase()}${str.substring(1)}' : '')
        .join(' ');
  }

  Future<void> _toggleSave() async {
    if (_isSaved) {
      await LocalStorageService.deleteResult(_savedKey!);

      setState(() {
        _savedKey = null; // Mark as unsaved
      });

      if (mounted) {
        CustomSnackBar.showInfo(
          context,
          translation(context).detMsgRemoved,
        );
      }
    } else {
      final result = SavedDetectionResult(
        cropName: widget.cropName,
        imagePath: widget.image.path,
        fullApiResponse: widget.apiResponse.rawJson,
        savedAt: DateTime.now(),
      );

      final String newKey = await LocalStorageService.saveResult(result);

      setState(() {
        _savedKey = newKey; // Mark as saved
      });

      if (mounted) {
        CustomSnackBar.showSuccess(context, translation(context).detMsgSaved);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _savedKey = widget.existingKey;
  }

  @override
  Widget build(BuildContext context) {
    //  Extract Data from API Response
    final String rawLabel = widget.apiResponse.disease.predictedClass;
    final String displayLabel = _formatDiseaseName(rawLabel); // "Stripe Rust"
    final double confidence = widget.apiResponse.disease.confidence * 100;
    final String severity = widget.apiResponse.severity?.level ?? "Unknown";
    final double severityPercent =
        (widget.apiResponse.severity?.affectedPercentage ?? 0.0);

    return Scaffold(
      appBar: AppBar(
        title: Text(translation(context).detTitle),
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
        actions: [
          IconButton(
            onPressed: _toggleSave,
            icon: Icon(
              _isSaved
                  ? Icons.bookmark_added_rounded
                  : Icons.bookmark_border_rounded,
              color: _isSaved ? Colors.white : Colors.green.shade200,
              size: 28,
            ),
            tooltip: _isSaved
                ? translation(context).detActionRemove
                : translation(context).detActionSave,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Detection Image Overlay
            DetectionImageOverlay(
              image: widget.image,
              label: displayLabel,
              confidence: confidence,
              segmentationData: widget.apiResponse.rawJson['segmentation'],
            ),

            // Severity Card (NEW FEATURE based on API)
            if (rawLabel != "Healthy")
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: severity == "High"
                      ? Colors.red.shade50
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: severity == "High"
                          ? Colors.red.shade200
                          : Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded,
                        color: severity == "High" ? Colors.red : Colors.orange,
                        size: 30),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${translation(context).detLabelSeverity} $severity",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: severity == "High"
                                    ? Colors.red[900]
                                    : Colors.orange[900])),
                        Text(
                          "${widget.apiResponse.rawJson['segmentation']["affected_area"].toString()} px² affected (${severityPercent.toStringAsFixed(2)}%)",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

            //Detection Header Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16), // Padding for the container
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: DetectionHeaderSection(
                apiResponse: widget.apiResponse, // Pass the full API model
                cropName: widget.cropName,
              ),
            ),

            const SizedBox(height: 16),

            //  Confidence Chart
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade200, blurRadius: 5)
                ],
              ),
              child: DiseaseConfidenceChart(
                results: widget.apiResponse.disease.topPredictions
                    .map((e) => {
                          'label': _formatDiseaseName(e.label),
                          'confidence': e.confidence,
                        })
                    .toList(),
              ),
            ),

            // 5. YouTube Resources (Pass the Clean Label)
            if (rawLabel.toLowerCase() != "healthy")
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: OnlineVideoSection(
                  label: "${widget.cropName} $displayLabel",
                ), // Search: "Wheat Stripe Rust"
              ),

            // 6. Articles
            if (rawLabel.toLowerCase().contains("healthy") == false)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ArticleSection(
                  diseaseLabel: displayLabel,
                  cropName: widget.cropName,
                ),
              ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
