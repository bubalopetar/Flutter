import '../const.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import '../widgets/article.dart';
import 'dart:convert';

class II4sataHR {
  static String name = '24sata.hr';
  String url = kLinks[name];
  List<ArticleWidget> items = [];

  Future<ListView> getArticles(var context, String category) async {

    

    if (category != null && category != 'Pozitivne vijesti' && category != 'Neutralne vijesti' && category != 'Negativne vijesti') {
      this.url =
          "https://www.24sata.hr/feeds/" + category.toLowerCase() + '.xml';
    }
    http.Response response = await http.get(this.url);

    xml.XmlDocument data = xml.parse(response.body);

    if(category=='Pozitivne vijesti'){
    

      for (var i in data.findAllElements('item')) {
     var imageLink = i
          .findElements('description')
          .first
          .text
          .split('/>')[0]
          .split('" align')[0]
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
        if (double.parse(sentiment.body) > 0.2){
        items.add(ArticleWidget(
          imageLink: imageLink,
          title: title,
          webviewArgument: webviewArgument,
        ));
        
       } }
      return ListView(
        children: items,
      );
    }if(category=='Neutralne vijesti'){

      for (var i in data.findAllElements('item')) {
     var imageLink = i
          .findElements('description')
          .first
          .text
          .split('/>')[0]
          .split('" align')[0]
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
        if (double.parse(sentiment.body) < 0.2 && double.parse(sentiment.body) > -0.2){
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
     if(category=='Negativne vijesti'){

      for (var i in data.findAllElements('item')) {
     var imageLink = i
          .findElements('description')
          .first
          .text
          .split('/>')[0]
          .split('" align')[0]
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
        if (double.parse(sentiment.body) < -0.2 ){
        items.add(ArticleWidget(
          imageLink: imageLink,
          title: title,
          webviewArgument: webviewArgument,
        ));
        
      }}
      return ListView(
        children: items,
      );
    }
    for (var i in data.findAllElements('item')) {
      var imageLink = i
          .findElements('description')
          .first
          .text
          .split('/>')[0]
          .split('" align')[0]
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
  //           .split('" align')[0]
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
