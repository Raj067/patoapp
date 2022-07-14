// ignore: file_names
import 'dart:async';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/data/business_financial_data.dart';
import 'package:patoapp/themes/light_theme.dart';
// import 'package:http/http.dart' as http;

class TransactionReceipt extends StatefulWidget {
  final FinancialData data;
  const TransactionReceipt({Key? key, required this.data}) : super(key: key);

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

  String shopName = "Happy Shop";
  String address = "Happy Shop";
  String telphone = "Happy Shop";
  bool isLoading = false;
  fetchData() {}
  @override
  Widget build(BuildContext context) {
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
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
                            widget.data.isCashSale
                                ? const Text(
                                    "Cash Sale",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  )
                                : const Text(
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
                              children: [
                                const Text("Address:"),
                                Text(address),
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Tel:"),
                                Text(telphone),
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Date:"),
                                Text(widget.data.getTimeString()),
                              ],
                            ),
                            Container(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Time:"),
                                Text(
                                    "${widget.data.date.hour}:${widget.data.date.minute} HRS"),
                              ],
                            ),
                            widget.data.isPaymentIn ||
                                    widget.data.isPaymentOut ||
                                    widget.data.isExpenses
                                ? Column(
                                    children: [
                                      Container(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text("Customer Name:"),
                                          Text(
                                              widget.data.getDescriptionName()),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                            Container(height: 10),
                            const Text("=================================="),
                            widget.data.isPaymentIn ||
                                    widget.data.isPaymentOut ||
                                    widget.data.isExpenses
                                ? Column(
                                    children: [
                                      Container(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(widget.data
                                              .getDescriptionDetails()),
                                          Text(formatter
                                              .format(widget.data.amount)),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                            // FOR PURCHASES AND CASH SALE ONLY
                            widget.data.isPurchases || widget.data.isCashSale
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Items",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      _listItemsButtomSheet(
                                          widget.data.details),
                                    ],
                                  )
                                : Container(),
                            Container(height: 10),
                            const Text("=================================="),
                            Container(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "TOTAL:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  formatter.format(widget.data.amount),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Text("=================================="),
                            Container(height: 10),
                            widget.data.isCashSale
                                ? const Text(
                                    "Thank You For Your Purchases",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  )
                                : Container(),

                            Container(height: 10),
                            Center(
                              child: QrImage(
                                data:
                                    "${widget.data.date}-${widget.data.amount}-${widget.data.details}",
                                version: QrVersions.auto,
                                size: 200.0,
                                // embeddedImage:
                                //     const AssetImage("assets/images/qr.png"),
                                // embeddedImageStyle:
                                //     QrEmbeddedImageStyle(color: Colors.white),
                              ),
                            ),
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

  _listItemsButtomSheet(List data) {
    List<TableRow> fData = [];
    for (var dx in data) {
      fData.add(TableRow(children: [
        Text(
          dx['product'],
          style: const TextStyle(fontSize: 12),
        ),
        Center(
          child: Text(
            "${dx['quantity']} ${dx['product_unit']} x ${dx['price']}",
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "${dx['quantity'] * dx['price']}",
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ]));
    }
    return Table(children: fData);
  }
}
