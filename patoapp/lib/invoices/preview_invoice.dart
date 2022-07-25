// import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:patoapp/data/customer_list.dart';
import 'package:patoapp/themes/light_theme.dart';
// import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// ignore: must_be_immutable
class PreviewInvoice extends StatefulWidget {
  // SingleCustomer customer;
  const PreviewInvoice({
    Key? key,
    // required this.customer,
  }) : super(key: key);
  @override
  State<PreviewInvoice> createState() => _PreviewInvoiceState();
}

class _PreviewInvoiceState extends State<PreviewInvoice> {
  // final List _myColors = [Colors.green, Colors.red, Colors.blue];
  final pdf = pw.Document();
  // Future<Uint8List> _generatePdf() async {
  //   pdf.addPage(
  //     pw.Page(
  //       // pageFormat: format,
  //       build: (context) => pw.Placeholder(),
  //     ),
  //   );

  //   return pdf.save();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text(
        //   'Feedback',
        //   style: TextStyle(color: Colors.white),
        // ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patowaveWhite,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.settings,
              color: patowaveWhite,
            ),
          ),
        ],
      ),
      // body: PDFView(filePath: ,),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: patowavePrimary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.print),
            label: 'Print',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Delete',
          ),
        ],
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        // onTap: _onItemTapped,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
