// ignore: file_names
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patoapp/backend/db/db_profile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'dart:ui' as ui;
import 'package:image_downloader/image_downloader.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as pt;

class TransactionReceipt extends StatefulWidget {
  final FinancialData data;
  const TransactionReceipt({Key? key, required this.data}) : super(key: key);

  @override
  State<TransactionReceipt> createState() => _TransactionReceiptState();
}

class _TransactionReceiptState extends State<TransactionReceipt> {
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

  String shopName = "";
  String address = "";
  String telphone = "";
  bool isLoading = true;
  fetchData() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');
    List<Map<String, dynamic>> profile = await DBHelperProfile.getItem(shopId);

    shopName = profile[0]['businessName'];
    address = profile[0]['businessAddress'];
    telphone = profile[0]['businessPhone'] == ''
        ? '-'
        : "${profile[0]['businessPhone']}";
    isLoading = false;
    setState(() {});
  }

  void _onItemTapped(int index) async {
    if (index == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Coming Soon"),
        ),
      );
    }
    if (index == 1) {
      final bytes = await capturePng();
      final dir = await getExternalStorageDirectory();
      String myPath = pt.dirname(pt.dirname(pt.dirname(pt.dirname(dir!.path))));
      myPath = '$myPath/PatoWave/receipt';
      Directory('$myPath/').create();
      final file = File('$myPath/receipt-${widget.data.receipt}.png');
      await file.writeAsBytes(bytes);
      // var imageId = await ImageDownloader.downloadImage(url);
      // var imageId = await ImageDownloader.downloadImage(dir.path);
      // var path = await ImageDownloader.findPath(imageId!);
      // ImageDownloader. ;
      await ImageDownloader.open(file.path);
    }
    if (index == 2) {
      final bytes = await capturePng();
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/receipt.png');
      await file.writeAsBytes(bytes);
      await Share.shareFiles([file.path], text: 'Receipt', subject: 'Receipt');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

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
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(height: 10),
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: Stack(
                        children: [
                          RepaintBoundary(
                            key: globalKey,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(0),
                                ),
                              ),
                              color: patowaveWhite,
                              elevation: 0,
                              child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: _myReceipt()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 10),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: patowavePrimary,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.print),
            label: 'Print',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Download',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Share',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  _myReceipt() {
    return Column(
      children: [
        Container(height: 20),
        widget.data.isCashSale
            ? const Text(
                "Cash Receipt",
                style: TextStyle(
                  color: patowaveBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              )
            : const Text(
                "Transaction Receipt",
                style: TextStyle(
                  color: patowaveBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
        Container(height: 10),
        Text(
          shopName,
          style: const TextStyle(
            color: patowaveBlack,
          ),
        ),
        Container(height: 10),
        const Divider(
          color: patowaveBlack,
          height: 10,
          thickness: 2,
        ),
        // Divider(color: patowaveBlack, height: 1),
        // const Text("=================================="),
        Container(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Address:",
              style: TextStyle(
                color: patowaveBlack,
              ),
            ),
            Text(
              address,
              style: const TextStyle(
                color: patowaveBlack,
              ),
            ),
          ],
        ),
        Container(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Tel:",
              style: TextStyle(
                color: patowaveBlack,
              ),
            ),
            Text(
              telphone,
              style: const TextStyle(
                color: patowaveBlack,
              ),
            ),
          ],
        ),
        Container(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Date:",
              style: TextStyle(
                color: patowaveBlack,
              ),
            ),
            Text(
              widget.data.getTimeString(),
              style: const TextStyle(
                color: patowaveBlack,
              ),
            ),
          ],
        ),
        Container(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Time:",
              style: TextStyle(
                color: patowaveBlack,
              ),
            ),
            Text(
              DateFormat('hh:mm a').format(widget.data.date),
              style: const TextStyle(
                color: patowaveBlack,
              ),
            ),
          ],
        ),
        widget.data.isPaymentIn ||
                widget.data.isPaymentOut ||
                widget.data.isCashSale ||
                widget.data.isPurchases ||
                widget.data.isExpenses
            ? Column(
                children: [
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.data.isPurchases || widget.data.isExpenses
                            ? "Bill No:"
                            : "Receipt No:",
                        style: const TextStyle(
                          color: patowaveBlack,
                        ),
                      ),
                      Container(width: 20),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.data.receipt,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: patowaveBlack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
        widget.data.isPaymentIn || widget.data.isPaymentOut
            // ||
            // widget.data.isExpenses
            ? Column(
                children: [
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Customer:",
                        style: TextStyle(
                          color: patowaveBlack,
                        ),
                      ),
                      Container(width: 20),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.data.getDescriptionName(),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: patowaveBlack,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
        Container(height: 10),
        // const Text("=================================="),
        const Divider(
          color: patowaveBlack,
          height: 10,
          thickness: 0.5,
        ),
        widget.data.isPaymentIn ||
                widget.data.isPaymentOut ||
                widget.data.isExpenses
            ? Column(
                children: [
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.data.getDescriptionDetails(),
                          style: const TextStyle(
                            color: patowaveBlack,
                          ),
                        ),
                      ),
                      Container(width: 10),
                      Text(
                        formatter.format(widget.data.amount),
                        style: const TextStyle(
                          color: patowaveBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
        // FOR PURCHASES AND CASH SALE ONLY
        widget.data.isPurchases || widget.data.isCashSale
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Items",
                    style: TextStyle(
                        color: patowaveBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  _listItemsButtomSheet(widget.data.details),
                ],
              )
            : Container(),
        Container(height: 10),
        // const Text("=================================="),
        const Divider(
          color: patowaveBlack,
          height: 10,
          thickness: 0.5,
        ),
        widget.data.isCashSale
            ? Column(
                children: [
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Amount",
                          style: TextStyle(
                            color: patowaveBlack,
                          ),
                        ),
                      ),
                      Container(width: 10),
                      Text(
                        formatter
                            .format(widget.data.amount + widget.data.discount),
                        style: const TextStyle(
                          color: patowaveBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
        widget.data.isCashSale
            ? Column(
                children: [
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Discount",
                          style: TextStyle(
                            color: patowaveBlack,
                          ),
                        ),
                      ),
                      Container(width: 10),
                      Text(
                        formatter.format(widget.data.discount),
                        style: const TextStyle(
                          color: patowaveBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
        widget.data.isPurchases
            ? Column(
                children: [
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "Balance Due",
                          style: TextStyle(
                            color: patowaveBlack,
                          ),
                        ),
                      ),
                      Container(width: 10),
                      Text(
                        formatter.format(widget.data.discount),
                        style: const TextStyle(
                          color: patowaveBlack,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
        Container(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "TOTAL:",
              style: TextStyle(
                color: patowaveBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              formatter.format(widget.data.amount),
              style: const TextStyle(
                color: patowaveBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // const Text("=================================="),
        Container(height: 10),
        const Divider(
          color: patowaveBlack,
          height: 10,
          thickness: 0.5,
        ),
        Container(height: 10),
        widget.data.isCashSale
            ? const Text(
                "Thank You For Your Purchases",
                style: TextStyle(
                  color: patowaveBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            : Container(),

        Container(height: 10),
        Center(
          child: QrImageView(
            data:
                "${widget.data.date}-${widget.data.amount}-${widget.data.details}",
            version: QrVersions.auto,
            size: 200.0,
            // embeddedImage: const AssetImage("assets/images/qr.png"),
            // embeddedImageStyle: QrEmbeddedImageStyle(color: Colors.white),
          ),
        ),
        Container(height: 20),
      ],
    );
  }

  _listItemsButtomSheet(List data) {
    List<TableRow> fData = [];
    for (var dx in data) {
      fData.add(
        TableRow(
          children: [
            Text(
              dx['product'],
              style: const TextStyle(color: patowaveBlack, fontSize: 12),
            ),
            Center(
              child: Text(
                "${dx['quantity']} ${dx['product_unit']} x ${(dx['price']).toInt()}",
                style: const TextStyle(color: patowaveBlack, fontSize: 12),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                formatter.format(dx['price'] * dx['quantity']),
                style: const TextStyle(color: patowaveBlack, fontSize: 12),
              ),
            ),
          ],
        ),
      );
    }
    return Table(children: fData);
  }
}
