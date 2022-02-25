import '../widgets/article.dart';
import '../const.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class BugHR {
  static String name = 'bug.hr';
  String url = kLinks[name];
  List<ArticleWidget> items = [];
  List<String> categories = [];

  Future<ListView> getArticles(var context, String category) async {
    http.Response response = await http.get(this.url);
    xml.XmlDocument data = xml.parse(response.body);
    if (category == null) {
      for (var i in data.findAllElements('item')) {
        var imageLink =
            i.findAllElements('enclosure').first.getAttribute('url');
        var title = i.findElements('title').first.text;
        var webviewArgument = i.findElements('link').first.text;
        items.add(ArticleWidget(
          imageLink: imageLink,
          webviewArgument: webviewArgument,
          title: title,
        ));
      }

      return ListView(
        children: items,
      );
    } else {
      for (var i in data.findAllElements('item')) {
        var imageLink =
            i.findAllElements('enclosure').first.getAttribute('url');
        var title = i.findElements('title').first.text;
        var webviewArgument = i.findElements('link').first.text;
        if (i.findAllElements('category').first.text == category) {
          items.add(ArticleWidget(
            imageLink: imageLink,
            webviewArgument: webviewArgument,
            title: title,
          ));
        }
      }

      return ListView(
        children: items,
      );
    }
  }

  Future<List<String>> getCategories() async {
    http.Response response = await http.get(this.url);
    xml.XmlDocument data = xml.parse(response.body);
    for (var i in data.findAllElements('category')) {
      categories.add(i.text);
    }
    categories = categories.toSet().toList();
    return categories;
  }
}
