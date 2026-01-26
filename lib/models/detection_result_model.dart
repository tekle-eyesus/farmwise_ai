class SavedDetectionResult {
  final String cropName;
  final String imagePath;
  final Map<String, dynamic> fullApiResponse; // Store the whole JSON
  final DateTime savedAt;

  SavedDetectionResult({
    required this.cropName,
    required this.imagePath,
    required this.fullApiResponse,
    required this.savedAt,
  });

  Map<String, dynamic> toMap() => {
        'cropName': cropName,
        'imagePath': imagePath,
        'fullApiResponse': fullApiResponse, // Save raw JSON
        'savedAt': savedAt.toIso8601String(),
      };

  static SavedDetectionResult fromMap(Map<dynamic, dynamic> map) =>
      SavedDetectionResult(
        cropName: map['cropName'],
        imagePath: map['imagePath'],
        // Handle conversion from LinkedMap to Map<String, dynamic> for Hive
        fullApiResponse:
            Map<String, dynamic>.from(map['fullApiResponse'] ?? {}),
        savedAt: DateTime.parse(map['savedAt']),
      );
}
