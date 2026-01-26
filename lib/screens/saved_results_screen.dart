import 'dart:io';
import 'package:smartcrop_ai/language_classes/language_constants.dart';
import 'package:smartcrop_ai/models/disease_response_model.dart'; // Import New Model
import 'package:smartcrop_ai/screens/detect_result_screen.dart'; // Import Result Screen
import 'package:smartcrop_ai/utils/date_utils.dart';
import 'package:smartcrop_ai/utils/snackbar_helper.dart';
import 'package:flutter/material.dart';
import '../services/local_storage_service.dart';

class SavedResultsScreen extends StatefulWidget {
  const SavedResultsScreen({super.key});

  @override
  State<SavedResultsScreen> createState() => _SavedResultsScreenState();
}

class _SavedResultsScreenState extends State<SavedResultsScreen> {
  // Helper to format "wheat_stripe_rust" -> "Stripe Rust"
  String _formatLabel(String raw, String cropName) {
    String label = raw.replaceAll('_', ' ');
    if (label.toLowerCase().startsWith(cropName.toLowerCase())) {
      label = label.substring(cropName.length).trim();
    }
    if (label.isEmpty) return raw;
    return label
        .split(' ')
        .map((str) =>
            str.isNotEmpty ? '${str[0].toUpperCase()}${str.substring(1)}' : '')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final savedEntries = LocalStorageService.getSavedResults();
    savedEntries.sort((a, b) => b.value.savedAt.compareTo(a.value.savedAt));

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 8, 60, 55),
                Color.fromARGB(255, 32, 84, 35),
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          translation(context).scansTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: savedEntries.isEmpty
          ? _buildEmptyState()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildHeaderStats(savedEntries.length),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: savedEntries.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final entry = savedEntries[index];
                        final key = entry.key;
                        final result = entry.value;

                        return _buildScanCard(
                          context,
                          key,
                          result,
                          index == savedEntries.length - 1,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.photo_camera_back_rounded,
              size: 50,
              color: Colors.green.shade400,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            translation(context).scansEmptyState,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              translation(context).scansEmptySubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context); // Go back to camera screen
            },
            icon: const Icon(Icons.camera_alt_rounded),
            label: Text(translation(context).scansActionStartNew),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderStats(int count) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.photo_library_rounded,
              color: Colors.green.shade700,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translation(context).scansTotalCount,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  translation(context).scansCount(count),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanCard(
      BuildContext context, String key, dynamic result, bool isLast) {
    // 1. Parse Raw JSON from Hive
    final rawData = result.fullApiResponse;
    final String rawLabel = rawData['disease']['predicted_class'] ?? "Unknown";
    final double rawConfidence =
        (rawData['disease']['confidence'] ?? 0.0).toDouble();

    // 2. Format Data
    final String label = _formatLabel(rawLabel, result.cropName);
    final String confidencePercent =
        "${(rawConfidence * 100).toStringAsFixed(1)}%";
    final bool isImageAvailable = File(result.imagePath).existsSync();

    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Reconstruct the full object to pass to Result Screen
            final apiResponseObj = DiseaseResponse.fromJson(rawData);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetectResultScreen(
                  cropName: result.cropName,
                  image: File(result.imagePath),
                  apiResponse: apiResponseObj,
                  existingKey: key,
                ),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200.withOpacity(0.8),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(
                color: Colors.grey.shade100,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Image Thumbnail
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green.shade50,
                    image: isImageAvailable
                        ? DecorationImage(
                            image: FileImage(File(result.imagePath)),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: !isImageAvailable
                      ? Icon(Icons.broken_image_rounded, color: Colors.grey)
                      : Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ),
                ),
                const SizedBox(width: 16),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getConfidenceColor(rawConfidence)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _getConfidenceColor(rawConfidence)
                                .withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified_rounded,
                              size: 12,
                              color: _getConfidenceColor(rawConfidence),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              translation(context).scansConfidenceLabel(
                                confidencePercent,
                              ),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getConfidenceColor(rawConfidence),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateUtilsHelper.formatReadable(result.savedAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            result.cropName,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),

                // Actions (Delete/Arrow)
                Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red.shade100),
                      ),
                      child: IconButton(
                        onPressed: () async {
                          final shouldDelete =
                              await _showDeleteConfirmation(context);
                          if (shouldDelete ?? false) {
                            await LocalStorageService.deleteResult(key);
                            CustomSnackBar.showSuccess(context,
                                translation(context).scansDeletedSnackbar);
                            setState(() {});
                          }
                        },
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          size: 18,
                          color: Colors.red.shade600,
                        ),
                        padding: EdgeInsets.zero,
                        tooltip: translation(context).scansDeleteTooltip,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 18,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getConfidenceColor(double confidence) {
    if (confidence >= 0.8) return Colors.green;
    if (confidence >= 0.6) return Colors.orange;
    return Colors.red;
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(translation(context).scansDeleteDialogTitle),
        content: Text(translation(context).scansDeleteDialogBody),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(translation(context).no),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(translation(context).yes),
          ),
        ],
      ),
    );
  }
}
