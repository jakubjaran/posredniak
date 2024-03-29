import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/offers.dart';
import '../widgets/new_keyword_sheet.dart';

class KeywordsScreen extends StatelessWidget {
  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      builder: (_) => NewKeyowrdSheet(),
    );
  }

  void showAlertDialog(BuildContext context, String keyword) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Jesteś pewien?'),
        content: Text('Czy na pewno chcesz usunąć to słowo klucz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Anuluj'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<Offers>(context, listen: false)
                  .deleteKeyword(keyword);
              Navigator.of(context).pop();
            },
            child: Text(
              'Usuń',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keywords = Provider.of<Offers>(context).keywords;
    return Scaffold(
      appBar: AppBar(
        title: Text('Słowa Klucze'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => showBottomSheet(context),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: keywords.length > 0
          ? ListView.builder(
              itemBuilder: (ctx, index) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                key: Key(keywords[index]),
                margin: EdgeInsets.only(bottom: 10),
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  tileColor: Theme.of(context).colorScheme.surface,
                  title: Text(keywords[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => showAlertDialog(context, keywords[index]),
                  ),
                ),
              ),
              itemCount: keywords.length,
            )
          : Center(
              child: Container(
                width: 300,
                child: Text(
                  'Dodaj słowo klucz używając przycisku poniżej',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => showBottomSheet(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
