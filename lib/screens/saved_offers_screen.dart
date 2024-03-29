import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/list_item.dart';
import '../providers/offers.dart';

class SavedOffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final savedOffers = Provider.of<Offers>(context).savedOffets;
    return Scaffold(
      appBar: AppBar(
        title: Text('Zapisane oferty'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: savedOffers.length > 0
          ? Container(
              margin: EdgeInsets.only(top: 10),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListItem(savedOffers[index]);
                },
                itemCount: savedOffers.length,
              ),
            )
          : Center(
              child: Text(
                'Brak zapisanych ofert',
                style: TextStyle(fontSize: 16),
              ),
            ),
    );
  }
}
