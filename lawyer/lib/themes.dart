import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomTheme with ChangeNotifier {
  ThemeMode? currentMode;
  SharedPreferences? prefs;

  CustomTheme({required this.prefs}) {
    /*
    try to read if lightMode saved in prefs, if getBool('lightMode') returns null or false
    then ThemeMode.light will be default
    */
    var brightness = WidgetsBinding.instance!.window.platformBrightness;
    if (prefs!.containsKey('lightMode') == false) {
      currentMode =
          brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    } else {
      currentMode = prefs?.getBool('lightMode') ?? true
          ? ThemeMode.light
          : ThemeMode.dark;
    }
  }

  void changeTheme() async {
    currentMode =
        currentMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
    prefs!.setBool('lightMode', currentMode == ThemeMode.light);
  }

  ThemeData get lightTheme {
    return ThemeData.light();
  }

  ThemeData get darkTheme {
    return ThemeData.dark();
  }
}
