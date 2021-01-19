import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OfferScreen extends StatelessWidget {
  final String title;
  final String url;

  OfferScreen(this.title, this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [IconButton(icon: Icon(Icons.bookmark), onPressed: null)],
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
