import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:posredniak_app/models/offer.dart';
import 'package:posredniak_app/providers/offers.dart';

class OfferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final offer = ModalRoute.of(context).settings.arguments as Offer;
    final isSaved =
        Provider.of<Offers>(context).savedIndex(offer.link) >= 0 ? true : false;
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
                Provider.of<Offers>(context, listen: false)
                    .toggleSaveOffer(offer);
              },
            ),
          ],
        ),
        body: WebView(
          initialUrl: offer.link,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
