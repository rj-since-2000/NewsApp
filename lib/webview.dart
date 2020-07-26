import 'dart:async';
import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {
  static const routeName = '/webview';
  final String title;
  final String selectedUrl;

  Webview({
    @required this.title,
    @required this.selectedUrl,
  });

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  num position = 1;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: IndexedStack(
          index: position,
          children: <Widget>[
            WebView(
              initialUrl: widget.selectedUrl,
              onPageStarted: startLoading,
              onPageFinished: doneLoading,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ));
  }
}
