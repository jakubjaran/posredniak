import 'package:flutter/material.dart';
import '../models/offer.dart';
import '../widgets/list_item.dart';

class SavedOffersScreen extends StatelessWidget {
  final List<Offer> savedOffers;

  SavedOffersScreen(this.savedOffers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zapisane'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListItem(savedOffers[index]);
        },
        itemCount: savedOffers.length,
      ),
    );
  }
}
