import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;

import './models/offer.dart';
import './widgets/list_item.dart';
import './SECRET.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Offer> offers = [];
  List<String> keywords = ['DORADCA', 'HANDLOWY'];
  List<Offer> filteredOffers = [];

  var isFiltered = false;
  var isFetching = false;

  Future<void> fetchMongo() async {
    setState(() {
      offers = [];
      isFetching = true;
      isFiltered = false;
    });

    var db = await Mongo.Db.create(MONGO_URL);
    await db.open();

    var col = db.collection('offers');
    col.find().forEach((element) {
      var offer = Offer(
        id: element['__id'],
        title: element['title'],
        date: element['date'],
        link: element['link'],
        place: element['place'],
        source: element['source'],
      );
      setState(() {
        offers = [...offers, offer];
        isFetching = false;
      });
    });
  }

  void filterOffers() {
    List<Offer> filtered = [];

    setState(() {
      filteredOffers = [];
    });

    if (offers.length > 0) {
      offers.forEach((offer) {
        keywords.forEach((keyword) {
          if (offer.title.toUpperCase().contains(keyword)) {
            if (!filtered.contains(offer)) {
              filtered.add(offer);
            }
          }
        });
      });

      setState(() {
        filteredOffers = filtered;
      });
    }
  }

  void toggleFilter(bool val) {
    filterOffers();
    setState(() {
      isFiltered = val;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMongo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pośredniak',
      theme: ThemeData.dark().copyWith(
          accentColor: Colors.blue,
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pośredniak'),
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
        body: Column(
          children: [
            Expanded(
              child: offers.length > 0
                  ? RefreshIndicator(
                      child: isFetching
                          ? Center(
                              child: Text(
                                'Szukanie ofert...',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          : isFiltered
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
                    )
                  : isFetching
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
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Brak ofert do wyświetlenia',
                                style: TextStyle(fontSize: 18),
                              ),
                              RaisedButton(
                                onPressed: fetchMongo,
                                child: Text('Szukaj'),
                              )
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
