import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:posredniak_app/widgets/list_item.dart';
import 'package:posredniak_app/providers/offers.dart';

class SavedOffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final savedOffers = Provider.of<Offers>(context).savedOffets;
    return Scaffold(
      appBar: AppBar(
        title: Text('Zapisane'),
      ),
      body: savedOffers.length > 0
          ? ListView.builder(
              itemBuilder: (context, index) {
                return ListItem(savedOffers[index]);
              },
              itemCount: savedOffers.length,
            )
          : Center(
              child: Text(
                'Brak zapisanych ofert',
                style: TextStyle(fontSize: 18),
              ),
            ),
    );
  }
}
