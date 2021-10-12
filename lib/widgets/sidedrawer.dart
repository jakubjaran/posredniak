import 'package:flutter/material.dart';

import 'sidedrawer_item.dart';

class Sidedrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text('Pośredniak',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SidedrawerItem(
            route: '/saved-offers',
            title: 'Zapisane oferty',
            icon: Icons.bookmark,
          ),
          Divider(),
          SidedrawerItem(
            route: '/keywords',
            title: 'Słowa Klucze',
            icon: Icons.fact_check,
          ),
          Divider(),
          SidedrawerItem(
            route: '/settings',
            title: 'Ustawienia',
            icon: Icons.settings,
          ),
          Divider(),
        ],
      ),
    );
  }
}
