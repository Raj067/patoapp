import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';

class TermsConditionsDialog extends StatefulWidget {
  const TermsConditionsDialog({Key? key}) : super(key: key);

  @override
  State<TermsConditionsDialog> createState() => _TermsConditionsDialogState();
}

class _TermsConditionsDialogState extends State<TermsConditionsDialog> {
  bool _isLoading = true;
  String document = '';
  fetchData() async {
    // Load from URL
    // document = await PDFDocument.fromURL(
    //   "${baseUrl}static/patoapp/files/terms_condition.pdf",
    //   headers: authHeaders,
    // );
    _isLoading = false;
    setState(() {});
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
          'Terms and Conditions',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(document),
              ),
            ),
      // body: const Center(
      //   child: Text("Terms and Conditions"),
      // ),
    );
  }
}
