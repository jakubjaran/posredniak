import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:posredniak_app/models/offer.dart';

class ListItem extends StatelessWidget {
  final Offer offer;

  ListItem(this.offer);

  Color get sourceColor {
    switch (offer.source) {
      case 'LM.pl':
        return Colors.orange[400];
        break;
      case 'OLX.pl':
        return Colors.teal[400];
        break;
      case 'pracuj.pl':
        return Colors.blue[600];
        break;
      default:
        return Colors.white;
    }
  }

  void tapHandler(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      '/offer',
      arguments: offer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(offer.date);
    initializeDateFormatting('pl_PL', null);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: InkWell(
        key: Key(offer.link),
        onTap: () => tapHandler(context),
        splashColor: sourceColor,
        child: Ink(
          height: 120,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: sourceColor, width: 10),
            ),
            color: Colors.grey[900],
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offer.title,
                style: TextStyle(fontSize: 17),
              ),
              Text(DateFormat('d MMMM y', 'pl_PL').format(date)),
              Text(offer.place.length > 50
                  ? offer.place.substring(0, 50) + '...'
                  : offer.place)
            ],
          ),
        ),
      ),
    );
  }
}
