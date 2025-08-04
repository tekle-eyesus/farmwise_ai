import 'package:hive/hive.dart';
import '../models/detection_result_model.dart';

class LocalStorageService {
  static final _box = Hive.box('detection_results');

  static Future<void> saveResult(SavedDetectionResult result) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await _box.put(id, result.toMap());
  }

  static List<MapEntry<String, SavedDetectionResult>> getSavedResults() {
    return _box.toMap().entries.map((entry) {
      final key = entry.key as String;
      final value =
          SavedDetectionResult.fromMap(Map<String, dynamic>.from(entry.value));
      return MapEntry(key, value);
    }).toList();
  }

  static Future<void> deleteResult(String key) async {
    await _box.delete(key);
  }
}
