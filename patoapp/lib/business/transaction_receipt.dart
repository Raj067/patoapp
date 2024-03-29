// ignore: file_names
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patoapp/backend/controllers/profile_controller.dart';
// import 'package:patoapp/backend/db/db_profile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'dart:ui' as ui;
import 'package:image_downloader/image_downloader.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path/path.dart' as pt;
import 'package:permission_handler/permission_handler.dart';
import 'package:patoapp/animations/permission.dart';

class TransactionReceipt extends StatefulWidget {
  final FinancialData data;
  const TransactionReceipt({Key? key, required this.data}) : super(key: key);

  @override
  State<TransactionReceipt> createState() => _TransactionReceiptState();
}

class _TransactionReceiptState extends State<TransactionReceipt> {
  final GlobalKey globalKey = GlobalKey();

  final ProfileController _profileController = Get.put(ProfileController());

  Future<Uint8List> capturePng() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 5);
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    return pngBytes;
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
        final bytes = await capturePng();
        final dir = await getExternalStorageDirectory();
        String myPath =
            pt.dirname(pt.dirname(pt.dirname(pt.dirname(dir!.path))));
        myPath = '$myPath/PatoWave/Receipt';
        Directory('$myPath/').create();
        final file = File('$myPath/Receipt-${widget.data.receipt}.png');
        await file.writeAsBytes(bytes);
        await ImageDownloader.open(file.path);
      } else {
        // ignore: use_build_context_synchronously
        permissionDenied(context);
      }
    }
    if (index == 2) {
      final bytes = await capturePng();
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/receipt.png');
      await file.writeAsBytes(bytes);
      await Share.shareFiles([file.path], text: 'Receipt', subject: 'Receipt');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.transactionReceipt,
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
      body: SingleChildScrollView(
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
        backgroundColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.print),
            label: AppLocalizations.of(context)!.print,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.download),
            label: AppLocalizations.of(context)!.download,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.share),
            label: AppLocalizations.of(context)!.share,
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
          _profileController.myProfile.value.businessName,
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
              _profileController.myProfile.value.businessAddress,
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
              _profileController.myProfile.value.businessPhone,
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
        widget.data.isCashSale
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
                            widget.data.getDescriptionName() == 'Cash Sales'
                                ? '-'
                                : widget.data.getDescriptionName(),
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
                "Thanks For Your Purchase",
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
            data: "${widget.data.date}-${widget.data.id}",
            version: QrVersions.auto,
            size: 200.0,
            embeddedImage: const AssetImage("assets/images/qrImage.png"),
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
