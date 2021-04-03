import 'package:flutter/material.dart';

import 'package:posredniak_app/widgets/list_item.dart';

class FilteredOffersScreen extends StatelessWidget {
  final offers = [];

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
