import 'dart:convert';
import 'dart:io';
// import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_customer.dart';
import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/backend/models/invoice_model.dart';
import 'package:patoapp/backend/models/profile_details.dart';
import 'package:patoapp/invoices/edit_invoice.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:pdf/pdf.dart' as p;
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';
import 'package:path/path.dart' as pt;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PreviewInvoice extends StatefulWidget {
  final SingleInvoice invoice;
  final Function resetData;
  const PreviewInvoice({
    Key? key,
    required this.invoice,
    required this.resetData,
  }) : super(key: key);
  @override
  State<PreviewInvoice> createState() => _PreviewInvoiceState();
}

class _PreviewInvoiceState extends State<PreviewInvoice> {
  final tableHeaders = [
    'Item',
    'Price',
    'Quantity',
    'Total',
  ];

  List<List> tableData = [];
  ProfileData? myProfile;
  SingleCustomer? myCustomer;
  int profilePercent = 20;

  double subTotal = 0;
  double discount = 0;
  double tax = 0;
  double paid = 0;
  double balanceDue = 0;
  List<TableRow> myRowData = [];

  fetchProfileDB() async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    List<Map<String, dynamic>> profile = await DBHelperProfile.query();
    myProfile = fromJsonProfile(
      profile.firstWhere((element) => element['id'] == shopId),
    );
    List<Map<String, dynamic>> customers = await DBHelperCustomer.query();
    List<SingleCustomer> finalData = [];

