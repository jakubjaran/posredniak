import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:posredniak_app/widgets/list_item.dart';

import 'package:posredniak_app/providers/offers.dart';

class FilteredOffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final offers = Provider.of<Offers>(context).filteredOffers;
    if (offers.length > 0) {
      return ListView.builder(
        itemBuilder: (context, index) {
          return ListItem(offers[index]);
        },
        itemCount: offers.length,
      );
    } else {
      return Center(
        child: ListView(
          children: [
            Container(
              height: 500,
              alignment: Alignment.center,
              child: Text(
                'Brak ofert pasujących do moich kryteriów.',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      );
    }
  }
}
