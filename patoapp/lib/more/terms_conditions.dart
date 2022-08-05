import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:pdfx/pdfx.dart';

class TermsConditionsDialog extends StatefulWidget {
  const TermsConditionsDialog({Key? key}) : super(key: key);

  @override
  State<TermsConditionsDialog> createState() => _TermsConditionsDialogState();
}

class _TermsConditionsDialogState extends State<TermsConditionsDialog> {
  final pdfPinchController = PdfControllerPinch(
    document: PdfDocument.openAsset('assets/pdfb/terms.pdf'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Terms and Conditions',
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
      body: PdfViewPinch(
        controller: pdfPinchController,
      ),
    );
  }
}
