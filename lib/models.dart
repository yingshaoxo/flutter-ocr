import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'dart:convert';
import 'main.dart';

class AppModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  bool _uiLoading = false;
  int _tabIndex = 0;

  AppModel() {
    _tabIndex = database.tab_index;
  }

  bool get ui_loading {
    return _uiLoading;
  }

  void set ui_loading(bool value) {
    _uiLoading = value;

    notifyListeners();
  }

  int get tab_index {
    return _tabIndex;
  }

  void set tab_index(int value) {
    _tabIndex = value;
    database.tab_index = _tabIndex;

    notifyListeners();
  }

  Future<void> do_a_scan(String path, AppModel appModel,
      ImagePageModel imagePageModel, HistoryPageModel historyPageModel) async {
    appModel.ui_loading = true;
    imagePageModel.image_path = path;
    imagePageModel.ocr_text_result =
        await service.scan(imagePageModel.image_path);
    appModel.ui_loading = false;

    historyPageModel.add_to_history_list(
        new History(imagePageModel.image_path, imagePageModel.ocr_text_result));

    FlutterClipboard.copy(imagePageModel.ocr_text_result)
        .then((value) => print('copied'));
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
}

class History {
  String imagePath;
  String results;

  History(this.imagePath, this.results);

  Map toJson() => {
        'image_path': imagePath,
        'results': results,
      };

  factory History.fromJson(dynamic json) {
    return History(json['image_path'] as String, json['results'] as String);
  }
}

class HistoryPageModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  HistoryPageModel() {
    if (database.history_list == "") {
      _historyList = List();
    } else {
      var json = jsonDecode(database.history_list) as List;
      _historyList = json.map((json) => History.fromJson(json)).toList();
    }
  }

  List<History> _historyList;

  List<History> get history_list {
    return _historyList;
  }

  void set history_list(List<History> value) {
    _historyList = value;

    notifyListeners();
  }

  void save_history_list() {
    String text = jsonEncode(_historyList);
    database.history_list = text;

    notifyListeners();
  }

  void add_to_history_list(History history) {
    _historyList.add(history);
    save_history_list();
  }

  void remove_one_from_history_list(History history) {
    _historyList.remove(history);
    save_history_list();
  }
}

class PDFPageModel extends ChangeNotifier {
  String _pdfPath = "";
  List<String> _images = [];

  String get pdf_path {
    return _pdfPath;
  }

  void set pdf_path(String value) {
    _pdfPath = value;

    update_images_from_server();
  }

  Future<void> set_pdf_path(String value) async {
    _pdfPath = value;

    await update_images_from_server();
  }

  List<String> get images {
    return _images;
  }

  Future<void> update_images_from_server() async {
    _images = await service.get_images_from_service(_pdfPath);

    notifyListeners();
  }
}
