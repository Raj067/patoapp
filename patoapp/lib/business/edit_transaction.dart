// ignore: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patoapp/data/business_financial_data.dart';
import 'package:patoapp/themes/light_theme.dart';

class EditTransaction extends StatefulWidget {
  final FinancialData data;
  const EditTransaction({Key? key, required this.data}) : super(key: key);

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  final paymentInFormKey = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  TextEditingController paymentInDesc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // String shopName = "Happy Shop";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Transaction',
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
      body: ListView(
        children: [
          _paymentIn(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.share),
      ),
    );
  }

  _paymentIn() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: paymentInFormKey,
          child: ListView(
            children: [
              Container(height: 15),
              TextFormField(
                controller: amount,
                cursorColor: patowavePrimary,
                onChanged: (val) {
                  // setState(() {
                  //   receivedAmount = val;
                  // });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Received Amount is required';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  label: Text(
                    "Received Amount",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Container(height: 15),
              TextFormField(
                controller: paymentInDesc,
                cursorColor: patowavePrimary,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 3,
                maxLines: null,
                decoration: const InputDecoration(
                  label: Text(
                    "Add Note (Descriptions)",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
