import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? shared;

  static inti() async {
    shared = await SharedPreferences.getInstance();
  }

  static putData(String key, dynamic value) async {
    if (value is String) {
      dynamic ret = await shared!.setString(key, value);
      return ret;
    }
    if (value is bool) {
      dynamic ret = await shared!.setBool(key, value);
      return ret;
    }
    if (value is int) {
      dynamic ret = await shared!.setInt(key, value);
      return ret;
    }
    if (value is double) {
      dynamic ret = await shared!.setDouble(key, value);
      return ret;
    }
  }

  static getData(String key) async {
    dynamic ret = await shared!.get(key);
    return ret;
  }
}
