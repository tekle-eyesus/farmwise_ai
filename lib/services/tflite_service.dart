import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

class TFLiteService {
  static final TFLiteService _instance = TFLiteService._internal();
  factory TFLiteService() => _instance;
  TFLiteService._internal();

  final Map<String, Interpreter> _interpreters = {};
  final Map<String, List<String>> _labels = {};
  final Map<String, TensorImage> _inputImages = {};

  Future<void> loadModel(String crop) async {
    if (_interpreters.containsKey(crop)) return; // Already loaded

    final interpreter = await Interpreter.fromAsset(
        'models/${crop.toLowerCase()}_model.tflite');
    _interpreters[crop] = interpreter;

    final labelsData = await rootBundle
        .loadString('assets/models/${crop.toLowerCase()}_labels.txt');
    _labels[crop] = labelsData.split('\n');
  }

  Future<List<Map<String, dynamic>>> detect(String crop, File imageFile) async {
    final interpreter = _interpreters[crop];
    final labels = _labels[crop];

    if (interpreter == null || labels == null) {
      throw Exception("Model or labels not loaded for $crop.");
    }

    // Load and preprocess image
    final rawImage = File(imageFile.path).readAsBytesSync();
    img.Image? image = img.decodeImage(rawImage);
    image = img.copyResize(image!, width: 256, height: 256);
    // add here
    final input = imageToByteListFloat32(image, 256);

    // Run inference
    var output = List.filled(labels.length, 0.0).reshape([1, labels.length]);
    interpreter.run(input, output);

    List<Map<String, dynamic>> results = [];
    for (int i = 0; i < labels.length; i++) {
      results.add({
        'label': labels[i],
        'confidence': (output[0][i] as double) * 100,
      });
    }
    print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
    print(_labels[crop]);
    print(results.map((r) => r['label']).toList());

    // results.sort((a, b) => (b['confidence']).compareTo(a['confidence']));
    return results;
  }

  Uint8List imageToByteListFloat32(img.Image image, int inputSize) {
    final convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    final buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final pixel = image.getPixel(x, y);

        // buffer[pixelIndex++] = (img.getRed(pixel) - 127.5) / 127.5;
        // buffer[pixelIndex++] = (img.getGreen(pixel) - 127.5) / 127.5;
        // buffer[pixelIndex++] = (img.getBlue(pixel) - 127.5) / 127.5;

        // for input mismatch
        buffer[pixelIndex++] = img.getRed(pixel) / 255.0;
        buffer[pixelIndex++] = img.getGreen(pixel) / 255.0;
        buffer[pixelIndex++] = img.getBlue(pixel) / 255.0;
      }
    }

    return convertedBytes.buffer.asUint8List();
  }

  void disposeAll() {
    for (var interpreter in _interpreters.values) {
      interpreter.close();
    }
    _interpreters.clear();
    _labels.clear();
  }
}
