import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;
import 'package:flutter/services.dart';

import './SECRET.dart';
import './models/offer.dart';
import './widgets/list_item.dart';
import './widgets/sidedrawer.dart';
import './screens/offer_screen.dart';
import './screens/saved_offers_screen.dart';
import './screens/keywords_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Offer> offers = [];
  List<String> keywords = [];
  List<Offer> filteredOffers = [];
  List<Offer> savedOffers = [];

  var isFiltered = false;
  var isFetching = false;

  Offer parseOffer(element) {
    var offer = Offer(
      title: element['title'],
      date: element['date'],
      link: element['link'],
      place: element['place'],
      source: element['source'],
      json: element,
    );
    return offer;
  }

  Future<void> fetchMongo() async {
    setState(() {
      offers = [];
      savedOffers = [];
      keywords = [];
      isFetching = true;
      isFiltered = false;
    });

    var db = await Mongo.Db.create(MONGO_URL);
    await db.open();

    var offersCol = db.collection('offers');
    offersCol.find().forEach((element) {
      var offer = parseOffer(element);
      setState(() {
        offers.add(offer);
      });
    });

    var savedOffersCol = db.collection('savedOffers');
    savedOffersCol.find().forEach((element) {
      var offer = parseOffer(element);
      setState(() {
        savedOffers.add(offer);
      });
    });

    var keywordsCol = db.collection('keywords');
    keywordsCol.find().forEach((element) {
      setState(() {
        keywords.add(element['keyword']);
      });
    });

    setState(() {
      isFetching = false;
    });
  }

  void filterOffers() {
    setState(() {
      filteredOffers = [];
    });

    if (offers.length > 0) {
      offers.forEach((offer) {
        keywords.forEach((keyword) {
          if (offer.title.toUpperCase().contains(keyword)) {
            if (!filteredOffers.contains(offer)) {
              setState(() {
                filteredOffers.add(offer);
              });
            }
          }
        });
      });
    }
  }

  void toggleFilter(bool val) {
    filterOffers();
    setState(() {
      isFiltered = val;
    });
  }

  Future<void> saveOfferMongo(Offer offer, bool remove) async {
    var db = await Mongo.Db.create(MONGO_URL);
    await db.open();

    var savedCol = db.collection('savedOffers');

    if (remove) {
      savedCol.remove(offer.json);
    } else {
      savedCol.insert(offer.json);
    }
  }

  void saveOffer(Offer offer) {
    if (savedOffers.contains(offer)) {
      setState(() {
        savedOffers.remove(offer);
        saveOfferMongo(offer, true);
      });
    } else {
      setState(() {
        savedOffers.add(offer);
        saveOfferMongo(offer, false);
      });
    }
  }

  Future<void> addRemoveKeywordMongo(String keyword, bool remove) async {
    var db = await Mongo.Db.create(MONGO_URL);
    await db.open();

    var keywordsCol = db.collection('keywords');

    if (remove) {
      keywordsCol.remove({'keyword': keyword});
    } else {
      keywordsCol.insert({'keyword': keyword});
    }
  }

  void addKeyword(String keyword) {
    setState(() {
      keywords.add(keyword);
    });
    addRemoveKeywordMongo(keyword, false);
  }

  void removeKeyword(String keyword) {
    setState(() {
      keywords.remove(keyword);
    });
    addRemoveKeywordMongo(keyword, true);
  }

  @override
  void initState() {
    super.initState();
    fetchMongo();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return MaterialApp(
      title: 'Pośredniak',
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.blue,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
      ),
      routes: {
        '/saved-offers': (ctx) => SavedOffersScreen(savedOffers),
        '/offer': (ctx) => OfferScreen(saveOffer, savedOffers),
        '/keywords': (ctx) => KeywordsScreen(
              keywords,
              addKeyword,
              removeKeyword,
            ),
      },
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              child: Row(
                children: [
                  Switch(
                    value: isFiltered,
                    onChanged: toggleFilter,
                    activeColor: Theme.of(context).accentColor,
                  ),
                  Icon(
                    Icons.fact_check,
                    color: isFiltered ? Colors.greenAccent : Colors.grey,
                  ),
                ],
              ),
            ),
            IconButton(icon: Icon(Icons.refresh), onPressed: fetchMongo),
          ],
        ),
        drawer: Sidedrawer(),
        body: Column(
          children: [
            Expanded(
              child: isFetching
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Szukanie ofert...',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      child: isFiltered
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                return ListItem(filteredOffers[index]);
                              },
                              itemCount: filteredOffers.length,
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                return ListItem(offers[index]);
                              },
                              itemCount: offers.length,
                            ),
                      onRefresh: fetchMongo,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
