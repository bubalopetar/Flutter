import 'package:flutter/material.dart';
import 'package:rss_news/const.dart';
import 'package:rss_news/screens/24sataCScreen.dart';
import './services/index.dart';
import 'web_view.dart';
import 'package:rss_news/services/24sata.dart';
import 'package:rss_news/services/jutarnji.dart';
import 'package:rss_news/screens/jutarnji_screen.dart';
import './services/dnevnik.dart';
import './services/bug.dart';
import './screens/index_screen.dart';
import './screens/jutarnji_screen.dart';
import './screens/24sata_screen.dart';
import './screens/dnevnik_screen.dart';
import 'screens/bug_screen.dart';
import 'screens/favorites_screen.dart';
import 'const.dart';
import './widgets/floatin_button.dart';
import './widgets/mebu_button.dart';
import './screens/IndexCScreen.dart';
import './screens/BugCSCreen.dart';
import './screens/SettingsScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/clickBait_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('summary')){
    kSummaryLength=prefs.getDouble('summary');}
  else kSummaryLength=3;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic activeScreen = IndexScreen();
  List<String> activeCategory = kIndexCategories;
  Color activeColor = Colors.red;

  void setStateCallback(String screen, String category) {
    if (screen == 'IndexScreen' || screen == 'IndexCScreen') {
      setState(() {
        if (activeScreen.runtimeType.toString() == 'IndexScreen') {
          activeScreen = IndexCScreen(
            category: category,
          );
        } else {
          activeScreen = IndexScreen(
            category: category,
          );
        }
      });
    } else if (screen == 'II4sataScreen' || screen == 'II4sataCScreen') {
      setState(() {
        if (activeScreen.runtimeType.toString() == 'II4sataScreen') {
          activeScreen = II4sataCScreen(
            category: category,
          );
        } else {
          activeScreen = II4sataScreen(
            category: category,
          );
        }
      });
    } else if (screen == 'BugScreen' || screen == 'BugCScreen') {
      setState(() {
        if (activeScreen.runtimeType.toString() == 'BugScreen') {
          activeScreen = BugCScreen(
            category: category,
          );
        } else {
          activeScreen = BugScreen(
            category: category,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSS News',
      theme: ThemeData(
        primarySwatch: activeColor,
      ),
      routes: {
        WebViewWidget.name: (context) => WebViewWidget(),
        IndexHR.name: (context) => IndexScreen(),
        JutarnjiHR.name: (context) => JutarnjiScreen(),
        II4sataHR.name: (context) => II4sataScreen(),
        DnevnikHR.name: (context) => DnevnikScreen(),
        BugHR.name: (context) => BugScreen(),
      },
      home: Scaffold(
        floatingActionButton: FloatingButtonWidget(
          activeColor: activeColor,
          activeCategory: activeCategory,
          activeScreen: activeScreen,
          setStateCallback: setStateCallback,
        ),
        appBar: AppBar(
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap:(){
                    setState(() {
                      activeScreen = SettingsScreen();
                      activeCategory = ['Nema kategorija'];

                    });
                  },
                  child: Icon(Icons.settings),
                ),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      activeScreen = FavoritesScreen();
                      activeCategory = ['Nema kategorija'];
                    });
                  },
                  child: Icon(
                    Icons.star,
                    color: Colors.yellowAccent,

                  ),
                ),
                MenuButtonWidget(
                  text: 'ClickBaits',
                  callback: () {
                    setState(() {
                      activeScreen = ClickBaitScreen();
                      //print(activeScreen.hashCode);
                      activeColor = Colors.red;
                       activeCategory = ['Nema kategorija'];
                    });
                  },
                ),
                MenuButtonWidget(
                  text: 'Index',
                  callback: () {
                    setState(() {
                      activeScreen = IndexScreen();
                      //print(activeScreen.hashCode);
                      activeColor = Colors.red;
                      activeCategory = kIndexCategories;
                    });
                  },
                ),
                MenuButtonWidget(
                  text: 'Jutarnji',
                  callback: () {
                    setState(() {
                      activeScreen = JutarnjiScreen();
                      activeColor = Colors.blue;
                      activeCategory =kJutarnjiCategories;
                    });
                  },
                ),
                MenuButtonWidget(
                  text: '24sata',
                  callback: () {
                    setState(() {
                      activeScreen = II4sataScreen();
                      activeColor = Colors.yellow;
                      activeCategory = k24sataCategories;
                    });
                  },
                ),
                MenuButtonWidget(
                  text: 'Dnevnik',
                  callback: () {
                    setState(() {
                      activeScreen = DnevnikScreen();
                      activeColor = kDnevnikColor;
                      activeCategory = kDnevnikCategories;
                    });
                  },
                ),
                MenuButtonWidget(
                  text: 'Bug',
                  callback: () {
                    setState(() {
                      activeScreen = BugScreen();
                      activeColor = Colors.orange;
                      activeCategory = kBugCategories;
                    });
                  },
                )
              ],
            ),
          ),
        ),
        body: activeScreen,
      ),
    );
  }
}
