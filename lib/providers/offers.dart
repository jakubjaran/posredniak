import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:posredniak_app/models/offer.dart';

class Offers with ChangeNotifier {
  List<Offer> _items = [];

  List<Offer> get items {
    return [..._items];
  }

  Future<void> fetchAndSetOffers() async {
    final url = Uri.parse('http://jobscraper.jakubjaran.p3.tiktalik.io');
    final response = await http.get(url);
    print(json.decode(response.body));
  }
}
