import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/data/customerList.dart';
import 'package:patoapp/themes/lightTheme.dart';

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
              Expanded(
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
              )
            ],
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
                onPressed: () {},
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
        child: ListView(
          children: [
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: patowaveBlack.withAlpha(30),
                  hintStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                  hintText: "${customer.firstName} ${customer.lastName}",
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(
                      color: patowaveBlack.withAlpha(30),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(
                      color: patowaveBlack.withAlpha(30),
                    ),
                  ),
                ),
              ),
            ),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Received",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
                Container(width: 30),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        label: Text(
                          "Tsh",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total Amount",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tsh: 1000.00",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(height: 20),
            SizedBox(
              // height: 180,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 3,
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
            ),
          ],
        ),
      ),
    );
  }

  _paymentOut(SingleCustomer customer) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: patowaveBlack.withAlpha(30),
                  hintStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                  hintText: "${customer.firstName} ${customer.lastName}",
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(
                      color: patowaveBlack.withAlpha(30),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(
                      color: patowaveBlack.withAlpha(30),
                    ),
                  ),
                ),
              ),
            ),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Paid",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
                Container(width: 30),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: const InputDecoration(
                        label: Text(
                          "Tsh",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total Amount",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tsh: 1000.00",
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(height: 20),
            SizedBox(
              // height: 180,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 3,
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
            ),
          ],
        ),
      ),
    );
  }
}
