import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  bool _uiLoading = false;

  bool get ui_loading {
    return _uiLoading;
  }

  void set ui_loading(bool value) {
    _uiLoading = value;

    notifyListeners();
  }
}

class ImagePageModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  String _imagePath = "";
  String _ocrTextResult = "";
  TextEditingController input_controller = TextEditingController();

  String get image_path {
    return _imagePath;
  }

  void set image_path(String value) {
    _imagePath = value;

    notifyListeners();
  }

  String get ocr_text_result {
    return _ocrTextResult;
  }

  void set ocr_text_result(String value) {
    _ocrTextResult = value;

    input_controller.value = input_controller.value.copyWith(
      text: _ocrTextResult,
    );
    notifyListeners();
  }

  //void dispose() {
  //  input_controller.dispose();
  //  super.dispose();
  //}
}
