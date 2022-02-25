import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lawyer/screens/create_case_screen.dart';
import 'package:lawyer/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './providers/database.dart';
import '../screens/cases_list_screen.dart';
import 'package:flutter/services.dart';
import 'l10n/localization_service.dart';
import 'notifications/notifications_alarm_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  var prefs = await SharedPreferences.getInstance();
  var caseDao = CaseDao(MyDatabase());
  setAndroidAlarm(prefs);
  runApp(AppProviders(prefs: prefs, caseDao: caseDao));
}

Future initializePreferences() async {}

class AppProviders extends StatelessWidget {
  final SharedPreferences prefs;
  final CaseDao caseDao;
  const AppProviders({required this.prefs, required this.caseDao, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomTheme>(
            create: (context) => CustomTheme(prefs: prefs)),
        Provider<CaseDao>(create: (context) => caseDao),
        Provider<SharedPreferences>(create: (context) => prefs),
        ChangeNotifierProvider<LocalizationService>(
            create: (context) => LocalizationService(prefs: prefs))
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<CustomTheme>(context);
    var localizationService = Provider.of<LocalizationService>(context);
    return MaterialApp(
      title: 'lawyer',
      localizationsDelegates: localizationService.localizationsDelegates,
      locale: localizationService.activeLocale,
      supportedLocales: LocalizationService.supportedLocales,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.currentMode,
      initialRoute: CasesListScreen.screenName,
      routes: {
        CasesListScreen.screenName: (context) => const CasesListScreen(),
        CreateCaseScreen.screenName: (context) => const CreateCaseScreen(),
      },
    );
  }
}
