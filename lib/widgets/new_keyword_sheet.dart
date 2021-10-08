import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:posredniak_app/providers/offers.dart';

class NewKeyowrdSheet extends StatelessWidget {
  final TextEditingController keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              maxLength: 20,
              controller: keywordController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Słowo Klucz',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<Offers>(context, listen: false)
                    .addKeyword(keywordController.text.toUpperCase());
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                onPrimary: Theme.of(context).colorScheme.onSecondary,
              ),
              child: Text(
                'Dodaj',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
