import 'package:flutter_tflite/flutter_tflite.dart';
import 'dart:io';

class TFLiteService {
  static Future<void> loadModel() async {
    await Tflite.loadModel(
        model: "assets/ml_models/model_unquant.tflite",
        labels: "assets/ml_models/labels.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }

  static Future<List?> detectImage(File image) async {
    return await Tflite.runModelOnImage(
      path: image.path,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 5,
      threshold: 0.1,
      asynch: true,
    );
  }

  static Future<void> disposeModel() async {
    await Tflite.close();
  }
}
