import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:patoapp/themes/lightTheme.dart';

class TermsConditionsDialog extends StatefulWidget {
  const TermsConditionsDialog({Key? key}) : super(key: key);

  @override
  State<TermsConditionsDialog> createState() => _TermsConditionsDialogState();
}

class _TermsConditionsDialogState extends State<TermsConditionsDialog> {
  // ignore: prefer_typing_uninitialized_variables
  var data;
  loadAsset() async {
    data = await rootBundle.loadString('docs/terms.txt');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadAsset();
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
      // body: data != null
      //     ? SingleChildScrollView(
      //         child: Padding(
      //           padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      //           child: Text("$data"),
      //         ),
      //       )
      //     : const Center(
      //         child: CircularProgressIndicator(),
      //       ),
      body: const Center(
        child: Text("Terms and Conditions"),
      ),
    );
  }
}
