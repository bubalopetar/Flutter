import 'package:flutter/material.dart';
import 'package:rss_news/const.dart';
import 'package:rss_news/services/favorites.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    data = await Favorites().getFavorites();
    setState(() {});
  }

  dynamic data;
  @override
  Widget build(BuildContext context) {
    if (data != 'empty') {
      return RefreshIndicator(
          child: Container(
            child: data,
          ),
          onRefresh: () => getData());
    } else {
      return Scaffold(
        body: Center(
          child: Text(
            'Empty',
            style: kFavoritesEmptyStyle,
          ),
        ),
      );
    }
  }
}
