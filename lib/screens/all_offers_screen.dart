import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:posredniak_app/widgets/list_item.dart';

import 'package:posredniak_app/providers/offers.dart';

class AllOffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final offers = Provider.of<Offers>(context).items;
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListItem(offers[index]);
      },
      itemCount: offers.length,
    );
  }
}
