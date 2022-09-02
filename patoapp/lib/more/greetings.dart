import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/models/greeting_card.dart';
import 'package:patoapp/greeting_cards/share_card.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;
import 'package:path/path.dart' as pt;
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:patoapp/animations/permission.dart';

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
  bool isProgressGoing = false;
  // final GlobalKey globalKey = GlobalKey();
  Future<Uint8List> capturePng(GlobalKey globalKey) async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 5);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }

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
          title: Text(
            AppLocalizations.of(context)!.greetingCards,
            style: const TextStyle(color: Colors.white),
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
          bottom: TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(text: AppLocalizations.of(context)!.thankYou),
              Tab(text: AppLocalizations.of(context)!.offers),
              Tab(text: AppLocalizations.of(context)!.goodMorning),
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
        GlobalKey(),
        element,
        cardImage: element.greetingCard,
        defaultText: element.description,
        id: element.id,
      ));
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return myCustomData[index];
      },
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      itemCount: myCustomData.length,
    );
  }

  _loadedOffersCard() {
    List<Widget> myCustomData = [];
    for (SingleGreetingCard element in offersData) {
      myCustomData.add(_singleCard(
        GlobalKey(),
        element,
        cardImage: element.greetingCard,
        defaultText: element.description,
        id: element.id,
      ));
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return myCustomData[index];
      },
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      itemCount: myCustomData.length,
    );
  }

  _loadedGoodMorningCard() {
    List<Widget> myCustomData = [];
    for (SingleGreetingCard element in goodMorningData) {
      myCustomData.add(_singleCard(
        GlobalKey(),
        element,
        cardImage: element.greetingCard,
        defaultText: element.description,
        id: element.id,
      ));
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        return myCustomData[index];
      },
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      itemCount: myCustomData.length,
    );
    // return ListView(
    //   children: myCustomData,
    // );
  }

  _singleCard(
    GlobalKey globalKey,
    SingleGreetingCard myCard, {
    required cardImage,
    required defaultText,
    required id,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
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
              RepaintBoundary(
                key: globalKey,
                child: CachedNetworkImage(
                  imageUrl: "$imageBaseUrl$cardImage",
                ),
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
                      var status = await Permission.storage.request();
                      if (status.isGranted) {
                        Get.snackbar(
                          // ignore: use_build_context_synchronously
                          backgroundColor: Theme.of(context).cardColor,
                          colorText:
                              // ignore: use_build_context_synchronously
                              Theme.of(context).textTheme.bodyLarge?.color,
                          '10%',
                          'start downloading...',
                        );

                        final bytes = await capturePng(globalKey);
                        final dir = await getExternalStorageDirectory();
                        String myPath = pt.dirname(
                            pt.dirname(pt.dirname(pt.dirname(dir!.path))));
                        myPath = '$myPath/PatoWave/Greeting-Cards';
                        Directory('$myPath/').create();
                        String imageName =
                            pt.basename('$cardImage').replaceAll('.', '');
                        final file = File('$myPath/$imageName.png');
                        await file.writeAsBytes(bytes);

                        await ImageDownloader.open(file.path);
                      } else {
                        // ignore: use_build_context_synchronously
                        permissionDenied(context);
                      }
                      if (Get.isBottomSheetOpen == true) {
                        Get.back();
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.download, size: 18),
                        Container(width: 10),
                        Text(AppLocalizations.of(context)!.download),
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
                        Text(AppLocalizations.of(context)!.share),
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
