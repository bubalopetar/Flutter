import 'package:flutter/material.dart';
import '../services/index.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class IndexCScreen extends StatefulWidget {
  IndexCScreen({this.category});
  String category;
  @override
  _IndexCScreenState createState() => _IndexCScreenState();
}

class _IndexCScreenState extends State<IndexCScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    
    data = await IndexHR().getArticles(context, widget.category);

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
