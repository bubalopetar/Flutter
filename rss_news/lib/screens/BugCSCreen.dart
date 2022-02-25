import 'package:flutter/material.dart';
import '../services/bug.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BugCScreen extends StatefulWidget {
  BugCScreen({this.category});
  String category;
  @override
  _BugCScreenState createState() => _BugCScreenState();
}

class _BugCScreenState extends State<BugCScreen> {
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
