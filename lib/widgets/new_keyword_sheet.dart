import 'package:flutter/material.dart';

class NewKeyowrdSheet extends StatelessWidget {
  final Function addKeyword;

  NewKeyowrdSheet(this.addKeyword);

  final TextEditingController keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
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
            RaisedButton(
              onPressed: () {
                addKeyword(
                  keywordController.text.toUpperCase(),
                );
                Navigator.of(context).pop();
              },
              child: Text('Dodaj'),
            ),
          ],
        ),
      ),
    );
  }
}
