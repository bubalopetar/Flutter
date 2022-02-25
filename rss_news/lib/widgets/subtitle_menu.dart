import 'dart:convert';
import 'dart:ffi';
import 'package:rss_news/const.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/favorites.dart';
import 'package:http/http.dart' as http;
import 'package:rss_news/const.dart';

class SubtitleMenu extends StatefulWidget {
  SubtitleMenu({this.title, this.link, this.imageLink});

  String title;
  String link;
  String imageLink;

  @override
  _SubtitleMenuState createState() => _SubtitleMenuState();
}

class _SubtitleMenuState extends State<SubtitleMenu> {
  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(widget.link)) {
      shareColor = Colors.yellowAccent;
      icon = Icons.star;
      setState(() {});
    }
  }

  Row getSmiley(String result) {
    print(result);
    Icon val;
       if (double.parse(result)> 0.6) {
      val = Icon(
        Icons.sentiment_very_satisfied,
        size: 80,
        color: Colors.orange,
      );
        }
        else if (double.parse(result) > 0.2 && double.parse(result) < 0.6) {
      val = Icon(
        Icons.sentiment_satisfied,
        size: 80,
        color: Colors.yellow,
      );
        }
    else if (double.parse(result) < 0.2 && double.parse(result) > -0.2) {
      val = Icon(
        Icons.sentiment_neutral,
        size: 80,
        color: Colors.grey,
      );
    } else if (double.parse(result) < -0.2 && double.parse(result) > -0.6) {
      val = Icon(
        Icons.sentiment_dissatisfied,
        size: 80,
        color: Colors.grey[800],
      );
    } else {
      val = Icon(
        Icons.sentiment_very_dissatisfied,
        size: 80,
        color: Colors.black,
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        val,
      ],
    );
  }

  Row getMood(String result) {
    String val;
    if (double.parse(result) > 0.6) {
      val = 'jako pozitivan!';
    }
    else if (double.parse(result) > 0.2 && double.parse(result) < 0.6) {
      val = 'pozitivan!';
    } 
    else if (double.parse(result) < 0.2 && double.parse(result) > -0.2) {
      val = 'neutralan!';
    } else if (double.parse(result) < 0.2 && double.parse(result) > -0.6) {
      val = 'negativan!';
    } else {
      val = 'jako negativan!';
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(val, style: TextStyle(fontSize: 25)),
      ],
    );
  }

  Color shareColor = Colors.black;
  Color favoriteColor = Colors.black;
  IconData icon = Icons.star_border;
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Share.share('${widget.title}\n Saznaj više na ${widget.link}');
            },
            child: Icon(
              Icons.share,
              size: 40.0,
              color: favoriteColor,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                shareColor = shareColor == Colors.yellowAccent
                    ? Colors.black
                    : Colors.yellowAccent;
                icon = icon == Icons.star ? Icons.star_border : Icons.star;
              });
              if (shareColor == Colors.yellowAccent) {
                Favorites(
                        link: widget.link,
                        title: widget.title,
                        imageLink: widget.imageLink)
                    .addToFavorites();
              } else {
                Favorites(
                        link: widget.link,
                        title: widget.title,
                        imageLink: widget.imageLink)
                    .removeFromFavorites();
              }
            },
            child: Icon(
              icon,
              size: 40,
              color: shareColor,
            ),
          ),
          GestureDetector(
            onTap: () async {
              http.Response summary = await http.post(
                kHost + 'rss_reader/',
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(<String, dynamic>{
                  'link': widget.link,
                  'length': kSummaryLength
                }),
              );

              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          summary.body,
                          style: kSummaryStyle,
                        ),
                      ),
                    );
                  });
            },
            child: Icon(
              Icons.chrome_reader_mode,
              size: 40,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () async {
              http.Response response = await http.post(
                kHost + 'rss_reader/compare/',
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(<String, dynamic>{
                  'link': widget.link,
                  'title': widget.title
                }),
              );
              final parsed = json.decode(response.body);
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                  'Naslov članka:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                  parsed['title'],
                                  style: TextStyle(fontSize: 25),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                  'Najsličnija rečenica u članku:',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Flexible(
                                    child: Text(
                                  parsed['sentence'],
                                  style: TextStyle(fontSize: 25),
                                ))
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // children: <Widget>[
                              //   Text(
                              //     (parsed['cosine'] * 100).toStringAsFixed(2) +
                              //         '% sličnosti',
                              //     style: TextStyle(fontSize: 30),
                              //   )
                              // ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Icon(
              Icons.compare,
              size: 40,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () async {
              http.Response response = await http.post(
                kHost + 'rss_reader/sentiment/',
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: jsonEncode(<String, dynamic>{
                  'link': widget.link,
                  'title': widget.title
                }),
              );
              final parsed = json.decode(response.body);
              showModalBottomSheet(
                  elevation: 20.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0))),
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 175,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Ovaj naslov je',
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                          getSmiley(response.body),
                          getMood(response.body)
                        ],
                      ),
                    );
                  });
            },
            child: Icon(
              Icons.insert_emoticon,
              size: 40,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
