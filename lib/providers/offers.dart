import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:posredniak_app/helpers/DB_helper.dart';
import 'package:posredniak_app/models/offer.dart';

class Offers with ChangeNotifier {
  List<Offer> _items = [];

  List<Offer> get items {
    return [..._items];
  }

  List<String> _keywords = [];

  List<String> get keywords {
    return [..._keywords];
  }

  void addKeyword(String keyword) {
    _keywords.add(keyword);
    DBHelper.insert(
      'keywords.db',
      'keywords',
      {'keyword': keyword},
    );
    notifyListeners();
    filterOffers();
  }

  void deleteKeyword(String keyword) {
    _keywords.removeWhere((kwrd) => kwrd == keyword);
    DBHelper.delete(
      'keywords.db',
      'keywords',
      'keyword = ?',
      [keyword],
    );
    notifyListeners();
    filterOffers();
  }

  Future<void> fetchAndSetOffers() async {
    try {
      final url = Uri.parse('http://jobscraper.jakubjaran.p5.tiktalik.io:3000');
      final response = await http.get(url);
      final offers = json.decode(response.body);
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

  List<Offer> _savedOffers = [];

  List<Offer> get savedOffets {
    return [..._savedOffers];
  }

  int savedIndex(offerUrl) {
    return _savedOffers.indexWhere((offer) => offer.link == offerUrl);
  }

  void toggleSaveOffer(Offer offer) {
    final index = savedIndex(offer.link);
    if (index < 0) {
      _savedOffers.add(offer);
      DBHelper.insert('savedOffers.db', 'savedOffers', {
        'title': offer.title,
        'date': offer.date,
        'link': offer.link,
        'place': offer.place,
        'source': offer.source,
      });
    } else {
      _savedOffers.removeAt(index);
      DBHelper.delete(
          'savedOffers.db', 'savedOffers', 'link = ?', [offer.link]);
    }
    notifyListeners();
  }

  void fetchDB() async {
    final keywordsData = await DBHelper.getData('keywords.db', 'keywords');
    final savedOffersData =
        await DBHelper.getData('savedOffers.db', 'savedOffers');
    _keywords = [];
    keywordsData.forEach((keywordData) {
      _keywords.add(keywordData['keyword']);
    });
    _savedOffers = [];
    savedOffersData.forEach((offerData) {
      _savedOffers.add(Offer(
        title: offerData['title'],
        date: offerData['date'],
        link: offerData['link'],
        place: offerData['place'],
        source: offerData['source'],
      ));
    });
    notifyListeners();
  }
}
