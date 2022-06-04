import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';

class MainReportsPage extends StatelessWidget {
  const MainReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reports',
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
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: const Text('Profit and Loss'),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Cashflow'),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Balance sheet'),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Daybook'),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Expenses Reports'),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Sales Reports'),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Purchases Reports'),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Inventory Reports'),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('Inventory Summary'),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
            Card(
              child: ListTile(
                title: const Text('All Transactions'),
                onTap: () {},
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        Center(
            child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Journal",
                  style: TextStyle(color: patoWhite),
                )))
      ],
    );
  }
}
