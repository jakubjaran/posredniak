import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as Mongo;

import './models/offer.dart';
import './widgets/list_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Offer> offers = [];

  var isFetching = false;

  Future<void> fetchMongo() async {
    setState(() {
      offers = [];
      isFetching = true;
    });

    var db = await Mongo.Db.create(
        'mongodb+srv://admin:22mpdkz10gs_@cluster0.jtv83.mongodb.net/job_scraper?retryWrites=true&w=majority');
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pośredniak',
      theme: ThemeData.dark().copyWith(
          backgroundColor: Colors.black, scaffoldBackgroundColor: Colors.black),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pośredniak'),
          actions: [
            IconButton(icon: Icon(Icons.refresh), onPressed: fetchMongo)
          ],
          leading: IconButton(icon: Icon(Icons.menu), onPressed: null),
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
