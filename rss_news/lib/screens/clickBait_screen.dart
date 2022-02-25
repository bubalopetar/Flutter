import 'package:flutter/material.dart';
import 'package:rss_news/services/ClickBait.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ClickBaitScreen extends StatefulWidget {
  @override
  _ClickBaitScreenState createState() => _ClickBaitScreenState();
}

class _ClickBaitScreenState extends State<ClickBaitScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    data = await ClickBait().getArticles(context);
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
          color: Colors.red,
          size: 50.0,
        ),
      );
    }
  }
}
