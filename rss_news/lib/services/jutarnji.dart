import '../widgets/article.dart';
import '../const.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

List<String> categories = [];

class JutarnjiHR {
  static String name = 'jutarnji.hr';
  String url = kLinks[name];
  List<ArticleWidget> items = [];

  Future<ListView> getArticles(var context) async {
    http.Response response = await http.get(this.url);

    xml.XmlDocument data = xml.parse(response.body);

    for (var i in data.findAllElements('item')) {
      try{
      var imageLink = i.findAllElements('enclosure').first.getAttribute('url');
      var title = i.findElements('title').first.text;
      var webviewArgument = i.findElements('link').first.text;
      items.add(ArticleWidget(
        imageLink: imageLink,
        webviewArgument: webviewArgument,
        title: title,
      ));
      }
      catch(e){
        continue;
      }
    }

    return ListView(
      children: items,
    );
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

//   dynamic getImage(xml.XmlElement i) {
//     try {
//       return Image.network(
//         i.findAllElements('enclosure').first.getAttribute('url'),
//         width: 100.0,
//         height: 50.0,
//       );
//     } catch (e) {
//       return Container(
//         width: 100.0,
//         height: 50.0,
//         child: Center(child: Text('Image not available!')),
//       );
//     }
//   }

}
