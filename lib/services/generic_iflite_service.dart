import 'dart:io';
import 'package:smartcrop_ai/language_classes/language_constants.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

// NOT USED IN THE CURRENT APP VERSION //
class GenericIfliteService {
  final Interpreter _interpreter;
  final List<String> _labels;
  final ImageProcessor _imgProcessor;
  final TensorImage _inputImage;
  final TensorBuffer _outputBuffer;

  GenericIfliteService._(
    this._interpreter,
    this._labels,
    this._imgProcessor,
    this._inputImage,
    this._outputBuffer,
  );

  /// Initialize the model and labels
  static Future<GenericIfliteService> create(String crop) async {
    // 1. Load the Teachable Machine model
    // change the crop name alwasys to english for loading the model and labels,
    crop = cropNameInEnglish(crop);

    final interpreter = await Interpreter.fromAsset(
      'models/${crop.toLowerCase()}_model.tflite',
    );

    // 2. Load labels
    final rawLabels = await rootBundle.loadString(
      'assets/models/${crop.toLowerCase()}_labels.txt',
    );
    final labels = rawLabels
        .split('\n')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();

    // 3. Prepare image processor (resize to 224x224, normalize pixel values)
    final inputShape = interpreter.getInputTensor(0).shape;
    final inputSize = inputShape[1];
    final imgProcessor = ImageProcessorBuilder()
        .add(ResizeOp(inputSize, inputSize, ResizeMethod.BILINEAR))
        .add(NormalizeOp(0, 255)) // Matches Teachable Machine preprocessing
        .build();

    // 4. Allocate tensors
    final inputImage = TensorImage(TfLiteType.float32);
    final outputBuffer = TensorBuffer.createFixedSize(
      interpreter.getOutputTensor(0).shape,
      TfLiteType.float32,
    );

    return GenericIfliteService._(
        interpreter, labels, imgProcessor, inputImage, outputBuffer);
  }

  /// Run inference and return sorted [{label, confidence}]
  Future<List<Map<String, dynamic>>> detect(File imageFile) async {
    final rawBytes = imageFile.readAsBytesSync();
    final decoded = img.decodeImage(rawBytes);
    if (decoded == null) throw Exception("Image decoding failed");

    _inputImage.loadImage(decoded);
    final processedImage = _imgProcessor.process(_inputImage);

    // Run inference
    _interpreter.run(processedImage.buffer, _outputBuffer.buffer);

    // Map predictions to labels
    final predictions =
        TensorLabel.fromList(_labels, _outputBuffer).getMapWithFloatValue();

    final results = predictions.entries
        .map((e) => {
              'label': e.key,
              'confidence': (e.value * 100).toDouble(),
            })
        .toList()
      ..sort((a, b) =>
          (b['confidence'] as double).compareTo(a['confidence'] as double));

    print(results);
    return results;
  }

  /// Dispose interpreter
  void close() => _interpreter.close();
}
