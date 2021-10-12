import 'package:flutter/material.dart';
import '../models/offer.dart';
import '../widgets/date_divider.dart';
import 'package:provider/provider.dart';

import '../widgets/list_item.dart';

import '../providers/offers.dart';

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
        return ListView.separated(
          itemBuilder: (context, index) {
            return ListItem(offers[index]);
          },
          itemCount: offers.length,
          separatorBuilder: (context, index) {
            if (index == offers.length - 1) {
              return SizedBox.shrink();
            } else {
              final firstDate = offers[index].date.substring(0, 10);
              final secondDate = offers[index + 1].date.substring(0, 10);
              if (firstDate != secondDate) {
                return DateDivider(offers[index + 1].date);
              }
            }
            return SizedBox.shrink();
          },
        );
      },
    );
  }
}
