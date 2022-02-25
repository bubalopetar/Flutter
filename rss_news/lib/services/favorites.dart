import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/article.dart';

class Favorites {
  Favorites({this.link, this.title, this.imageLink});
  String link;
  String title;
  String imageLink;
  List<ArticleWidget> favorites = [];

  void addToFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(this.link, [this.title, this.imageLink]);
  }

  void removeFromFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(link);
  }

  dynamic getFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    Set keys=prefs.getKeys();
    keys.remove('summary');
    for (var link in keys) {
      
      var list = prefs.getStringList(link);
      favorites.add(ArticleWidget(
          imageLink: list[1], title: list[0], webviewArgument: link));
    }
    if (favorites.length > 0)
      return ListView(
        children: favorites,
      );
    else
      return 'empty';
  }
}
