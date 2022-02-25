import 'package:flutter/material.dart';
import 'package:rss_news/services/24sata.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class II4sataScreen extends StatefulWidget {
  II4sataScreen({this.category});
  String category;
  @override
  _II4sataScreenState createState() => _II4sataScreenState();
}

class _II4sataScreenState extends State<II4sataScreen> {
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
