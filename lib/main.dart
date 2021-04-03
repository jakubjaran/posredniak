import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:posredniak_app/screens/offer_screen.dart';
import 'package:posredniak_app/screens/home_screen.dart';
import 'package:posredniak_app/screens/saved_offers_screen.dart';
import 'package:posredniak_app/screens/keywords_screen.dart';

import 'package:posredniak_app/providers/offers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // List<Offer> offers = [];
  // List<String> keywords = [];
  // List<Offer> filteredOffers = [];
  // List<Offer> savedOffers = [];

  // var isFetching = false;

  // var selectedTabIndex = 0;

  // void selectTabHandler(int index) {
  //   if (index == 1) {
  //     filterOffers();
  //   }
  //   setState(() {
  //     selectedTabIndex = index;
  //   });
  // }

  // Offer parseOffer(element) {
  //   var offer = Offer(
  //     title: element['title'],
  //     date: element['date'],
  //     link: element['link'],
  //     place: element['place'],
  //     source: element['source'],
  //     json: element,
  //   );
  //   return offer;
  // }

  // Future<void> fetchMongo() async {
  //   setState(() {
  //     offers = [];
  //     savedOffers = [];
  //     keywords = [];
  //     isFetching = true;
  //   });

  //   var db = await Mongo.Db.create(MONGO_URL);
  //   await db.open();

  //   var offersCol = db.collection('offers');
  //   offersCol.find().forEach((element) {
  //     var offer = parseOffer(element);
  //     setState(() {
  //       offers.add(offer);
  //     });
  //   });

  //   var savedOffersCol = db.collection('savedOffers');
  //   savedOffersCol.find().forEach((element) {
  //     var offer = parseOffer(element);
  //     setState(() {
  //       savedOffers.add(offer);
  //     });
  //   });

  //   var keywordsCol = db.collection('keywords');
  //   keywordsCol.find().forEach((element) {
  //     setState(() {
  //       keywords.add(element['keyword']);
  //     });
  //   });

  //   setState(() {
  //     isFetching = false;
  //   });
  // }

  // void filterOffers() {
  //   setState(() {
  //     filteredOffers = [];
  //   });

  //   if (offers.length > 0) {
  //     offers.forEach((offer) {
  //       keywords.forEach((keyword) {
  //         RegExp exp = new RegExp(
  //           "\\b" + keyword + "\\b",
  //           caseSensitive: false,
  //         );
  //         if (exp.hasMatch(offer.title)) {
  //           if (!filteredOffers.contains(offer)) {
  //             setState(() {
  //               filteredOffers.add(offer);
  //             });
  //           }
  //         }
  //       });
  //     });
  //   }
  // }

  // Future<void> saveOfferMongo(Offer offer, bool remove) async {
  //   var db = await Mongo.Db.create(MONGO_URL);
  //   await db.open();

  //   var savedCol = db.collection('savedOffers');

  //   if (remove) {
  //     savedCol.remove(offer.json);
  //   } else {
  //     savedCol.insert(offer.json);
  //   }
  // }

  // void saveOffer(Offer offer) {
  //   if (savedOffers.contains(offer)) {
  //     setState(() {
  //       savedOffers.remove(offer);
  //       saveOfferMongo(offer, true);
  //     });
  //   } else {
  //     setState(() {
  //       savedOffers.add(offer);
  //       saveOfferMongo(offer, false);
  //     });
  //   }
  // }

  // Future<void> addRemoveKeywordMongo(String keyword, bool remove) async {
  //   var db = await Mongo.Db.create(MONGO_URL);
  //   await db.open();

  //   var keywordsCol = db.collection('keywords');

  //   if (remove) {
  //     keywordsCol.remove({'keyword': keyword});
  //   } else {
  //     keywordsCol.insert({'keyword': keyword});
  //   }
  // }

  // void addKeyword(String keyword) {
  //   setState(() {
  //     keywords.add(keyword);
  //   });
  //   addRemoveKeywordMongo(keyword, false);
  // }

  // void removeKeyword(String keyword) {
  //   setState(() {
  //     keywords.remove(keyword);
  //   });
  //   addRemoveKeywordMongo(keyword, true);
  // }

  @override
  void initState() {
    super.initState();
    // fetchMongo();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return ChangeNotifierProvider(
      create: (ctx) => Offers(),
      child: MaterialApp(
        title: 'Pośredniak',
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.blue,
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.blue,
            selectionColor: Colors.blueAccent,
            selectionHandleColor: Colors.blue,
          ),
        ),
        routes: {
          '/saved-offers': (ctx) => SavedOffersScreen(),
          '/offer': (ctx) => OfferScreen(),
          '/keywords': (ctx) => KeywordsScreen(),
        },
        // home: Scaffold(
        //   appBar: AppBar(
        //     actions: [
        //       IconButton(icon: Icon(Icons.refresh), onPressed: fetchMongo),
        //     ],
        //   ),
        //   bottomNavigationBar: BottomNavigationBar(
        //     onTap: selectTabHandler,
        //     currentIndex: selectedTabIndex,
        //     items: [
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.list_alt),
        //         label: 'Wszystkie',
        //       ),
        //       BottomNavigationBarItem(
        //         icon: Icon(Icons.fact_check),
        //         label: 'Filtrowane',
        //       ),
        //     ],
        //   ),
        //   drawer: Sidedrawer(),
        //   body: Column(
        //     children: [
        //       Expanded(
        //         child: isFetching
        //             ? Center(
        //                 child: Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: [
        //                     CircularProgressIndicator(
        //                       valueColor: AlwaysStoppedAnimation(Colors.blue),
        //                     ),
        //                     SizedBox(
        //                       height: 20,
        //                     ),
        //                     Text(
        //                       'Szukanie ofert...',
        //                       style: TextStyle(fontSize: 18),
        //                     ),
        //                   ],
        //                 ),
        //               )
        //             : RefreshIndicator(
        //                 child: selectedTabIndex == 0
        //                     ? AllOffersScreen(offers)
        //                     : FilteredOffersScreen(filteredOffers),
        //                 onRefresh: fetchMongo,
        //               ),
        //       ),
        //     ],
        //   ),
        // ),
        home: HomeScreen(),
      ),
    );
  }
}
