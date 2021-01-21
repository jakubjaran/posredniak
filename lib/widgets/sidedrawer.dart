import 'package:flutter/material.dart';

class SideDrawer extends StatelessWidget {
  void tapHandler(BuildContext ctx, route) {
    Navigator.of(ctx).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text('Pośredniak', style: TextStyle(fontSize: 20)),
            ),
            decoration: BoxDecoration(color: Colors.indigo[300]),
          ),
          ListTile(
            onTap: () => tapHandler(context, '/saved-offers'),
            title: Row(
              children: [
                Icon(Icons.bookmark),
                SizedBox(width: 10),
                Text('Zapisane'),
              ],
            ),
          ),
          Divider(),
          ListTile(
            onTap: () => tapHandler(context, '/keywords'),
            title: Row(
              children: [
                Icon(Icons.fact_check),
                SizedBox(width: 10),
                Text('Słowa Klucze'),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
