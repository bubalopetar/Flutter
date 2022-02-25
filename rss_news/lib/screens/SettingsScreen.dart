import 'package:flutter/material.dart';
import 'package:rss_news/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double rating=kSummaryLength;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text('Duljina sažetka (broj rečenica):',
                style: TextStyle(
                  fontSize: 20,
                )),
          ),
          Slider(
              value: rating,
              divisions: 9,
              max: 10,
              min: 1,
              label:"$rating",
              onChanged: (double newVal) async{
                setState(() {
                  rating=newVal;
                  kSummaryLength=newVal;
                });
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setDouble('summary', newVal);
              })
        ],
      ),
    ));
  }
}
