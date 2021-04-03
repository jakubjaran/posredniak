import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/offer.dart';

class OfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final offer = ModalRoute.of(context).settings.arguments as Offer;

    return Scaffold(
        appBar: AppBar(
          title: Text(offer.title),
          actions: [
            IconButton(
              icon: Icon(
                Icons.bookmark,
                // color: isSaved ? Colors.greenAccent : Colors.grey,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: WebView(
          initialUrl: offer.link,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
