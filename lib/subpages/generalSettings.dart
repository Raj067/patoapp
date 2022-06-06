import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class GeneralSettingsDialog extends StatelessWidget {
  const GeneralSettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'General Settings',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patoWhite,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: const Text('Application'),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Transactions'),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('User Management'),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Print'),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Taxes'),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Items'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
