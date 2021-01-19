import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/offer.dart';

class OfferScreen extends StatelessWidget {
  final Function saveHandler;
  final List<Offer> savedOffers;

  OfferScreen(this.saveHandler, this.savedOffers);

  void showToast(String msg) {
    Fluttertoast.showToast(msg: msg, backgroundColor: Colors.black87);
  }

  @override
  Widget build(BuildContext context) {
    final offer = ModalRoute.of(context).settings.arguments as Offer;

    bool isSaved = false;

    for (var off in savedOffers) {
      if (off.link == offer.link) {
        isSaved = true;
        break;
      } else {
        isSaved = false;
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(offer.title),
          actions: [
            IconButton(
              icon: Icon(
                Icons.bookmark,
                color: isSaved ? Colors.greenAccent : Colors.grey,
              ),
              onPressed: () {
                saveHandler(offer);
                String msg = isSaved ? 'Usunięto' : 'Zapisano';
                showToast(msg);
              },
            )
          ],
        ),
        body: WebView(
          initialUrl: offer.link,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
