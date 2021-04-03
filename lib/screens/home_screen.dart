import 'package:flutter/material.dart';

import 'package:posredniak_app/widgets/sidedrawer.dart';

import 'package:posredniak_app/screens/all_offers_screen.dart';
import 'package:posredniak_app/screens/filtered_offers_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isFetching = false;
  var _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i) {},
        currentIndex: _selectedTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Wszystkie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check),
            label: 'Filtrowane',
          ),
        ],
      ),
      drawer: Sidedrawer(),
      body: Column(
        children: [
          Expanded(
            child: _isFetching
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
                    child: _selectedTabIndex == 0
                        ? AllOffersScreen()
                        : FilteredOffersScreen(),
                    onRefresh: () {},
                  ),
          ),
        ],
      ),
    );
  }
}
