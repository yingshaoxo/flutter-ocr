import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class Database {
  var prefs;

  Database() {}

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void set detected_text(String text) {
    prefs.setString("detected_text", text);
  }

  String get detected_text {
    return prefs.getString("detected_text") ?? "";
  }
}

class AppModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  bool _ui_loading = false;

  /// An unmodifiable view of the items in the cart.
  bool get ui_loading {
    return _ui_loading;
  }

  void set ui_loading(bool value) {
    _ui_loading = value;

    notifyListeners();
  }
}
