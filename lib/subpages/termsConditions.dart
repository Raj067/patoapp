import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:flutter/services.dart';

class TermsConditionsDialog extends StatefulWidget {
  const TermsConditionsDialog({Key? key}) : super(key: key);

  @override
  State<TermsConditionsDialog> createState() => _TermsConditionsDialogState();
}

class _TermsConditionsDialogState extends State<TermsConditionsDialog> {
  // ignore: prefer_typing_uninitialized_variables
  var data;
  loadData() async {
    // try {
    // data = await rootBundle.loadString('terms.txt');
    // debugPrint(data);
    data = "Some data shown";
    // } catch (e) {
    //   print('Error: $e');
    //   rethrow;
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
            color: patoWhite,
          ),
        ),
      ),
      body: data == null
          ? const Center(child: CircularProgressIndicator())
          : Text("$data"),
    );
  }
}
