import 'package:flutter/material.dart';
import 'package:patoapp/greeting_cards/good_morning.dart';
import 'package:patoapp/greeting_cards/offers.dart';
import 'package:patoapp/greeting_cards/thank_you.dart';
import 'package:patoapp/themes/light_theme.dart';

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
        body: const TabBarView(
          children: <Widget>[
            ThankYouCards(),
            OfferCards(),
            GoodMorningCards(),
          ],
        ),
      ),
    );
  }
}
