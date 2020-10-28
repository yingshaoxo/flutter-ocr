import 'package:shared_preferences/shared_preferences.dart';

var prefs;

class Database {
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
