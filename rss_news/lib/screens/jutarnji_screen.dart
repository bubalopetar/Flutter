import 'package:flutter/material.dart';
import 'package:rss_news/services/jutarnji.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class JutarnjiScreen extends StatefulWidget {
  @override
  _JutarnjiScreenState createState() => _JutarnjiScreenState();
}

class _JutarnjiScreenState extends State<JutarnjiScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    
    data = await JutarnjiHR().getArticles(context);
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
          color: Colors.blue,
          size: 50.0,
        ),
      );
    }
  }
}
