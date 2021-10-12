import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:posredniak_app/widgets/sidedrawer.dart';

import 'package:posredniak_app/screens/offers_screen.dart';
import 'package:posredniak_app/screens/filtered_offers_screen.dart';

import 'package:posredniak_app/providers/offers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isFetching = false;
  var _isScraperUrlValid = true;
  var _selectedTabIndex = 1;

  Future<void> _fetchOffers() async {
    setState(() {
      _isFetching = true;
    });
    await Provider.of<Offers>(context, listen: false).fetchAndSetScraperUrl();
    final isScraperUrlValid =
        await Provider.of<Offers>(context, listen: false).fetchAndSetOffers();
    setState(() {
      _isFetching = false;
    });
    if (isScraperUrlValid) {
      setState(() {
        _isScraperUrlValid = true;
      });
    } else {
      setState(() {
        _isScraperUrlValid = false;
      });
    }
  }

  @override
  void initState() {
    _fetchOffers();
    Provider.of<Offers>(context, listen: false).fetchDB();
    super.initState();
  }

  void _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  Widget _tabSwitcher() {
    switch (_selectedTabIndex) {
      case 0:
        return FilteredOffersScreen();
        break;
      case 1:
        return OffersScreen(
          key: ValueKey('all'),
        );
        break;
      case 2:
        return OffersScreen(
          source: 'OLX.pl',
          key: ValueKey('olx'),
        );
        break;
      case 3:
        return OffersScreen(
          source: 'LM.pl',
          key: ValueKey('lm'),
        );
        break;
      case 4:
        return new OffersScreen(
          source: 'pracuj.pl',
          key: ValueKey('pracuj'),
        );
        break;
      default:
        return OffersScreen(
          key: ValueKey('all'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.bookmarks),
            onPressed: () => Navigator.of(context).pushNamed('/saved-offers'),
          ),
          IconButton(icon: Icon(Icons.refresh), onPressed: _fetchOffers),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectTab,
        currentIndex: _selectedTabIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        showUnselectedLabels: true,
        unselectedFontSize: 10,
        unselectedIconTheme: IconThemeData(size: 16),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.face_rounded),
            label: 'Dla Mnie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Wszystkie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: 'OLX',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: 'LM',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            label: 'Pracuj',
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
                            valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Szukanie ofert...',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : _isScraperUrlValid
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          child: _tabSwitcher())
                      : Center(
                          child: Text('Błędny adres scrapera.'),
                        ),
              onRefresh: _fetchOffers,
            ),
          ),
        ],
      ),
    );
  }
}
