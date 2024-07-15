import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class Pref {
  static late Box box;

  static Future<void> initializeHive() async {
    box = await Hive.openBox('data');
  }

  static set skipIntro(bool v) => box.put("skipIntro", v);
  static bool get skipIntro => box.get("skipIntro") ?? false;

  static set uid(String? v) => box.put("uid", v);
  static String? get uid => box.get("uid");
}
