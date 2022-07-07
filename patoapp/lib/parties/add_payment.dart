import 'package:dropdown_button2/dropdown_button2.dart';
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
  // Items added for selling
  List salesItems = [];
  // Items added for purchases
  List purchasesItems = [];

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
            color: Colors.grey.withAlpha(0),
            child: Row(
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

                    // Validate returns true if the form is valid, or false otherwise.
                    if (paymentInFormKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  } else {
                    // for payment out

                    // Validate returns true if the form is valid, or false otherwise.
                    if (paymentOutFormKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
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
    final List<String> items = [
      'A_Item1',
      'A_Item2',
      'A_Item3',
      'A_Item4',
      'B_Item1',
      'B_Item2',
      'B_Item3',
      'B_Item4',
    ];

    String? selectedValue;
    final TextEditingController textEditingController = TextEditingController();

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: paymentInFormKey,
          child: ListView(
            children: [
              Container(height: 15),
              TextFormField(
                cursorColor: patowavePrimary,
                onChanged: (val) {
                  setState(() {
                    receivedAmount = val;
                  });
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
              DropdownButtonFormField2(
                  validator: (value) {
                    if (value == null || value == "") {
                      return 'Please select customer name';
                    }
                    return null;
                  },
                  value: selectedValue,
                  selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  decoration: InputDecoration(
                    label: const Text(
                      'Select customer',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                  searchController: textEditingController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for Customer..',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value.toString().contains(searchValue));
                  },
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      textEditingController.clear();
                    }
                  }),
              Container(height: 15),
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

  _paymentOut() {
    final List<String> items = [
      'A_Item1',
      'A_Item2',
      'A_Item3',
      'A_Item4',
      'B_Item1',
      'B_Item2',
      'B_Item3',
      'B_Item4',
    ];

    String? selectedValue;
    final TextEditingController textEditingController = TextEditingController();
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: paymentOutFormKey,
          child: ListView(
            children: [
              Container(height: 15),
              TextFormField(
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
              DropdownButtonFormField2(
                  validator: (value) {
                    if (value == null || value == "") {
                      return 'Please select customer name';
                    }
                    return null;
                  },
                  value: selectedValue,
                  selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  decoration: InputDecoration(
                    label: const Text(
                      'Select customer',
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  isExpanded: true,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                  searchController: textEditingController,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'Search for Customer..',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return (item.value.toString().contains(searchValue));
                  },
                  //This to clear the search value when you close the menu
                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      textEditingController.clear();
                    }
                  }),
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
