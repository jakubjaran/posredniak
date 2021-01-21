import 'package:flutter/material.dart';

class SidedrawerItem extends StatelessWidget {
  final String route;
  final String title;
  final IconData icon;

  SidedrawerItem({
    @required this.route,
    @required this.title,
    @required this.icon,
  });

  void tapHandler(BuildContext ctx, route) {
    Navigator.of(ctx).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => tapHandler(context, route),
      title: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }
}
