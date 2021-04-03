import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:posredniak_app/widgets/sidedrawer.dart';

import 'package:posredniak_app/screens/all_offers_screen.dart';
import 'package:posredniak_app/screens/filtered_offers_screen.dart';

import 'package:posredniak_app/providers/offers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isFetching = false;
  var _selectedTabIndex = 0;

  Future<void> _fetchOffers() async {
    setState(() {
      _isFetching = true;
    });
    await Provider.of<Offers>(context, listen: false).fetchAndSetOffers();
    setState(() {
      _isFetching = false;
    });
  }

  @override
  void initState() {
    _fetchOffers();
    super.initState();
  }

  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _fetchOffers),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        currentIndex: _selectedTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.face_rounded),
            label: 'Dla Mnie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Wszystkie',
          ),
        ],
      ),
      drawer: Sidedrawer(),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
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
                  : _selectedTabIndex == 0
                      ? FilteredOffersScreen()
                      : AllOffersScreen(),
              onRefresh: _fetchOffers,
            ),
          ),
        ],
      ),
    );
  }
}
