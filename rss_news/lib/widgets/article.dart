import 'package:flutter/material.dart';
import 'package:rss_news/web_view.dart';
import '../widgets/subtitle_menu.dart';
import 'package:rss_news/const.dart';

class ArticleWidget extends StatefulWidget {
  ArticleWidget({this.imageLink, this.title, this.webviewArgument,this.conf=0.0});
  String title;
  String imageLink;
  String webviewArgument;
  double conf;
  @override
  _ArticleWidgetState createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  var showSub = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: ListTile(
          isThreeLine: showSub,
          leading:widget.imageLink!=null? Image.network(
            widget.imageLink,
            // width: 150,
            // height: 70,
          ):widget.conf>1?Text('Clickbait',style: TextStyle(color: Colors.red,)):widget.conf>0.5?Text('Possible\nclickbait',style: TextStyle(color: Colors.green),):Text('Not\nclickbait',style: TextStyle(color: Colors.lightBlue)),
          title: Text(
            widget.title,
            style: kArticleTitleStyle,
          ),
          subtitle: showSub
              ? SubtitleMenu(
                  title: widget.title,
                  link: widget.webviewArgument,
                  imageLink: widget.imageLink,
                )
              : null,
          trailing: GestureDetector(
            onTap: () {
              showSub = !showSub;
              setState(() {});
            },
            child: Icon(
              showSub ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              size: 30,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, WebViewWidget.name,
                arguments: (widget.webviewArgument));
          }),
    );
  }
}
