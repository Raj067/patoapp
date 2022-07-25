// ignore: file_names
import 'dart:async';
import 'dart:convert';
// import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/data/business_financial_data.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:http/http.dart' as http;

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
    // RenderRepaintBoundary boundary =
    //     globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    //Convert to the image
    // final ui.Image image = await boundary.toImage();
  }

  String shopName = "";
  String address = "";
  String telphone = "";
  bool isLoading = true;
  fetchData(String path) async {
    String accessToken = await storage.read(key: 'access') ?? "";
    var data = await http.get(
      Uri.parse(baseUrl + path),
      headers: getAuthHeaders(accessToken),
    );
    shopName = jsonDecode(data.body)['name'];
    address = jsonDecode(data.body)['address'];
    telphone = jsonDecode(data.body)['phone'];
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData("api/shop-profile-details/");
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
      body:
          // PdfPreview(
          //   build: (format) => _generatePdf(format, 'hello world'),
          // ),
          isLoading
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
                              child: _myReceipt()),
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

  _myReceipt() {
    return Column(
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
            Text(DateFormat('hh:mm a').format(widget.data.date)),
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
                      Text(widget.data.isPurchases || widget.data.isExpenses
                          ? "Bill No:"
                          : "Receipt No:"),
                      Container(width: 20),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.data.receipt,
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : Container(),
        widget.data.isPaymentIn ||
                widget.data.isPaymentOut ||
                widget.data.isExpenses
            ? Column(
                children: [
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Customer:"),
                      Container(width: 20),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            widget.data.getDescriptionName(),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(widget.data.getDescriptionDetails()),
                      ),
                      Container(width: 10),
                      Text(formatter.format(widget.data.amount)),
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
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  _listItemsButtomSheet(widget.data.details),
                ],
              )
            : Container(),
        Container(height: 10),
        const Text("=================================="),

        widget.data.isCashSale
            ? Column(
                children: [
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text("Amount"),
                      ),
                      Container(width: 10),
                      Text(
                        formatter
                            .format(widget.data.amount + widget.data.discount),
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
                        child: Text("Discount"),
                      ),
                      Container(width: 10),
                      Text(formatter.format(widget.data.discount)),
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
          child: QrImageView(
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
              style: const TextStyle(fontSize: 12),
            ),
            Center(
              child: Text(
                "${dx['quantity']} ${dx['product_unit']} x ${dx['price'] / dx['quantity']}",
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                formatter.format(dx['price']),
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      );
    }
    return Table(children: fData);
  }
}
