import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/themes/light_theme.dart';

class AddPaymentDialog extends StatefulWidget {
  const AddPaymentDialog({Key? key}) : super(key: key);

  @override
  State<AddPaymentDialog> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends State<AddPaymentDialog> {
  int _value = 1;
  String paidAmount = '0';
  String receivedAmount = '0';
  final paymentInFormKey = GlobalKey<FormState>();
  final paymentOutFormKey = GlobalKey<FormState>();
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
          Container(
            color: Colors.grey.withAlpha(50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: _value == 1
                        ? patowaveGreen.withAlpha(100)
                        : Colors.grey.withAlpha(50),
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
                        : Colors.grey.withAlpha(50),
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
          ),
          const Divider(height: 0),
          Table(
            border: TableBorder.all(width: 1.0, color: Colors.grey),
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
          _value == 1 ? _paymentIn() : _paymentOut(),
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
                      if (paymentInFormKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    }
                  } else {
                    // for payment out
                    {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (paymentOutFormKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
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

  _paymentIn() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: paymentInFormKey,
          child: ListView(
            children: [
              Container(height: 10),
              TextFormField(
                cursorColor: patowavePrimary,
                onChanged: (val) {
                  setState(() {
                    receivedAmount = val;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount received';
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
              Container(height: 10),
              TextFormField(
                cursorColor: patowavePrimary,
                decoration: const InputDecoration(
                  label: Text(
                    "Customer Name",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Amount",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Tsh: $receivedAmount",
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(height: 20),
              TextFormField(
                cursorColor: patowavePrimary,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 2,
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

  _paymentOut() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: paymentOutFormKey,
          child: ListView(
            children: [
              Container(height: 10),
              TextFormField(
                cursorColor: patowavePrimary,
                onChanged: (val) {
                  setState(() {
                    paidAmount = val;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter amount paid';
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
              Container(height: 10),
              TextFormField(
                cursorColor: patowavePrimary,
                decoration: const InputDecoration(
                  label: Text(
                    "Customer Name",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(height: 10),
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
                cursorColor: patowavePrimary,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 2,
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
