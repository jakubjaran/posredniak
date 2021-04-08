import 'package:flutter/material.dart';

import 'package:posredniak_app/widgets/sidedrawer_item.dart';

class Sidedrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text('Pośredniak',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
            ),
            decoration: BoxDecoration(color: Theme.of(context).accentColor),
          ),
          SidedrawerItem(
            route: '/saved-offers',
            title: 'Zapisane',
            icon: Icons.bookmark,
          ),
          Divider(),
          SidedrawerItem(
            route: '/keywords',
            title: 'Słowa Klucze',
            icon: Icons.fact_check,
          ),
          Divider(),
        ],
      ),
    );
  }
}
