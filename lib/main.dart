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

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return ChangeNotifierProvider(
      create: (ctx) => Offers(),
      child: MaterialApp(
        title: 'Pośredniak',
        theme: ThemeData.dark().copyWith(
          accentColor: Colors.greenAccent,
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.greenAccent,
            foregroundColor: Colors.black,
          ),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.greenAccent,
            selectionColor: Colors.greenAccent,
            selectionHandleColor: Colors.greenAccent,
          ),
        ),
        routes: {
          '/saved-offers': (ctx) => SavedOffersScreen(),
          '/offer': (ctx) => OfferScreen(),
          '/keywords': (ctx) => KeywordsScreen(),
        },
        home: HomeScreen(),
      ),
    );
  }
}
