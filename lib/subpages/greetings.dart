import 'package:flutter/material.dart';
import 'package:patoapp/themes/lightTheme.dart';

class MainGreetingsCards extends StatelessWidget {
  const MainGreetingsCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Greeting Cards',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: patowaveWhite,
            ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                text: "Thank You",
              ),
              Tab(
                text: "Offers",
              ),
              Tab(
                text: "Good Morning",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _thankYou(),
            _offers(),
            _goodMorning(),
          ],
        ),
      ),
    );
  }

  _thankYou() {
    return const Center(
      child: Text("Thank You"),
    );
  }

  _offers() {
    return const Center(
      child: Text("Offers"),
    );
  }

  _goodMorning() {
    return const Center(
      child: Text("Good Morning"),
    );
  }
}
