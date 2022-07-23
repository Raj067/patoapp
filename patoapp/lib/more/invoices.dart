import 'package:flutter/material.dart';
import 'package:patoapp/invoices/create_invoice.dart';
import 'package:patoapp/invoices/preview_invoice.dart';
import 'package:patoapp/themes/light_theme.dart';

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
            TextButton(
              onPressed: () {
                // PreviewInvoice
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => PreviewInvoice(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Text("sample invoice"),
            ),
            // const InvoiceDetails(),
          ],
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
