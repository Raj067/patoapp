import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';
// import 'package:pdfx/pdfx.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrivacyPolicyDialog extends StatefulWidget {
  const PrivacyPolicyDialog({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyDialog> createState() => _PrivacyPolicyDialogState();
}

class _PrivacyPolicyDialogState extends State<PrivacyPolicyDialog> {
  // final pdfPinchController = PdfController(
  //   document: PdfDocument.openAsset('assets/pdf/privacy-policy.pdf'),
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Privacy Policy',
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
      body: Container(
        child: SfPdfViewer.asset('assets/pdf/privacy-policy.pdf'),
        // .network(
        //     'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
      ),
    );
  }
} 