    for (Map<String, dynamic> e in customers) {
      if (e['shopId'] == shopId) {
        finalData.add(fromJsonCustomer(e));
      }
    }
    myCustomer = finalData.firstWhere((e) => e.id == widget.invoice.customerId);
    setState(() {});
  }

  Future<Uint8List> _generatePdf() async {
    // final iconImage =
    //     (await rootBundle.load('assets/icon/icon.png')).buffer.asUint8List();
    // CachedNetworkImageProvider(
    //   myProfile!.businessLogo,
    // ).load(key, (bytes, {allowUpscaling, cacheHeight, cacheWidth}) => null);
    // Image(
    //     image: CachedNetworkImageProvider(
    //   myProfile!.businessLogo,
    // ));

    final pdf = pw.Document();
    p.PdfColor selectedColorInvoice = p.PdfColor.fromHex('33796FFF');

    pdf.addPage(
      pw.MultiPage(
        // header: (context) {
        //   return pw.Text(
        //     myProfile!.businessName,
        //     style: pw.TextStyle(
        //       fontWeight: pw.FontWeight.bold,
        //       fontSize: 15.0,
        //     ),
        //   );
        // },
        build: (context) {
          return [
            pw.Row(
              children: [
                // pw.Image(
                //   pw.MemoryImage(iconImage),
                //   height: 72,
                //   width: 72,
                // ),

                pw.Container(
                  width: 50,
                  height: 50,
                  decoration: pw.BoxDecoration(
                    color: selectedColorInvoice,
                    borderRadius: pw.BorderRadius.circular(15),
                  ),
                  child: pw.Center(
                    child: pw.Text(
                      myProfile!.businessName.toUpperCase()[0],
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 30,
                        color: p.PdfColors.white,
                      ),
                    ),
                  ),
                ),

                pw.SizedBox(width: 1 * p.PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      myProfile!.businessName,
                      style: pw.TextStyle(
                        fontSize: 16.0,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      myProfile!.businessSlogan,
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
                      myProfile!.businessName,
                      style: pw.TextStyle(
                        fontSize: 15.5,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      myProfile!.businessAddress,
                    ),
                    pw.Text(myProfile!.businessPhone),
                    pw.Text(
                      myProfile!.businessEmail,
                    ),
                    pw.Text(
                      DateFormat('d-MMM-yyy').format(DateTime.now()),
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
                    pw.Text(widget.invoice.fullName),
                    pw.Text(myCustomer == null ? "" : myCustomer!.address),
                    pw.Text(myCustomer == null ? "" : myCustomer!.phoneNumber),
                    pw.Text(myCustomer == null ? "" : myCustomer!.email),
                  ],
                ),
                pw.Spacer(),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Invoice No:',
                            style: pw.TextStyle(
                              // fontSize: 15.5,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(widget.invoice.invoiceNo),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Issued Date: ',
                            style: pw.TextStyle(
                              // fontSize: 15.5,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            DateFormat('d-M-yyy').format(DateTime.now()),
                          ),
                        ]),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text(
                            'Due Date: ',
                            style: pw.TextStyle(
                              // fontSize: 15.5,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.Text(
                            DateFormat('d-M-yyy')
                                .format(DateTime.parse(widget.invoice.dueDate)),
                          ),
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
                              'Tsh ${formatter.format(subTotal.toInt())}',
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
                              'Tsh ${formatter.format(discount.toInt())}',
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
                              'Tsh ${formatter.format(tax.toInt())}',
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
                              'Tsh ${formatter.format(paid.toInt())}',
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
                                  'Tsh ${formatter.format(balanceDue.toInt())}',
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

  void _onItemTapped(int index) async {
    if (index == 0) {
      await Printing.layoutPdf(
          onLayout: (p.PdfPageFormat format) async => await _generatePdf());
    }
    if (index == 1) {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EditInvoice(
            invoice: widget.invoice,
            resetData: () {
              widget.resetData();
            },
          ),
          fullscreenDialog: true,
        ),
      );
    }
    if (index == 2) {
      // api/delete-invoices/
      String accessToken = await storage.read(key: 'access') ?? "";
      showPleaseWait(
        context: context,
        builder: (context) => const ModalFit(),
      );
      try {
        final response = await http.post(
          Uri.parse('${baseUrl}api/delete-invoices/'),
          headers: getAuthHeaders(accessToken),
          body: jsonEncode(<String, dynamic>{
            'id': widget.invoice.id,
          }),
        );

        if (response.statusCode == 201) {
          await widget.resetData();
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          showErrorMessage(
            context: context,
            builder: (context) => const ModalFitError(),
          );
          // throw Exception('Failed to updated customer.');
        }
      } catch (e) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        showTimeOutMessage(
          context: context,
          builder: (context) => const ModalFitTimeOut(),
        );
      }
    }
    if (index == 3) {
      await Printing.sharePdf(
        bytes: await _generatePdf(),
        filename: 'invoice-${widget.invoice.invoiceNo}.pdf',
      );
    }
  }

  @override
  void initState() {
    fetchProfileDB();
    tableData = widget.invoice.items
        .map((e) => [
              e['product'],
              "Tsh ${e['price']}",
              "${e['quantity']} ${e['product_unit']}",
              "Tsh ${formatter.format(e['price'] * e['quantity'])}",
            ])
        .toList();
    myRowData.add(const TableRow(children: [
      Text(
        'Item',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      Text(
        'Price',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      Text(
        'Quantity',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
      Text(
        'Total',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    ]));
    for (List e in tableData) {
      myRowData.add(TableRow(children: [
        Text(
          e[0],
          style: const TextStyle(fontSize: 12),
        ),
        Text(
          e[1],
          style: const TextStyle(fontSize: 12),
        ),
        Text(
          e[2],
          style: const TextStyle(fontSize: 12),
        ),
        Text(
          e[3],
          style: const TextStyle(fontSize: 12),
        ),
      ]));
    }

    subTotal = widget.invoice.totalAmount.toDouble();
    discount = widget.invoice.discount.toDouble();
    tax = 0;
    paid = widget.invoice.amountReceived.toDouble();
    balanceDue = widget.invoice.totalAmount.toDouble() -
        widget.invoice.amountReceived.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text(
        //   'Invoice',
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
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
              color: patowaveWhite,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: patowavePrimary.withAlpha(50),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Invoice #${widget.invoice.invoiceNo}: ${widget.invoice.fullName}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                  'Due in ${DateFormat('EEE d MMMM, yyy').format(DateTime.parse(widget.invoice.dueDate))}'),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Invoice To',
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.invoice.fullName),
                    Text(myCustomer == null ? "" : myCustomer!.address),
                    Text(myCustomer == null ? "" : myCustomer!.phoneNumber),
                    Text(myCustomer == null ? "" : myCustomer!.email),
                  ],
                ),
              ),
              const Divider(height: 0),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Invoice Details',
                      style: TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Invoice No:',
                            style: TextStyle(),
                          ),
                          Text(widget.invoice.invoiceNo),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Issued Date: '),
                          Text(
                            DateFormat('d-M-yyy').format(DateTime.now()),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Due Date: '),
                          Text(
                            DateFormat('d-M-yyy')
                                .format(DateTime.parse(widget.invoice.dueDate)),
                          ),
                        ]),
                  ],
                ),
              ),
              const Divider(height: 0),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Table(children: myRowData),
              ),
              Container(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bytes = await _generatePdf();
          final dir = await getExternalStorageDirectory();
          String myPath =
              pt.dirname(pt.dirname(pt.dirname(pt.dirname(dir!.path))));
          myPath = '$myPath/PatoWave/invoice';
          Directory('$myPath/').create();
          final file = File('$myPath/invoice-${widget.invoice.invoiceNo}.pdf');
          await file.writeAsBytes(bytes);
          await ImageDownloader.open(file.path);
        },
        child: const Icon(Icons.download),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: patowavePrimary,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.print),
            label: AppLocalizations.of(context)!.print,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.edit),
            label: AppLocalizations.of(context)!.edit,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.delete),
            label: AppLocalizations.of(context)!.delete,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.share),
            label: AppLocalizations.of(context)!.share,
          ),
        ],
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
