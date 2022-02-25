import 'package:flutter/material.dart';
import './screens/input_page.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppSettings settings = AppSettings();
  await settings.loadSavedPrefs();

  runApp(new MyApp(
    settings: settings,
  ));
}

class MyApp extends StatefulWidget {
  MyApp({this.settings});
  AppSettings settings;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void changeTheme() async {
    setState(() {
      widget.settings.brightness = widget.settings.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark;
    });
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setString('brightness', widget.settings.brightness.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Running / Walking intervals',
      theme: ThemeData(brightness: widget.settings.brightness)
          .copyWith(primaryColor: Colors.red),
      home: InputPage(
        changeTheme: changeTheme,
        settings: widget.settings,
      ),
    );
  }
}
