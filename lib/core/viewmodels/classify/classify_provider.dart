import 'dart:io';
import 'package:cakedetector/ui/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

/// State list
enum ClassifyState {
  Idle,
  Scanning,
  Complete
}

class ClassifyProvider extends ChangeNotifier {
  /// ----------------------------
  /// This is side for property data
  /// ----------------------------
  
  /// Handle scanning state
  ClassifyState _scanState = ClassifyState.Idle;
  ClassifyState get scanState => _scanState;

  /// Button size
  double _buttonSize = 400;
  double get buttonSize => _buttonSize;

  /// Scan font size
  double _scanFontSize = 60;
  double get scanFontSize => _scanFontSize;

  /// Scan text
  String _scanText = "SCAN NOW";
  String get scanText => _scanText;

  /// Cake result
  String _cakeResult;
  String get cakeResult => _cakeResult;

  /// ----------------------------
  /// This is side for function logic
  /// ----------------------------

  /// Scanning image using tensorflow
  /// based on the trained model
  Future<void> scan(BuildContext context, File image) async {
    onButtonTapAndHold();
    /// Set scan state to scanning
    setScanState(ClassifyState.Scanning);

    /// Waiting 2 second to show 
    /// detectif image
    await Future.delayed(Duration(seconds: 2));

    /// Classify an image
    await classify(image);

    /// Set scan state to complete
    onButtonRelease();
    setScanState(ClassifyState.Complete);
    notifyListeners();
  }

  /// Classify image using tensorflow
  Future<void> classify(File image) async {

    /// Load models
    await Tflite.loadModel(
      model: modelPath,
      labels: labelPath
    );

    var output = await Tflite.runModelOnImage(
      path: image.path, 
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5
    );

    /// We must validate confidence rate to above 0.98
    /// to make sure the result is correct
    if (output.length > 0 && double.parse(output[0]['confidence'].toString()) > 0.98) {
      _cakeResult = output[0]["label"].toString();
    } else {
      _cakeResult = null;
    }
    notifyListeners();
  }

  /// When button tap and hold we resize the button
  void onButtonTapAndHold() {
    _buttonSize = 500;
    _scanFontSize = 70;
    _scanText = "SCANNING";
    notifyListeners();
  }

  /// When button release we resize the button
  void onButtonRelease() {
    _buttonSize = 400;
    _scanFontSize = 60;
    _scanText = "SCAN NOW";
    notifyListeners();
  }

  /// Set event state
  void setScanState(ClassifyState value) {
    _scanState = value;
    notifyListeners();
  }
}