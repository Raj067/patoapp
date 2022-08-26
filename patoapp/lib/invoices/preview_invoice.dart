import 'dart:convert';
import 'dart:io';
// import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_downloader/image_downloader.dart';
// import 'package:image_downloader/image_downloader.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/business_controller.dart';
import 'package:patoapp/backend/controllers/customers_controller.dart';
import 'package:patoapp/backend/controllers/invoice_controller.dart';
import 'package:patoapp/backend/controllers/profile_controller.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
// import 'package:patoapp/backend/db/db_customer.dart';
// import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/backend/models/invoice_model.dart';
import 'package:patoapp/backend/models/profile_details.dart';
import 'package:patoapp/invoices/edit_invoice.dart';
import 'package:patoapp/parties/add_payment_customer.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:pdf/pdf.dart' as p;
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';
import 'package:path/path.dart' as pt;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PreviewInvoice extends StatefulWidget {
  final SingleInvoice invoice;
  const PreviewInvoice({Key? key, required this.invoice}) : super(key: key);
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
  final InvoiceController _invoiceController = Get.put(InvoiceController());

  final BusinessController _businessController = Get.put(BusinessController());
  final CustomerController _customerController = Get.put(CustomerController());
  final ProfileController _profileController = Get.put(ProfileController());

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

  fetchProfileDB() {
    myProfile = _profileController.myProfile.value;
    myCustomer = _customerController.allCustomers
        .firstWhere((e) => e.id == widget.invoice.customerId);
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
                  width: 60,
                  height: 60,
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

                pw.SizedBox(width: 3 * p.PdfPageFormat.mm),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      myProfile!.businessName,
                      style: pw.TextStyle(
                        fontSize: 16,
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

                pw.Spacer(),
                // pw.Column(
                //   mainAxisSize: pw.MainAxisSize.min,
                //   crossAxisAlignment: pw.CrossAxisAlignment.start,
                //   children: [
                //     pw.Text(
                //       myProfile!.businessName,
                //       style: pw.TextStyle(
                //         fontSize: 15.5,
                //         fontWeight: pw.FontWeight.bold,
                //       ),
                //     ),
                //     pw.Text(
                //       myProfile!.businessAddress,
                //     ),
                //     pw.Text(myProfile!.businessPhone),
                //     pw.Text(
                //       myProfile!.businessEmail,
                //     ),
                //     pw.Text(
                //       DateFormat('d-MMM-yyy').format(DateTime.now()),
                //     ),
                //   ],
                // ),
                pw.BarcodeWidget(
                  height: 60,
                  width: 60,
                  barcode: pw.Barcode.qrCode(),
                  data: widget.invoice.invoiceNo,
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
                      ],
                    ),
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
                      ],
                    ),
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
                      ],
                    ),
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
                  // pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 6,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Notes:',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text('Thanks for your business'),
                      ],
                    ),
                  ),
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

            // pw.Container(
            //     // alignment: pw.Alignment.centerRight,
            //     child: pw.Row(children: [
            //   pw.Expanded(
            //     flex: 6,
            //     child: pw.Column(
            //       crossAxisAlignment: pw.CrossAxisAlignment.start,
            //       children: [
            //         pw.Text(
            //           'Payment Method:',
            //           style: pw.TextStyle(
            //             fontWeight: pw.FontWeight.bold,
            //           ),
            //         ),
            //         pw.Text('Payment description 1'),
            //         pw.Text('Payment description 2'),
            //         pw.Text('Payment description 3'),
            //         pw.Text('Payment description 4'),
            //       ],
            //     ),
            //   ),
            //   pw.Expanded(
            //     flex: 4,
            //     child: pw.Column(
            //       crossAxisAlignment: pw.CrossAxisAlignment.start,
            //       children: [
            //         pw.Text(
            //           'Signature',
            //           style: pw.TextStyle(
            //             fontWeight: pw.FontWeight.bold,
            //           ),
            //         ),
            //         // pw.Text('Thanks for your business'),
            //       ],
            //     ),
            //   ),
            // ])),
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
          _invoiceController.invoiceChangeDelete(widget.invoice);
          FinancialData val = _businessController.allFinancialData.firstWhere(
              (element) => element.id == "invoice-${widget.invoice.id}");
          _businessController.businessChangeDelete(val);

          // Update customer
          SingleCustomer myDataCustomer = _customerController.allCustomers
              .firstWhere((element) => element.id == widget.invoice.customerId);

          myDataCustomer.amount +=
              widget.invoice.totalAmount - widget.invoice.amountReceived;

          // myDataCustomer.financialData = [
          //   payment,
          //   ...myDataCustomer.financialData
          // ];
          _customerController.customerChangeUpdater(myDataCustomer);
          Get.back();
          Get.back();
        } else {
          Get.back();
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
        filename: 'Invoice-${widget.invoice.invoiceNo}.pdf',
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
        backgroundColor: Theme.of(context).primaryColor,
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
            onPressed: () async {
              final bytes = await _generatePdf();
              final dir = await getExternalStorageDirectory();
              String myPath =
                  pt.dirname(pt.dirname(pt.dirname(pt.dirname(dir!.path))));
              myPath = '$myPath/PatoWave/Invoice';
              Directory('$myPath/').create();
              final file =
                  File('$myPath/Invoice-${widget.invoice.invoiceNo}.pdf');
              await file.writeAsBytes(bytes);
              await ImageDownloader.open(file.path);
            },
            icon: const Icon(
              Icons.download,
              color: patowaveWhite,
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Coming Soon"),
                ),
              );
            },
            icon: const Icon(
              Icons.settings,
              color: patowaveWhite,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
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
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Due in ${DateFormat('EEE d MMMM, yyy').format(DateTime.parse(widget.invoice.dueDate))}',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Amount Details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total Amount',
                                style: TextStyle(),
                              ),
                              Text("Tsh: ${formatter.format(subTotal)}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Discount',
                                style: TextStyle(),
                              ),
                              Text("Tsh: ${formatter.format(discount)}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Paid Amount',
                                style: TextStyle(),
                              ),
                              Text("Tsh: ${formatter.format(paid)}"),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Balance Due',
                                style: TextStyle(),
                              ),
                              Text("Tsh: ${formatter.format(balanceDue)}"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(height: 10),
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Invoice To',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(widget.invoice.fullName),
                          Text(myCustomer == null
                              ? ""
                              : myCustomer!.phoneNumber),
                          Text(myCustomer == null ? "" : myCustomer!.address),
                          Text(myCustomer == null ? "" : myCustomer!.email),
                        ],
                      ),
                    ),
                  ),
                  // Container(height: 10),
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Invoice Details',
                            style: TextStyle(
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
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Issued Date: '),
                              Text(
                                DateFormat('d-M-yyy').format(DateTime.now()),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Due Date: '),
                              Text(
                                DateFormat('d-M-yyy').format(
                                    DateTime.parse(widget.invoice.dueDate)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(height: 10),
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Table(children: myRowData),
                    ),
                  ),
                  // Container(height: 10),
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Text(
                            'Notes',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Thanks for your business'),
                        ],
                      ),
                    ),
                  ),
                  // Container(height: 10),
                  Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          Text(
                            'Payment Methods',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('None'),
                        ],
                      ),
                    ),
                  ),
                  // Container(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => AddPaymentCustomerDialog(
                customer: myCustomer!,
                isPaymentIn: true,
              ),
              fullscreenDialog: true,
            ),
          );
        },
        label: const Text("Receive Payment"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
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
