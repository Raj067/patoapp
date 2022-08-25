// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/invoice_controller.dart';
// import 'package:patoapp/backend/db/db_invoices.dart';
// import 'package:patoapp/backend/models/invoice_model.dart';
// import 'package:patoapp/backend/sync/sync_invoice.dart';
import 'package:patoapp/invoices/create_invoice.dart';
import 'package:patoapp/invoices/preview_invoice.dart';
import 'package:patoapp/themes/light_theme.dart';
// import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainInvoicePage extends StatefulWidget {
  const MainInvoicePage({Key? key}) : super(key: key);

  @override
  State<MainInvoicePage> createState() => _MainInvoicePageState();
}

class _MainInvoicePageState extends State<MainInvoicePage> {
  // List<SingleInvoice> myCustomData = [];
  // int outstanding = 0;
  // int overdue = 0;
  // double totalOutstanding = 0;
  // double totalOverdue = 0;
  // double totalUnpaidInvoice = 0;
  // final InvoiceController _invoiceController = Get.put(InvoiceController());

  // fetchInvoiceDB() async {
  //   // shop ID
  //   String? activeShop = await storage.read(key: 'activeShop');
  //   int shopId = int.parse(activeShop ?? '0');
  //   List<Map<String, dynamic>> invoice = await DBHelperInvoice.query();
  //   List<SingleInvoice> finalData = [];
  //   for (Map<String, dynamic> e in invoice) {
  //     if (e['shopId'] == shopId) {
  //       finalData.add(fromJsonInvoice(e));
  //     }
  //   }
  //   myCustomData = finalData;
  //   setState(() {});
  // }
  // refreshDataDB() async {
  //   SyncInvoice syncInvoice = SyncInvoice();
  //   await syncInvoice.fetchData();
  //   fetchInvoiceDB();
  // }

  @override
  void initState() {
    super.initState();
    // fetchInvoiceDB();
    // refreshDataDB();
    // outstanding = 1;
    // overdue = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.invoices,
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
      body: GetBuilder<InvoiceController>(builder: (controller) {
        int outstanding = 0;
        int overdue = 0;
        double totalOutstanding = 0;
        double totalOverdue = 0;
        double totalUnpaidInvoice = 0;
        List<Widget> myData = [
          Container(height: 10),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Text(
                      "${AppLocalizations.of(context)!.totalUnpaidInvoice} Tsh ${formatter.format(totalUnpaidInvoice)}"),
                ),
                // LinearPercentIndicator(
                //   percent: outstanding / (outstanding + overdue),
                //   backgroundColor: patowaveErrorRed,
                //   progressColor: patowaveWarning,
                //   lineHeight: 10,
                //   barRadius: const Radius.circular(5),
                //   curve: Curves.easeInCirc,
                // ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(100),
                      borderRadius: BorderRadius.circular(5),
                      gradient: const LinearGradient(
                        colors: [
                          patowaveWarning,
                          patowaveErrorRed,
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Table(
                    border: TableBorder(
                      top: BorderSide(
                        color: Colors.grey.withAlpha(100),
                        width: 0.5,
                      ),
                      verticalInside: BorderSide(
                        color: Colors.grey.withAlpha(100),
                        width: 0.5,
                      ),
                    ),
                    children: [
                      TableRow(children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.outstanding,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: patowaveWarning,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "Tsh: ${formatter.format(totalOutstanding)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Column(
                            children: [
                              Text(
                                AppLocalizations.of(context)!.overdue,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: patowaveErrorRed,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "Tsh: ${formatter.format(totalOverdue)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // _invoices(),
        ];
        for (var dx in controller.allInvoice) {
          DateTime dueDate = DateTime.parse(dx.dueDate);
          bool isOutStanding = dueDate.isBefore(DateTime.now()) ? false : true;

          if (isOutStanding) {
            outstanding += 1;
            totalOutstanding += dx.totalAmount - dx.amountReceived;
          } else {
            overdue += 1;
            totalOverdue += dx.totalAmount - dx.amountReceived;
          }
          totalUnpaidInvoice += dx.totalAmount - dx.amountReceived;

          myData.add(Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('d-MMM-yyy')
                                .format(DateTime.parse(dx.dueDate)),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            "${AppLocalizations.of(context)!.invoices} #${dx.invoiceNo}",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            dx.fullName,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: isOutStanding
                            ? patowaveWarning.withAlpha(50)
                            : patowaveErrorRed.withAlpha(50),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isOutStanding
                              ? AppLocalizations.of(context)!.outstanding
                              : AppLocalizations.of(context)!.overdue,
                          style: TextStyle(
                            color: isOutStanding
                                ? patowaveWarning
                                : patowaveErrorRed,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
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
                          // PreviewInvoice
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => PreviewInvoice(
                                invoice: dx,
                              ),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.viewDetails,
                            style: TextStyle(
                              fontSize: 12,
                              color: isOutStanding
                                  ? patowaveWarning
                                  : patowaveErrorRed,
                            )),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Tsh ",
                              style: TextStyle(
                                fontSize: 12,
                                color: isOutStanding
                                    ? patowaveWarning
                                    : patowaveErrorRed,
                              ),
                            ),
                            Text(
                              formatter
                                  .format(dx.totalAmount - dx.amountReceived),
                              style: TextStyle(
                                fontSize: 17,
                                color: isOutStanding
                                    ? patowaveWarning
                                    : patowaveErrorRed,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            return myData[index];
          },
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          itemCount: myData.length,
        );
      }),

      // SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      //     child: Column(
      //       children: [
      //         Container(height: 10),
      //         _invoiceHeader(),
      //         _invoices(),
      //       ],
      //     ),
      //   ),
      // ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  // MaterialStateProperty<Color?>? backgroundColor,
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
                  // CreateNewInvoice

                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => CreateNewInvoice(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.createNewInvoice,
                  style: const TextStyle(color: patowaveWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
