import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/backend/models/profile_details.dart';
import 'package:pdf/pdf.dart' as p;
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as pt;

Future<Uint8List> generateCashFlow({
  required List<FinancialData> data,
  required ProfileData profile,
  required DateTimeRange pickedRangeDate,
}) async {
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
      header: (context) {
        return pw.Column(
          children: [
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
                      profile.businessName.toUpperCase()[0],
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
                      profile.businessName,
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      profile.businessAddress,
                    ),
                    pw.Text(profile.businessPhone),
                    pw.Text(profile.businessEmail),
                    // pw.Text(
                    //   DateFormat('d-MMM-yyy').format(DateTime.now()),
                    // ),
                  ],
                ),

                pw.Spacer(),

                pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Sales Reports',
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'From:',
                          style: pw.TextStyle(
                            // fontSize: 15.5,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          DateFormat('d MMMM, yyy')
                              .format(pickedRangeDate.start),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'To: ',
                          style: pw.TextStyle(
                            // fontSize: 15.5,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          DateFormat('d MMMM, yyy').format(pickedRangeDate.end),
                        ),
                      ],
                    ),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'Date: ',
                          style: pw.TextStyle(
                            // fontSize: 15.5,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.Text(
                          DateFormat('d MMMM, yyy').format(DateTime.now()),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            pw.SizedBox(height: 1 * p.PdfPageFormat.mm),
            pw.Divider(),
            pw.SizedBox(height: 2 * p.PdfPageFormat.mm),
          ],
        );
      },
      build: (context) {
        return [
          pw.SizedBox(height: 5 * p.PdfPageFormat.mm),

          // ///
          // /// PDF Table Create
          // ///
          // pw.Table.fromTextArray(
          //   headers: tableHeaders,
          //   data: tableData,
          //   border: null,
          //   headerStyle: pw.TextStyle(
          //     fontWeight: pw.FontWeight.bold,
          //     color: p.PdfColors.white,
          //   ),
          //   headerDecoration: pw.BoxDecoration(
          //     color: selectedColorInvoice,
          //   ),
          //   cellHeight: 30.0,
          //   cellAlignments: {
          //     0: pw.Alignment.centerLeft,
          //     1: pw.Alignment.centerRight,
          //     2: pw.Alignment.centerRight,
          //     3: pw.Alignment.centerRight,
          //   },
          // ),
          // pw.Divider(
          //   color: p.PdfColors.grey400,
          // ),
          // pw.Container(
          //   alignment: pw.Alignment.centerRight,
          //   child: pw.Row(
          //     children: [
          //       // pw.Spacer(flex: 6),
          //       pw.Expanded(
          //         flex: 6,
          //         child: pw.Column(
          //           crossAxisAlignment: pw.CrossAxisAlignment.start,
          //           children: [
          //             pw.Text(
          //               'Notes:',
          //               style: pw.TextStyle(
          //                 fontWeight: pw.FontWeight.bold,
          //               ),
          //             ),
          //             pw.Text('Thanks for your business'),
          //           ],
          //         ),
          //       ),
          //       pw.Expanded(
          //         flex: 4,
          //         child: pw.Column(
          //           crossAxisAlignment: pw.CrossAxisAlignment.start,
          //           children: [
          //             pw.Row(
          //               children: [
          //                 pw.Expanded(
          //                   child: pw.Text(
          //                     'Sub Total',
          //                   ),
          //                 ),
          //                 pw.Text(
          //                   'Tsh ${formatter.format(subTotal.toInt())}',
          //                   style: pw.TextStyle(
          //                     fontWeight: pw.FontWeight.bold,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             pw.Row(
          //               children: [
          //                 pw.Expanded(
          //                   child: pw.Text('Discount'),
          //                 ),
          //                 pw.Text(
          //                   'Tsh ${formatter.format(discount.toInt())}',
          //                   style: pw.TextStyle(
          //                     fontWeight: pw.FontWeight.bold,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             pw.Row(
          //               children: [
          //                 pw.Expanded(
          //                   child: pw.Text(
          //                     'TAX',
          //                   ),
          //                 ),
          //                 pw.Text(
          //                   'Tsh ${formatter.format(tax.toInt())}',
          //                   style: pw.TextStyle(
          //                     fontWeight: pw.FontWeight.bold,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             pw.Row(
          //               children: [
          //                 pw.Expanded(
          //                   child: pw.Text(
          //                     'Paid',
          //                   ),
          //                 ),
          //                 pw.Text(
          //                   'Tsh ${formatter.format(paid.toInt())}',
          //                   style: pw.TextStyle(
          //                     fontWeight: pw.FontWeight.bold,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             // pw.Divider(),
          //             pw.SizedBox(height: 1 * p.PdfPageFormat.mm),
          //             pw.Container(
          //               color: selectedColorInvoice,
          //               child: pw.Padding(
          //                 padding: const pw.EdgeInsets.all(10),
          //                 child: pw.Row(
          //                   children: [
          //                     pw.Expanded(
          //                       child: pw.Text(
          //                         'Balnce due',
          //                         style: pw.TextStyle(
          //                           fontSize: 14.0,
          //                           fontWeight: pw.FontWeight.bold,
          //                           color: p.PdfColors.white,
          //                         ),
          //                       ),
          //                     ),
          //                     pw.Text(
          //                       'Tsh ${formatter.format(balanceDue.toInt())}',
          //                       style: pw.TextStyle(
          //                         fontWeight: pw.FontWeight.bold,
          //                         color: p.PdfColors.white,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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

Future<File> generateCashFlowPdf({
  required List<FinancialData> data,
  required ProfileData profile,
  required DateTimeRange pickedRangeDate,
}) async {
  final bytes = await generateCashFlow(
    data: data,
    profile: profile,
    pickedRangeDate: pickedRangeDate,
  );
  final dir = await getExternalStorageDirectory();
  String myPath = pt.dirname(pt.dirname(pt.dirname(pt.dirname(dir!.path))));
  myPath = '$myPath/PatoWave/Reports';
  Directory('$myPath/').create();
  final file = File(
      '$myPath/Sales Report as at ${DateFormat('d MMMM, yyy').format(pickedRangeDate.start)} to ${DateFormat('d MMMM, yyy').format(pickedRangeDate.end)}.pdf');
  await file.writeAsBytes(bytes);
  return file;
}
