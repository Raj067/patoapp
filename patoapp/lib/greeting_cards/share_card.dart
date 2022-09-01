import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/models/greeting_card.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui' as ui;
import 'package:path/path.dart' as pt;

class ShareGreetingCard extends StatefulWidget {
  final SingleGreetingCard myCard;
  const ShareGreetingCard({Key? key, required this.myCard}) : super(key: key);

  @override
  State<ShareGreetingCard> createState() => _ShareGreetingCardState();
}

class _ShareGreetingCardState extends State<ShareGreetingCard> {
  TextEditingController textMessage = TextEditingController();
  final GlobalKey globalKey = GlobalKey();
  Future<Uint8List> capturePng() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 5);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
  }

  @override
  void initState() {
    textMessage.text = widget.myCard.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.shareCard,
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
                    RepaintBoundary(
                      key: globalKey,
                      child: CachedNetworkImage(
                        imageUrl: "$imageBaseUrl${widget.myCard.greetingCard}",
                      ),
                    ),
                    Container(height: 15),
                    SizedBox(
                      child: TextFormField(
                        controller: textMessage,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        minLines: 6,
                        maxLines: null,
                        decoration: InputDecoration(
                          label: Text(
                            AppLocalizations.of(context)!.textMessage,
                            style: const TextStyle(
                                fontStyle: FontStyle.italic, fontSize: 14),
                          ),
                          border: const OutlineInputBorder(
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
              child: Text(
                AppLocalizations.of(context)!.cancel,
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
                final bytes = await capturePng();
                final dir = await getApplicationDocumentsDirectory();
                final file = File('${dir.path}/card.png');
                await file.writeAsBytes(bytes);
                // file.path
                await Share.shareFiles([file.path],
                    subject: textMessage.text, text: textMessage.text);
                // await Share.share(
                //     '$imageBaseUrl${widget.myCard.greetingCard} ${textMessage.text}',
                //     subject: textMessage.text);
              },
              child: Text(
                AppLocalizations.of(context)!.send,
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
