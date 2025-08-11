class SavedDetectionResult {
  final String cropName;
  final String imagePath; // Save image path, not the file itself
  final List<Map<String, dynamic>> detectionResult;
  final DateTime savedAt;

  SavedDetectionResult({
    required this.cropName,
    required this.imagePath,
    required this.detectionResult,
    required this.savedAt,
  });

  // For Hive storage (manual serialization)
  Map<String, dynamic> toMap() => {
        'cropName': cropName,
        'imagePath': imagePath,
        'detectionResult': detectionResult,
        'savedAt': savedAt.toIso8601String(),
      };

  static SavedDetectionResult fromMap(Map<dynamic, dynamic> map) =>
      SavedDetectionResult(
        cropName: map['cropName'],
        imagePath: map['imagePath'],
        detectionResult: List<Map<String, dynamic>>.from(
          map['detectionResult'].map(
            (e) => Map<String, dynamic>.from(e),
          ),
        ),
        savedAt: DateTime.parse(map['savedAt']),
      );
}
