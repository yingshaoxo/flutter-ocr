import 'package:shared_preferences/shared_preferences.dart';

var prefs;

class Database {
  Database() {}

  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  void set language_list(List<String> text_list) {
    prefs.setStringList("language_list", text_list);
  }

  List<String> get language_list {
    return prefs.getStringList("language_list") ?? ["English"];
  }
}
