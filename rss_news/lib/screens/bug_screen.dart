import 'package:flutter/material.dart';
import '../services/bug.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BugScreen extends StatefulWidget {
  BugScreen({this.category});
  String category;
  @override
  _BugScreenState createState() => _BugScreenState();
}

class _BugScreenState extends State<BugScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    data = await BugHR().getArticles(context, widget.category);

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
          color: Colors.orange,
          size: 50.0,
        ),
      );
    }
  }
}
