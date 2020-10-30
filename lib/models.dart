import 'package:flutter/material.dart';
import 'dart:convert';
import 'main.dart';

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
