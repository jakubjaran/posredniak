import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:posredniak_app/models/offer.dart';

import '../models/offer.dart';

class Offers with ChangeNotifier {
  List<Offer> _items = [];

  List<Offer> get items {
    return [..._items];
  }

  List<String> _keywords = ['Pracownik'];

  List<String> get keywords {
    return [..._keywords];
  }

  Future<void> fetchAndSetOffers() async {
    try {
      final url = Uri.parse('http://jobscraper.jakubjaran.p3.tiktalik.io');
      final response = await http.get(url);
      final offers = json.decode(response.body) as List;
      _items = [];
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
      filterOffers();
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<Offer> _filteredOffers = [];

  List<Offer> get filteredOffers {
    return [..._filteredOffers];
  }

  void filterOffers() {
    if (_items.length <= 0) {
      fetchAndSetOffers();
    }
    _filteredOffers = [];
    _items.forEach((offer) {
      _keywords.forEach((keyword) {
        RegExp exp = new RegExp(
          "\\b" + keyword + "\\b",
          caseSensitive: false,
        );
        if (exp.hasMatch(offer.title)) {
          _filteredOffers.add(offer);
        }
      });
    });
    notifyListeners();
  }
}
