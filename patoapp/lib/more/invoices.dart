import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/invoices/create_invoice.dart';
import 'package:patoapp/invoices/preview_invoice.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:http/http.dart' as http;

class MainInvoicePage extends StatefulWidget {
  const MainInvoicePage({Key? key}) : super(key: key);

  @override
  State<MainInvoicePage> createState() => _MainInvoicePageState();
}

class _MainInvoicePageState extends State<MainInvoicePage> {
  fetchData() async {
    String accessToken = await storage.read(key: 'access') ?? "";
    var myData = await http.get(
      Uri.parse(
        "${baseUrl}api/all-invoices/",
      ),
      headers: getAuthHeaders(accessToken),
    );
    if (myData.statusCode == 200) {
      for (var element in jsonDecode(myData.body)) {
        print(element);
      }
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
              TextButton(
                onPressed: () {
                  // PreviewInvoice
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const PreviewInvoice(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: const Text("sample invoice"),
              ),
              // const InvoiceDetails(),
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
      ],
    );
