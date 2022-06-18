import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  final List<String> primaryUnits = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  final List<String> secondaryUnits = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedPrimaryUnit;
  String? selectedSecondaryUnit;

  String? selectedValue;
  bool _isSupplierActivated = false;
  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Item',
          style: TextStyle(color: Colors.white),
        ),
        // centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: patoWhite,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: () {},
          )
        ],
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
                        activeColor: patoPrimaryColor,
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
                      const Text("Product"),
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
                        activeColor: patoPrimaryColor,
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
                      const Text("Service"),
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
          _value == 1 ? _addProduct() : _addService(),
        ],
      ),
    );
  }

  _addProduct() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            // _formField1(),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: InputDecoration(
                  label: const Text("Item Name"),
                  border: const OutlineInputBorder(),
                  suffixIcon: ElevatedButton(
                    onPressed: () {
                      _setUnit(context);
                    },
                    child: const Text(
                      "Set Unit",
                    ),
                  ),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Item Code"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Purchases Price"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            const Text("Pricing & Other Details"),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Sales Price (can)"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Sales Price (box)"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Tooltip(
                          message: "hello",
                          child: Icon(Icons.question_mark_outlined),
                        ),
                        label: Text("Quantity"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Container(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.question_mark_outlined),
                        label: Text("Stock Level"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("Supplier Contact"),
              Switch(
                  activeColor: patoPrimaryColor,
                  value: _isSupplierActivated,
                  onChanged: (val) {
                    setState(() {
                      _isSupplierActivated = val;
                    });
                  })
            ]),

            _isSupplierActivated
                ? Column(
                    children: [
                      Container(height: 10),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Name"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Phone Number"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Email"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(height: 10)
                    ],
                  )
                : Container(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Add Product",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setUnit(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: patoBackgroundColor,
          title: const Text('Add Item Unit'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 45,
                child: DropdownButtonFormField2(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Primary Unit',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  items: genderItems
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
                ),
              ),
              Container(height: 10),
              CustomDropdownButton2(
                hint: 'Select Item',
                dropdownItems: secondaryUnits,
                value: selectedSecondaryUnit,
                onChanged: (value) {
                  setState(() {
                    selectedSecondaryUnit = value;
                  });
                },
              ),
              SizedBox(
                height: 45,
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Primary Unit"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(height: 10),
              SizedBox(
                height: 45,
                child: TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Secondary Unit"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(height: 10),
              const Text("Conversion Rate"),
              Container(height: 10),
              const Center(
                child: Text(
                  "1 BOX = 12 CANS",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Save",
              ),
            ),
          ],
        );
      },
    );
  }

  _addService() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            // _formField1(),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Service Name"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Service Charge"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Service Unit"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Description"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Add Service",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
