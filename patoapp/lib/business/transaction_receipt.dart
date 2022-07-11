// ignore: file_names
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patoapp/themes/light_theme.dart';

class TransactionReceipt extends StatefulWidget {
  const TransactionReceipt({Key? key}) : super(key: key);

  @override
  State<TransactionReceipt> createState() => _TransactionReceiptState();
}

class _TransactionReceiptState extends State<TransactionReceipt> {
  final GlobalKey globalKey = GlobalKey();
  Future<void> capturePng() async {
    //Get the render object from context.
    RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    //Convert to the image
    final ui.Image image = await boundary.toImage();
  }

  @override
  Widget build(BuildContext context) {
    String shopName = "Happy Shop";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction Receipt',
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
          RepaintBoundary(
            key: globalKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
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
                      const Text(
                        "Transaction Receipt",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Container(height: 10),
                      Text(shopName),
                      Container(height: 10),
                      const Text("=================================="),
                      Container(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Address:"),
                          Text("Address"),
                        ],
                      ),
                      Container(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Tel:"),
                          Text("tel"),
                        ],
                      ),
                      Container(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Date:"),
                          Text("date"),
                        ],
                      ),
                      Container(height: 10),
                      const Text("=================================="),
                      Container(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Product 1"),
                          Text("12300"),
                        ],
                      ),
                      Container(height: 10),
                      const Text("=================================="),
                      Container(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "TOTAL:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "3200",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Text("=================================="),
                      Container(height: 10),
                      const Text(
                        "Thank You",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Container(height: 10),
                      const FaIcon(
                        FontAwesomeIcons.barcode,
                      ),
                      Container(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          capturePng();
        },
        child: const Icon(Icons.share),
      ),
    );
  }
}
