import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/data/greeting_card.dart';

class ThankYouCards extends StatefulWidget {
  const ThankYouCards({Key? key}) : super(key: key);

  @override
  State<ThankYouCards> createState() => _ThankYouCardsState();
}

class _ThankYouCardsState extends State<ThankYouCards> {
  List<SingleGreetingCard> myData = [];
  bool isLoading = true;
  fetchData() async {
    var cardData = await http.get(
      Uri.parse(
        "${baseUrl}api/greeting-cards/",
      ),
      headers: authHeaders,
    );
    if (cardData.statusCode == 200) {
      List<SingleGreetingCard> newData = [];
      for (var element in jsonDecode(cardData.body)) {
        if (element['card_category'] == 'thank-you') {
          newData.add(SingleGreetingCard(
            cardCategory: element['card_category'],
            greetingCard: element['greeting_card'],
            description: element['default_text'],
            id: element['id'],
          ));
        }
      }
      myData = newData;
      isLoading = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _loadedCard();
  }

  _loadedCard() {
    List<Widget> myCustomData = [];
    for (SingleGreetingCard element in myData) {
      myCustomData.add(_singleCard(
        cardImage: element.greetingCard,
        defaultText: element.description,
        id: element.id,
      ));
    }
    return ListView(
      children: myCustomData,
    );
  }

  _singleCard({
    required cardImage,
    required defaultText,
    required id,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Image.network(
                "$imageBaseUrl$cardImage",
              ),
              Container(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Icon(Icons.download, size: 18),
                        Container(width: 10),
                        const Text("Download"),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Icon(Icons.share, size: 18),
                        Container(width: 10),
                        const Text("Share"),
                      ],
                    ),
                  ),
                ],
              ),
              Container(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
