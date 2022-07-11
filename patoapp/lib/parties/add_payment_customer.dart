import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/data/customer_list.dart';
import 'package:patoapp/themes/light_theme.dart';

class AddPaymentCustomerDialog extends StatefulWidget {
  final SingleCustomer customer;
  final bool isPaymentIn;
  const AddPaymentCustomerDialog(
      {Key? key, required this.customer, required this.isPaymentIn})
      : super(key: key);

  @override
  State<AddPaymentCustomerDialog> createState() =>
      _AddPaymentCustomerDialogState();
}

class _AddPaymentCustomerDialogState extends State<AddPaymentCustomerDialog> {
  int _value = 1;
  String paidAmount = '0';
  String receivedAmount = '0';
  final paidAmountFormKey1 = GlobalKey<FormState>();
  final receivedAmountformKey1 = GlobalKey<FormState>();

  TextEditingController amountReceived = TextEditingController();
  TextEditingController amountPaid = TextEditingController();
  TextEditingController paymentInDesc = TextEditingController(text: "");
  TextEditingController paymentOutDesc = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    _value = widget.isPaymentIn ? 1 : 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payments',
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: _value == 1
                      ? patowaveGreen.withAlpha(100)
                      : Colors.grey.withAlpha(0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _value = 1;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          activeColor: patowaveGreen,
                          value: 1,
                          groupValue: _value,
                          onChanged: (val) {
                            setState(() {
                              _value = 1;
                            });
                          },
                        ),
                        Container(
                          width: 5,
                        ),
                        const Text("Payment in"),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: _value == 2
                      ? patowaveErrorRed.withAlpha(100)
                      : Colors.grey.withAlpha(0),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _value = 2;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          activeColor: patowaveErrorRed,
                          value: 2,
                          groupValue: _value,
                          onChanged: (val) {
                            setState(() {
                              _value = 2;
                            });
                          },
                        ),
                        Container(
                          width: 5,
                        ),
                        const Text("Payment out"),
                        Container(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Table(
            border: TableBorder.all(
              width: 1.0,
              color: Colors.grey.withAlpha(100),
            ),
            children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      _value == 1 ? "Receipt No 1" : "Receipt No 1",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Date: ${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                  ),
                ),
              ]),
            ],
          ),
          const Divider(height: 0),
          _value == 1
              ? _paymentIn(widget.customer)
              : _paymentOut(widget.customer),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  // MaterialStateProperty<Color?>? backgroundColor,
                  minimumSize: MaterialStateProperty.all(
                    const Size(45, 45),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  if (_value == 1) {
                    // for payment in
                    {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (receivedAmountformKey1.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        showPleaseWait(
                          context: context,
                          builder: (context) => const ModalFit(),
                        );
                        _addPaymentCustomer(
                          isPaymentIn: true,
                          amount: int.parse(amountReceived.text),
                          description: paymentInDesc.text == ""
                              ? "Payment In"
                              : paymentInDesc.text,
                          id: widget.customer.id,
                        );
                      }
                    }
                  } else {
                    // for payment out
                    {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (paidAmountFormKey1.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        showPleaseWait(
                          context: context,
                          builder: (context) => const ModalFit(),
                        );
                        _addPaymentCustomer(
                          isPaymentIn: false,
                          amount: int.parse(amountPaid.text),
                          description: paymentOutDesc.text == ""
                              ? "Payment Out"
                              : paymentOutDesc.text,
                          id: widget.customer.id,
                        );
                      }
                    }
                  }
                },
                child: const Text(
                  "Add Payment",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _paymentIn(SingleCustomer customer) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: receivedAmountformKey1,
          child: ListView(
            children: [
              Container(height: 15),
              TextFormField(
                controller: amountReceived,
                cursorColor: patowavePrimary,
                onChanged: (val) {
                  setState(() {
                    receivedAmount = val;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Amount Received is required';
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
              Container(
                decoration: BoxDecoration(
                  color: patowaveBlack.withAlpha(30),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Text(
                    customer.fullName,
                    style: const TextStyle(
                      // color: Color.fromARGB(255, 124, 124, 124),
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Tsh: $receivedAmount",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(height: 20),
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

  _paymentOut(SingleCustomer customer) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: paidAmountFormKey1,
          child: ListView(
            children: [
              Container(height: 15),
              TextFormField(
                controller: amountPaid,
                cursorColor: patowavePrimary,
                onChanged: (val) {
                  setState(() {
                    paidAmount = val;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Paid Amount is required';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  label: Text(
                    "Paid Amount",
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
              Container(
                decoration: BoxDecoration(
                  color: patowaveBlack.withAlpha(30),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Text(
                    customer.fullName,
                    style: const TextStyle(
                      // color: Color.fromARGB(255, 124, 124, 124),
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Tsh: $paidAmount",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Container(height: 20),
              TextFormField(
                controller: paymentOutDesc,
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

  _addPaymentCustomer({
    required int amount,
    required String description,
    required bool isPaymentIn,
    required int id,
  }) async {
    final response = await http.post(
      Uri.parse('${baseUrl}api/adding-payment-customer/'),
      headers: authHeaders,
      body: jsonEncode(<String, dynamic>{
        'amount': amount,
        'description': description,
        'isPaymentIn': isPaymentIn,
        'id': id,
      }),
    );

    if (response.statusCode == 201) {
      // Renaming the customer
      Navigator.pop(context);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Failed to updated customer.')),
      // );
      throw Exception('Failed to updated customer.');
    }
  }
}
