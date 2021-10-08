import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateDivider extends StatelessWidget {
  final String dateString;

  const DateDivider(this.dateString, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(dateString);
    initializeDateFormatting('pl_PL', null);
    return Container(
      margin: EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 20),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
              thickness: 2,
              indent: 8,
              endIndent: 4,
            ),
          ),
          Text(
            DateFormat('d MMMM y', 'pl_PL').format(date),
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Expanded(
            child: Divider(
              color: Theme.of(context).colorScheme.secondary,
              thickness: 2,
              indent: 4,
              endIndent: 8,
            ),
          ),
        ],
      ),
    );
  }
}
