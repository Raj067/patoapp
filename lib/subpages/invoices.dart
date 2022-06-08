import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/parties/invoiceDetails.dart';

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
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patoWhite,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView(
          children: [
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
              style: TextStyle(color: patoWhite),
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
                    style: TextStyle(fontSize: 20, color: patoBlue),
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
                    style: TextStyle(fontSize: 20, color: patoRed),
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
                    style: TextStyle(fontSize: 20, color: patoWarning),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
