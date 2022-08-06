import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/models/greeting_card.dart';
import 'package:patoapp/greeting_cards/share_card.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:http/http.dart' as http;

class MainGreetingsCards extends StatefulWidget {
  const MainGreetingsCards({Key? key}) : super(key: key);

  @override
  State<MainGreetingsCards> createState() => _MainGreetingsCardsState();
}

class _MainGreetingsCardsState extends State<MainGreetingsCards> {
  List thankYouData = [];
  List offersData = [];
  List goodMorningData = [];
  bool isLoading = true;
  fetchData() async {
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      var cardData = await http.get(
        Uri.parse(
          "${baseUrl}api/greeting-cards/",
        ),
        headers: getAuthHeaders(accessToken),
      );
      if (cardData.statusCode == 200) {
        List<SingleGreetingCard> newDataThankYou = [];
        List<SingleGreetingCard> newDataOffers = [];
        List<SingleGreetingCard> newDataGoodMorning = [];
        for (var element in jsonDecode(cardData.body)) {
          if (element['card_category'] == 'thank-you') {
            newDataThankYou.add(SingleGreetingCard(
              cardCategory: element['card_category'],
              greetingCard: element['greeting_card'],
              description: element['default_text'],
              id: element['id'],
            ));
          }
          if (element['card_category'] == 'offers') {
            newDataOffers.add(SingleGreetingCard(
              cardCategory: element['card_category'],
              greetingCard: element['greeting_card'],
              description: element['default_text'],
              id: element['id'],
            ));
          }
          if (element['card_category'] == 'good-morning') {
            newDataGoodMorning.add(SingleGreetingCard(
              cardCategory: element['card_category'],
              greetingCard: element['greeting_card'],
              description: element['default_text'],
              id: element['id'],
            ));
          }
        }
        thankYouData = newDataThankYou;
        offersData = newDataOffers;
        goodMorningData = newDataGoodMorning;
        isLoading = false;
      }
      setState(() {});
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No internent connection"),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
    return isLoading
        ? const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _loadedThankYouCard();
  }

  _offers() {
    return isLoading
        ? const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _loadedOffersCard();
  }

  _goodMorning() {
    return isLoading
        ? const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _loadedGoodMorningCard();
  }

  _loadedThankYouCard() {
    List<Widget> myCustomData = [];
    for (SingleGreetingCard element in thankYouData) {
      myCustomData.add(_singleCard(
        element,
        cardImage: element.greetingCard,
        defaultText: element.description,
        id: element.id,
      ));
    }
    return ListView(
      children: myCustomData,
    );
  }

  _loadedOffersCard() {
    List<Widget> myCustomData = [];
    for (SingleGreetingCard element in offersData) {
      myCustomData.add(_singleCard(
        element,
        cardImage: element.greetingCard,
        defaultText: element.description,
        id: element.id,
      ));
    }
    return ListView(
      children: myCustomData,
    );
  }

  _loadedGoodMorningCard() {
    List<Widget> myCustomData = [];
    for (SingleGreetingCard element in goodMorningData) {
      myCustomData.add(_singleCard(
        element,
        cardImage: element.greetingCard,
        defaultText: element.description,
        id: element.id,
      ));
    }
    return ListView(
      children: myCustomData,
    );
  }

  _singleCard(
    SingleGreetingCard myCard, {
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
              CachedNetworkImage(
                imageUrl: "$imageBaseUrl$cardImage",
              ),
              // Image.network(
              //   "$imageBaseUrl$cardImage",
              //   loadingBuilder: (BuildContext context, Widget child,
              //       ImageChunkEvent? loadingProgress) {
              //     if (loadingProgress == null) return child;
              //     return Center(
              //       child: CircularProgressIndicator(
              //         value: loadingProgress.expectedTotalBytes != null
              //             ? loadingProgress.cumulativeBytesLoaded /
              //                 loadingProgress.expectedTotalBytes!
              //             : null,
              //       ),
              //     );
              //   },
              // ),
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
                    onPressed: () async {
                      var imageId = await ImageDownloader.downloadImage(
                        "$imageBaseUrl$cardImage",
                        destination: AndroidDestinationType.custom(
                          directory: 'PatoWave/logo/',
                          inPublicDir: true,
                        ),
                      );
                      var path = await ImageDownloader.findPath(imageId!);
                      ImageDownloader.open(path!);
                    },
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              ShareGreetingCard(myCard: myCard),
                          fullscreenDialog: true,
                        ),
                      );
                    },
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
