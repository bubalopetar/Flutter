import 'package:flutter/material.dart';
import 'package:rss_news/const.dart';

class MenuButtonWidget extends StatelessWidget {
  MenuButtonWidget({this.text, this.callback});
  String text;
  Function callback;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        child: Text(text, style: kMenuTextStyle),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: callback);
  }
}
