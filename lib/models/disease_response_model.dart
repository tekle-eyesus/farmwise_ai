class DiseaseResponse {
  final bool success;
  final DiseasePrediction disease;
  final SeverityInfo? severity;
  final Map<String, dynamic> rawJson; // Store full JSON for Hive/Debugging

  DiseaseResponse({
    required this.success,
    required this.disease,
    this.severity,
    required this.rawJson,
  });

  factory DiseaseResponse.fromJson(Map<String, dynamic> json) {
    // Normalize nested maps to Map<String, dynamic> to avoid runtime cast issues
    final diseaseJson = Map<String, dynamic>.from(json['disease'] ?? {});
    final severityJson = json['severity'] != null
        ? Map<String, dynamic>.from(json['severity'])
        : null;

    return DiseaseResponse(
      success: json['success'] ?? false,
      disease: DiseasePrediction.fromJson(diseaseJson),
      severity:
          severityJson != null ? SeverityInfo.fromJson(severityJson) : null,
      rawJson: Map<String, dynamic>.from(json),
    );
  }
}

class DiseasePrediction {
  final String predictedClass; // e.g., "wheat_stripe_rust"
  final double confidence;
  final List<TopPrediction> topPredictions;

  DiseasePrediction({
    required this.predictedClass,
    required this.confidence,
    required this.topPredictions,
  });

  factory DiseasePrediction.fromJson(Map<String, dynamic> json) {
    var list = json['top_predictions'] as List? ?? [];
    List<TopPrediction> predictionsList = list
        .map((i) => TopPrediction.fromJson(Map<String, dynamic>.from(i)))
        .toList();

    return DiseasePrediction(
      predictedClass: json['predicted_class'] ?? "Unknown",
      confidence: (json['confidence'] ?? 0.0).toDouble(),
      topPredictions: predictionsList,
    );
  }
}

class TopPrediction {
  final String label;
  final double confidence;

  TopPrediction({required this.label, required this.confidence});

  factory TopPrediction.fromJson(Map<String, dynamic> json) {
    return TopPrediction(
      label: json['class'] ?? "Unknown",
      confidence: (json['confidence'] ?? 0.0).toDouble(),
    );
  }
}

class SeverityInfo {
  final String level; // "Low", "High"
  final double affectedPercentage;

  SeverityInfo({required this.level, required this.affectedPercentage});

  factory SeverityInfo.fromJson(Map<String, dynamic> json) {
    return SeverityInfo(
      level: json['level'] ?? "Unknown",
      affectedPercentage: (json['affected_percentage'] ?? 0.0).toDouble(),
    );
  }
}
