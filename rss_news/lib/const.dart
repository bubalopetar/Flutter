import 'package:flutter/material.dart';
String kHost='http://192.168.1.101:8000/';

const kLinks = {
  'index.hr': 'https://www.index.hr/rss',
  'jutarnji.hr': 'https://www.jutarnji.hr/rss',
  '24sata.hr': "https://www.24sata.hr/feeds/najnovije.xml",
  'dnevnik.hr': 'https://dnevnik.hr/assets/feed/articles',
  'bug.hr': 'https://www.bug.hr/rss',
};
List<String> kIndexCategories = [
  "Pozitivne vijesti",
  "Neutralne vijesti",
  "Negativne vijesti",
  "Sport",
  "Vijesti",
  "Mame",
  "Fit",
  "Magazin",
  "Ljubimci",
  "Rouge",
  "Auto"
];
List<String> k24sataCategories = [
    "Pozitivne vijesti",
  "Neutralne vijesti",
  "Negativne vijesti",
  "Aktualno",
  "Najnovije",
  "News",
  "Show",
  "Sport",
  "Lifestyle",
  "Tech",
  "Viral"
];
List<String> kJutarnjiCategories = [
    "Pozitivne vijesti",
  "Neutralne vijesti",
  "Negativne vijesti"
];
List<String> kDnevnikCategories = [
    "Pozitivne vijesti",
  "Neutralne vijesti",
  "Negativne vijesti"
];
List<String> kBugCategories = [
    "Pozitivne vijesti",
  "Neutralne vijesti",
  "Negativne vijesti",
  "Biznis",
  "Tehnologije",
  "Igre",
  "Društvene mreže",
  "Softver",
  "Promo",
  "Mobiteli",
  "Nosivi uređaji",
  "Igrali smo",
  "Recenzije",
  "Crowdfunding",
  "Apple",
  "Mobilne aplikacije",
  "Nagradna igra",
  "Astronomija",
  "Programiranje",
  "Ekologija",
  "Događaji",
  "Sigurnost",
  "BugTV",
  "Mini PC",
  "Telekomunikacije",
  "Anketa",
  "In memoriam",
  "Znanost",
  "Internet"
];
MaterialColor kJutarnjiColor = MaterialColor(0xFFFFFFFF, {
  50: Color.fromRGBO(255, 255, 255, .1),
  100: Color.fromRGBO(255, 255, 255, .2),
  200: Color.fromRGBO(255, 255, 255, .3),
  300: Color.fromRGBO(255, 255, 255, .4),
  400: Color.fromRGBO(255, 255, 255, .5),
  500: Color.fromRGBO(255, 255, 255, .6),
  600: Color.fromRGBO(255, 255, 255, .7),
  700: Color.fromRGBO(255, 255, 255, .8),
  800: Color.fromRGBO(255, 255, 255, .9),
  900: Color.fromRGBO(255, 255, 255, 1),
});
MaterialColor kDnevnikColor = MaterialColor(0xFFb30000, {
  50: Color.fromRGBO(179, 0, 0, .1),
  100: Color.fromRGBO(179, 0, 0, .2),
  200: Color.fromRGBO(179, 0, 0, .3),
  300: Color.fromRGBO(179, 0, 0, .4),
  400: Color.fromRGBO(179, 0, 0, .5),
  500: Color.fromRGBO(179, 0, 0, .6),
  600: Color.fromRGBO(179, 0, 0, .7),
  700: Color.fromRGBO(179, 0, 0, .8),
  800: Color.fromRGBO(179, 0, 0, .9),
  900: Color.fromRGBO(179, 0, 0, 1),
});
TextStyle kMenuTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 19,
);

TextStyle kArticleTitleStyle = TextStyle(fontSize: 18.0);
TextStyle kFavoritesEmptyStyle = TextStyle(fontSize: 20);

TextStyle kSazetakStyle = TextStyle(fontSize: 25, color: Colors.black);
TextStyle kSummaryStyle = TextStyle(fontSize: 18, );
double kSummaryLength=3.0;