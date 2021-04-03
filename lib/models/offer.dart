import 'package:flutter/foundation.dart';

class Offer {
  final String title;
  final String date;
  final String link;
  final String place;
  final String source;

  Offer({
    @required this.title,
    @required this.date,
    @required this.link,
    @required this.place,
    @required this.source,
  });
}
