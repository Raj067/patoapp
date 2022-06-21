import 'package:flutter/material.dart';
import 'package:patoapp/parties/invoiceDetails.dart';
import 'package:patoapp/themes/lightTheme.dart';

class MainInvoicePage extends StatelessWidget {
  const MainInvoicePage({Key? key}) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            Container(height: 10),
            _invoiceHeader(),
            const InvoiceDetails(),
          ],
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(
              "Create New Invoice",
              style: TextStyle(color: patowaveWhite),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _invoiceHeader() => Row(
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
                  const Text(
                    "1",
                    style: TextStyle(fontSize: 20, color: patowaveGreen),
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
                  const Text(
                    "1",
                    style: TextStyle(fontSize: 20, color: patowaveErrorRed),
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
                  const Text("Unpaid"),
                  Container(
                    height: 10,
                  ),
                  const Text(
                    "1",
                    style: TextStyle(fontSize: 20, color: patowaveWarning),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
