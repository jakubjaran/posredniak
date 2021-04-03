import 'package:flutter/material.dart';
import 'package:posredniak_app/widgets/list_item.dart';

class SavedOffersScreen extends StatelessWidget {
  final savedOffers = [];
  @override
  Widget build(BuildContext context) {
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
