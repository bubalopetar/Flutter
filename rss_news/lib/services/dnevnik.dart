import '../widgets/article.dart';
import '../const.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class DnevnikHR {
  static String name = 'dnevnik.hr';
  String url = kLinks[name];
  List<ArticleWidget> items = [];

  Future<ListView> getArticles(var context) async {
    http.Response response = await http.get(this.url);

    xml.XmlDocument data = xml.parse(response.body);

    for (var i in data.findAllElements('item')) {
      var imageLink = i
          .findElements('description')
          .first
          .text
          .split('/>')[0]
          .split('" alt')[0]
          .split('<img src="')[1];
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
  }

  // dynamic getImage(xml.XmlElement i) {
  //   try {
  //     return Image.network(
  //       i
  //           .findElements('description')
  //           .first
  //           .text
  //           .split('/>')[0]
  //           .split('" alt')[0]
  //           .split('<img src="')[1],
  //       width: 100.0,
  //       height: 50.0,
  //     );
  //   } catch (e) {
  //     return Container(
  //       width: 100.0,
  //       height: 50.0,
  //       child: Center(child: Text('Image not available!')),
  //     );
  //   }
  // }
}
