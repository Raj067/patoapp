import 'package:flutter/material.dart';
import 'package:patoapp/components/topBar.dart';
import 'package:patoapp/pages/inventory/analysis.dart';
import 'package:patoapp/pages/inventory/items.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: mainInventoryTopBar(context),
        body: const TabBarView(
          children: <Widget>[
            ItemsHomePage(),
            AnalysisHomePage(),
          ],
        ),
      ),
    );
  }
}
