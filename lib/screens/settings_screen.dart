import 'package:flutter/material.dart';
import '../providers/offers.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController urlController = TextEditingController();

  @override
  void didChangeDependencies() {
    setState(() {
      urlController.text = Provider.of<Offers>(context).scraperUrl;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ustawienia'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                label: Text('Scraper URL'),
              ),
              controller: urlController,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<Offers>(context, listen: false)
                    .setScraperUrl(urlController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(milliseconds: 700),
                    content: Text(
                      'Zapisano URL',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                );
              },
              child: Text('Zapisz'),
            ),
          ],
        ),
      ),
    );
  }
}
