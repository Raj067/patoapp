// import 'dart:typed_data';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patoapp/invoices/api_invoice.dart';
// import 'package:patoapp/data/customer_list.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:pdf/pdf.dart' as p;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdfx/pdfx.dart';
// import 'package:url_launcher/url_launcher.dart';

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
  int selectedColor = 0;
  final pdfPinchController = PdfControllerPinch(
    document: PdfDocument.openData(pw.Document().save()),
  );
  final pdf = pw.Document();

  final tableHeaders = [
    'Item',
    'Price',
    'Quantity',
    'Total',
  ];

  final tableData = [
    [
      'Coffee',
      '7',
      '\$ 5',
      '\$ 35',
    ],
    [
      'Blue Berries',
      '5',
      '\$ 10',
      '\$ 50',
    ],
    [
      'Water',
      '1',
      '\$ 3',
      '1.5 %',
    ],
    [
      'Apple',
      '6',
      '\$ 8',
      '\$ 48',
    ],
    [
      'Lunch',
      '3',
      '\$ 90',
      '12 %',
    ],
    [
      'Drinks',
      '2',
      '\$ 15',
      '\$ 30',
    ],
    [
      'Lemon',
      '4',
      '\$ 7',
      '\$ 28',
    ],
  ];
  // final iconImage =
  //     (await rootBundle.load('assets/icon/icon.png')).buffer.asUint8List();

  Future<Uint8List> _generatePdf() async {
    p.PdfColor selectedColorInvoice = p.PdfColor.fromHex('33796FFF');

    pdf.addPage(
      pw.MultiPage(
        header: (context) {
          return pw.Text(
            'Flutter Approach',
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 15.0,
            ),
          );
        },
        build: (context) {
          return [
            pw.Row(
              children: [
                // pw.Image(
                //   pw.MemoryImage(iconImage),
                //   height: 72,
                //   width: 72,
                // ),
                pw.SizedBox(width: 1 * p.PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'INVOICE',
                      style: pw.TextStyle(
                        fontSize: 17.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'Flutter Approach',
                      style: const pw.TextStyle(
                        fontSize: 15.0,
                        color: p.PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'John Doe',
                      style: pw.TextStyle(
                        fontSize: 15.5,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'john@gmail.com',
                    ),
                    pw.Text(
                      DateTime.now().toString(),
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 5 * p.PdfPageFormat.mm),
            pw.Row(
              children: [
                pw.Expanded(
                  child: pw.Container(
                    color: selectedColorInvoice,
                    height: 8 * p.PdfPageFormat.mm,
                  ),
                ),
                pw.Text('  INVOICE  ',
                    style: pw.TextStyle(
                      color: selectedColorInvoice,
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    )),
                pw.Container(
                  color: selectedColorInvoice,
                  height: 8 * p.PdfPageFormat.mm,
                  width: 50 * p.PdfPageFormat.mm,
                ),
              ],
            ),

            pw.SizedBox(height: 5 * p.PdfPageFormat.mm),
            //
            pw.Row(
              children: [
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Invoice To',
                      style: pw.TextStyle(
                        fontSize: 15.5,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text('Anitha Lucas'),
                    pw.Text('Dar es salaam'),
                    pw.Text('0679190720'),
                    pw.Text('sample@patowave.com'),
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(children: [
                      pw.Text(
                        'Invoice No: ',
                        style: pw.TextStyle(
                          // fontSize: 15.5,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text('12345'),
                    ]),
                    pw.Row(children: [
                      pw.Text(
                        'Issued Date: ',
                        style: pw.TextStyle(
                          // fontSize: 15.5,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text('12345'),
                    ]),
                    pw.Row(children: [
                      pw.Text(
                        'Due Date: ',
                        style: pw.TextStyle(
                          // fontSize: 15.5,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.Text('12345'),
                    ]),
                  ],
                ),
              ],
            ),
            //

            pw.SizedBox(height: 5 * p.PdfPageFormat.mm),

            ///
            /// PDF Table Create
            ///
            pw.Table.fromTextArray(
              headers: tableHeaders,
              data: tableData,
              border: null,
              headerStyle: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                color: p.PdfColors.white,
              ),
              headerDecoration: pw.BoxDecoration(
                color: selectedColorInvoice,
              ),
              cellHeight: 30.0,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerRight,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
              },
            ),
            pw.Divider(
              color: p.PdfColors.grey400,
            ),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Sub Total',
                              ),
                            ),
                            pw.Text(
                              '\$ 464',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text('Discount'),
                            ),
                            pw.Text(
                              '\$ 90.48',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'TAX',
                              ),
                            ),
                            pw.Text(
                              '\$ 464',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        pw.Row(
                          children: [
                            pw.Expanded(
                              child: pw.Text(
                                'Paid',
                              ),
                            ),
                            pw.Text(
                              '\$ 90.48',
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // pw.Divider(),
                        pw.SizedBox(height: 1 * p.PdfPageFormat.mm),
                        pw.Container(
                          color: selectedColorInvoice,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(10),
                            child: pw.Row(
                              children: [
                                pw.Expanded(
                                  child: pw.Text(
                                    'Balnce due',
                                    style: pw.TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: pw.FontWeight.bold,
                                      color: p.PdfColors.white,
                                    ),
                                  ),
                                ),
                                pw.Text(
                                  '\$ 554.48',
                                  style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    color: p.PdfColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        footer: (context) {
          return pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Divider(),
              pw.SizedBox(height: 2 * p.PdfPageFormat.mm),
              pw.Text(
                'Powered by PatoWave',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 1 * p.PdfPageFormat.mm),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    'Email: info@patowave.com, ',
                  ),
                  pw.Text(
                    'Website: www.patowave.com',
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

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
      body: PdfViewPinch(
        controller: PdfControllerPinch(
          document: PdfDocument.openData(_generatePdf()),
        ),
      ),
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
