import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TermsConditionsDialog extends StatefulWidget {
  const TermsConditionsDialog({Key? key}) : super(key: key);

  @override
  State<TermsConditionsDialog> createState() => _TermsConditionsDialogState();
}

class _TermsConditionsDialogState extends State<TermsConditionsDialog> {
  var data = "";
  fetchData() async {
    // Data for general analysis
    var myData = await http.get(
      Uri.parse("${baseUrl}static/patoapp/files/terms_condition.txt"),
      headers: authHeaders,
    );
    print(myData.body);
    if (myData.statusCode == 200) {
      print(myData.body);
      data = myData.body;
    }
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
      body: data != ""
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(data),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
      // body: const Center(
      //   child: Text("Terms and Conditions"),
      // ),
    );
  }
}
