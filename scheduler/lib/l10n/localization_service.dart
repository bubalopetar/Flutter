import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService with ChangeNotifier {
  late SharedPreferences prefs;
  static const Locale croatianLocale = Locale('hr', 'HR');
  static const Locale britishLocale = Locale('en', 'GB');
  static const List<Locale> supportedLocales = [croatianLocale, britishLocale];
  late Locale activeLocale = croatianLocale;

  final List<LocalizationsDelegate> localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  LocalizationService({required this.prefs}) {
    readSavedLocale();
  }
  void readSavedLocale() {
    if (prefs.containsKey('activeLocale')) {
      var savedLocale = prefs.getStringList('activeLocale');
      var languageCode = savedLocale![0];
      var countryCode = savedLocale[1];
      activeLocale = supportedLocales.firstWhere((element) =>
          element.languageCode == languageCode &&
          element.countryCode == countryCode);
    } else {
      activeLocale = croatianLocale;
    }
  }

  void changeActiveLocalization(String languageCode, String countryCode) {
    activeLocale = supportedLocales.firstWhere((element) =>
        element.languageCode == languageCode &&
        element.countryCode == countryCode);

    notifyListeners();
    prefs.setStringList('activeLocale', [languageCode, countryCode]);
  }
}
