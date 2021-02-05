import 'package:flutter/material.dart';

import '../models/offer.dart';
import '../widgets/list_item.dart';

class FilteredOffersScreen extends StatelessWidget {
  final List<Offer> offers;

  FilteredOffersScreen(this.offers);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListItem(offers[index]);
      },
      itemCount: offers.length,
    );
  }
}
