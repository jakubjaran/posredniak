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
    try {
      final url = Uri.parse('http://jobscraper.jakubjaran.p3.tiktalik.io');
      final response = await http.get(url);
      final offers = json.decode(response.body) as List;
      offers.forEach((offer) {
        final newOffer = Offer(
          title: offer['title'],
          link: offer['link'],
          date: offer['date'],
          place: offer['place'],
          source: offer['source'],
        );
        _items.add(newOffer);
      });
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
