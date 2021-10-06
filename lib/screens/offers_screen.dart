import 'package:flutter/material.dart';
import 'package:posredniak_app/models/offer.dart';
import 'package:provider/provider.dart';

import 'package:posredniak_app/widgets/list_item.dart';

import 'package:posredniak_app/providers/offers.dart';

class OffersScreen extends StatelessWidget {
  final String source;
  OffersScreen({this.source, Key key}) : super(key: key);

  List<Offer> filterOffersBySource(List<Offer> allOffers, String source) =>
      allOffers.where((offer) => offer.source == source).toList();

  @override
  Widget build(BuildContext context) {
    return Consumer<Offers>(
      builder: (context, data, ch) {
        List<Offer> offers;
        if (this.source != null) {
          offers = filterOffersBySource(data.items, source);
        } else {
          offers = data.items;
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListItem(offers[index]);
          },
          itemCount: offers.length,
        );
      },
    );
  }
}
