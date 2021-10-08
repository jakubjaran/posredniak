import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share_plus/share_plus.dart';

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
              icon: Icon(Icons.share),
              onPressed: () => {Share.share(offer.link)},
            ),
            IconButton(
              icon: Icon(
                Icons.bookmark,
                color: isSaved
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey,
              ),
              onPressed: () {
                if (isSaved) {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Na pewno?'),
                      content: Text('Czy na pewno usunąć ofertę z zapisanych?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text('Anuluj'),
                        ),
                        TextButton(
                          onPressed: () {
                            Provider.of<Offers>(context, listen: false)
                                .toggleSaveOffer(offer);
                            Navigator.of(ctx).pop();
                          },
                          child: Text(
                            'Usuń',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  Provider.of<Offers>(context, listen: false)
                      .toggleSaveOffer(offer);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Zapisano oferte',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ));
                }
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
