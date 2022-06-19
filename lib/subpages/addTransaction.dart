import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/themes/lightTheme.dart';

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
          _value == 1 ? _addSales() : _addExpenses(),
        ],
      ),
    );
  }

  _addSales() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
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
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Amount"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Party Name"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            Card(
              color: patowavePrimary,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Add Items to sale',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            _discount(),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total Amount",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tsh: totalAmount",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Balance due",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: patowavePrimary),
                ),
                Text(
                  "Tsh: balanceDue",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: patowavePrimary),
                ),
              ],
            ),
            Container(height: 10),
            SizedBox(
              // height: 180,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                  label: Text("Descriptions"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(color: patowaveWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addExpenses() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            Table(
              border: TableBorder.all(width: 1.0, color: Colors.grey),
              children: [
                TableRow(children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Bill No 1"),
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
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Amount"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            const Text("Other Informations:"),
            Card(
              color: patowavePrimary,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Add Items to Purchases',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Expenses Category"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Add Contact"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Total Amount",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tsh: totalAmount",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (val) {},
                        activeColor: patowavePrimary,
                      ),
                      const Text(
                        "Paid Amount",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text("Tsh"),
                        border: OutlineInputBorder(),
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
                  "Balance due",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: patowaveErrorRed),
                ),
                Text(
                  "Tsh: balanceDue",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: patowavePrimary),
                ),
              ],
            ),
            Container(height: 10),
            SizedBox(
              // height: 180,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                  label: Text("Descriptions"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Add Transaction",
                  style: TextStyle(color: patowaveWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _discount() {
    return Column(
      children: [
        Container(height: 15),
        const Divider(height: 0),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 5, 15, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Discount",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              Container(width: 5),
              Expanded(
                child: Container(
                  height: 35,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Container(
                        color: const Color.fromARGB(255, 255, 200, 200),
                        child: const Icon(
                          Icons.percent,
                          color: patowaveErrorRed,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(width: 10),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Container(
                        color: Colors.grey,
                        child: const Padding(
                          padding: EdgeInsets.all(5),
                          child: Text("Tsh",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 0),
        Container(height: 15),
      ],
    );
  }
}
