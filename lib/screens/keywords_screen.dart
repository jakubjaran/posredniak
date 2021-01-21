import 'package:flutter/material.dart';

import '../widgets/new_keyword_sheet.dart';

class KeywordsScreen extends StatelessWidget {
  final List<String> keywords;
  final Function addKeyword;
  final Function removeKeyword;

  KeywordsScreen(this.keywords, this.addKeyword, this.removeKeyword);

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => NewKeyowrdSheet(addKeyword),
    );
  }

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        child: ListView.builder(
          itemBuilder: (ctx, index) => Container(
            key: Key(keywords[index]),
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              tileColor: Colors.grey[900],
              title: Text(keywords[index]),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => removeKeyword(keywords[index]),
              ),
            ),
          ),
          itemCount: keywords.length,
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
