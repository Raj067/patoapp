import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:intl/intl.dart';

class AddTransactionDialog extends StatefulWidget {
  const AddTransactionDialog({Key? key}) : super(key: key);

  @override
  State<AddTransactionDialog> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Transaction',
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
                        activeColor: patoGreen,
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
                      const Text("Sales"),
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
                        activeColor: patoRed,
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
                      const Text("Expenses"),
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text("Invoice No 1"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Date: ${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
                    ),
                  ),
                ),
              ]),
            ],
          ),
          const Divider(height: 0),
          Center(
            child: Text("$_value"),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          child: const Text(
            "Add Transaction",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
