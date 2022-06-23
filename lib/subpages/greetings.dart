import 'package:flutter/material.dart';
import 'package:patoapp/themes/lightTheme.dart';

class MainGreetingsCards extends StatelessWidget {
  const MainGreetingsCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Items",
              ),
              Tab(
                text: "Analysis",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Text("item 1"),
            Text("item 2"),
          ],
        ),
      ),
    );
  }
}
