import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_invoices.dart';
import 'package:patoapp/backend/models/invoice_model.dart';
import 'package:patoapp/backend/sync/sync_invoice.dart';
import 'package:patoapp/invoices/create_invoice.dart';
import 'package:patoapp/invoices/preview_invoice.dart';
import 'package:patoapp/themes/light_theme.dart';

class MainInvoicePage extends StatefulWidget {
  const MainInvoicePage({Key? key}) : super(key: key);

  @override
  State<MainInvoicePage> createState() => _MainInvoicePageState();
}

class _MainInvoicePageState extends State<MainInvoicePage> {
  List<SingleInvoice> myCustomData = [];
  int outstandings = 0;
  int overdue = 0;
  fetchInvoiceDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> invoice = await DBHelperInvoice.query();
    List<SingleInvoice> finalData = [];
    for (Map<String, dynamic> e in invoice) {
      if (e['shopId'] == shopId) {
        finalData.add(fromJsonInvoice(e));
      }
    }
    myCustomData = finalData;
    setState(() {});
  }

  refreshDataDB() async {
    SyncInvoice syncInvoice = SyncInvoice();
    await syncInvoice.fetchData();
    fetchInvoiceDB();
  }

  @override
  void initState() {
    super.initState();
    fetchInvoiceDB();
    refreshDataDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Invoices',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              Container(height: 10),
              _invoiceHeader(),
              _invoices(),
            ],
          ),
        ),
      ),
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
                      builder: (BuildContext context) =>
                          const CreateNewInvoice(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: const Text(
                  "Create New Invoice",
                  style: TextStyle(color: patowaveWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _invoices() {
    List<Widget> data = [];
    for (SingleInvoice dx in myCustomData) {
      outstandings += 1;
      overdue += 1;
      data.add(Card(
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
                        dx.dueDate,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Text(
                        "Invoice #${dx.invoiceNo}",
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
                    color: patowaveWarning.withAlpha(50),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'ISSUED',
                      style: TextStyle(
                          color: patowaveWarning,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
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
                          builder: (BuildContext context) =>
                              const PreviewInvoice(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: const Text("VIEW DETAILS",
                        style: TextStyle(fontSize: 12)),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Tsh ",
                          style: TextStyle(fontSize: 12, color: patowaveGreen),
                        ),
                        Text(
                          "${dx.amountReceived}",
                          style: const TextStyle(
                              fontSize: 17, color: patowaveGreen),
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
    return Column(children: data);
  }

  _invoiceHeader() => Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 100,
              child: Card(
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
                    const Text("Outstanding"),
                    Container(
                      height: 10,
                    ),
                    Text(
                      "$outstandings",
                      style:
                          const TextStyle(fontSize: 20, color: patowaveGreen),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 100,
              child: Card(
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
                    const Text("Overdue"),
                    Container(
                      height: 10,
                    ),
                    Text(
                      "$overdue",
                      style: const TextStyle(
                          fontSize: 20, color: patowaveErrorRed),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
}
