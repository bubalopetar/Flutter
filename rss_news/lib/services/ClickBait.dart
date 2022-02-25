import 'dart:convert';

import '../widgets/article.dart';
import '../const.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class ClickBait {
  List<ArticleWidget> items = [];

  Future<ListView> getArticles(var context) async {
    http.Response response =
        await http.get(kHost+'rss_reader/clickbaits/');
    List articles = jsonDecode(response.body).cast<Map<String, dynamic>>();
    List cb=articles.sublist(1,4);
    List pcb=articles.sublist(50,53);
    List ncb=articles.sublist(articles.length-3);

    articles=cb+pcb+ncb;

    for (var article in articles) {
      items.add(ArticleWidget(
        imageLink: null,
        title: article['Title'],
        webviewArgument: article['Link'],
        conf: article['Confidence'],
      ));
    }
    print(items.length);
    return ListView(
      children: items,
    );
  }
}
