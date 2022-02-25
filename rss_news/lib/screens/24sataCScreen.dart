import 'package:flutter/material.dart';
import 'package:rss_news/services/24sata.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class II4sataCScreen extends StatefulWidget {
  II4sataCScreen({this.category});
  String category;
  @override
  _II4sataCScreenState createState() => _II4sataCScreenState();
}

class _II4sataCScreenState extends State<II4sataCScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    data = await II4sataHR().getArticles(context, widget.category);
    setState(() {});
  }

  ListView data;
  @override
  Widget build(BuildContext context) {
    if (data != null)
      return RefreshIndicator(child: data, onRefresh: () => getData());
    else {
      return Scaffold(
        body: SpinKitCircle(
          color: Colors.yellow,
          size: 50.0,
        ),
      );
    }
  }
}
