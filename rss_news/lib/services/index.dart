import '../const.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import '../widgets/article.dart';
import 'dart:convert';

class IndexHR {
  static String name = 'index.hr';
  String url = kLinks[name];
  List<ArticleWidget> items = [];
  List<String> categories = [];

  Future<ListView> getArticles(var context, String category) async {

    http.Response response = await http.get(this.url);
    xml.XmlDocument data = xml.parse(response.body);
    if (category == null) {
      for (var i in data.findAllElements('item')) {
        var imageLink = i
            .findElements('description')
            .first
            .text
            .split('"/>')[0]
            .split('<img src="')[1];
        var title = i.findElements('title').first.text;
        var webviewArgument = i.findElements('link').first.text;
        items.add(ArticleWidget(
          imageLink: imageLink,
          title: title,
          webviewArgument: webviewArgument,
        ));
      }
      return ListView(
        children: items,
      );
    } 
    else if(category=='Pozitivne vijesti'){
      for (var i in data.findAllElements('item')) {
        var imageLink = i
            .findElements('description')
            .first
            .text
            .split('"/>')[0]
            .split('<img src="')[1];
        var title = i.findElements('title').first.text;
        var webviewArgument = i.findElements('link').first.text;

        http.Response sentiment = await http.post(
                kHost + 'rss_reader/sentiment/',
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(<String, dynamic>{
                  'link': webviewArgument,
                  'title': title
                }),
              );
        if (double.parse(sentiment.body) > 0.2){}
        items.add(ArticleWidget(
          imageLink: imageLink,
          title: title,
          webviewArgument: webviewArgument,
        ));
        
      }
      return ListView(
        children: items,
      );
    }
    else {
      
      for (var i in data.findAllElements('item')) {
        var imageLink = i
            .findElements('description')
            .first
            .text
            .split('"/>')[0]
            .split('<img src="')[1];
        var title = i.findElements('title').first.text;
        var webviewArgument = i.findElements('link').first.text;
        if (i.findAllElements('category').first.text == category) {
          items.add(ArticleWidget(
            imageLink: imageLink,
            title: title,
            webviewArgument: webviewArgument,
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
