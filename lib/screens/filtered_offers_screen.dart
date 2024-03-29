import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/list_item.dart';

import '../providers/offers.dart';

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
                'Brak pasujących ofert',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      );
    }
  }
}
