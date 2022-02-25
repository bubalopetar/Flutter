import 'package:flutter/material.dart';
import 'package:rss_news/const.dart';
import 'package:rss_news/services/dnevnik.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DnevnikScreen extends StatefulWidget {
  @override
  _DnevnikScreenState createState() => _DnevnikScreenState();
}

class _DnevnikScreenState extends State<DnevnikScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    data = await DnevnikHR().getArticles(context);
    setState(() {});
  }

  ListView data;
  @override
  Widget build(BuildContext context) {
    if (data != null)
      return RefreshIndicator(
          child: Container(
            child: data,
          ),
          onRefresh: () => getData());
    else {
      return Scaffold(
        body: SpinKitCircle(
          color: kDnevnikColor,
          size: 50.0,
        ),
      );
    }
  }
}
