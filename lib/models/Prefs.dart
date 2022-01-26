import 'package:shared_preferences/shared_preferences.dart';

Future<String> getStringValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? value = prefs.getString(key);
  return value == null ? "" : value;
}
