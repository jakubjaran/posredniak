import 'package:flutter/material.dart';

class NewKeyowrdSheet extends StatelessWidget {
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
            ElevatedButton(
              onPressed: () {},
              child: Text('Dodaj'),
            ),
          ],
        ),
      ),
    );
  }
}
