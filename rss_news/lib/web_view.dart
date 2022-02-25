import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  static String name = 'view';
  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  @override
  Widget build(BuildContext context) {
    final String url = ModalRoute.of(context).settings.arguments;

    return MaterialApp(
        home: Scaffold(
      body: WebView(
        initialUrl: url,
      ),
    ));
  }
}

class ScreenArguments {
  final String url;
  ScreenArguments({this.url});
}
