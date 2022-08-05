import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/models/greeting_card.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:share_plus/share_plus.dart';

class ShareGreetingCard extends StatefulWidget {
  final SingleGreetingCard myCard;
  const ShareGreetingCard({Key? key, required this.myCard}) : super(key: key);

  @override
  State<ShareGreetingCard> createState() => _ShareGreetingCardState();
}

class _ShareGreetingCardState extends State<ShareGreetingCard> {
  TextEditingController textMessage = TextEditingController();
  @override
  void initState() {
    textMessage.text = widget.myCard.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Share card',
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
      ),
      body: ListView(
        children: [
          Padding(
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
                      "$imageBaseUrl${widget.myCard.greetingCard}",
                    ),
                    Container(height: 15),
                    SizedBox(
                      child: TextFormField(
                        controller: textMessage,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 6,
                        maxLines: null,
                        decoration: const InputDecoration(
                          label: Text(
                            "Text Message",
                            style: TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 14),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                // MaterialStateProperty<Color?>? backgroundColor,
                backgroundColor: MaterialStateProperty.all(patowaveErrorRed),
                minimumSize: MaterialStateProperty.all(
                  const Size(45, 45),
                ),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
              ),
            ),
          ),
          Container(width: 10),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  const Size(45, 45),
                ),
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
              ),
              onPressed: () async {
                String? imageId = await ImageDownloader.downloadImage(
                    '$imageBaseUrl${widget.myCard.greetingCard}');
                var path = await ImageDownloader.findPath(imageId!);
                await Share.shareFiles([path!],
                    text: 'Receipt', subject: 'Receipt');
              },
              child: const Text(
                "Send",
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
