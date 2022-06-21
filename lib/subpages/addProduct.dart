import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patoapp/themes/lightTheme.dart';

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
    'Item a',
    'Item b',
    'Item c',
    'Item d',
    'Item e',
    'Item f',
    'Item g',
    'Item h',
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
            color: patowaveWhite,
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
                        activeColor: patowavePrimary,
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
                        activeColor: patowavePrimary,
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
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  label: const Text(
                    "Item Name",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
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
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Item Code",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Purchases Price",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            const Text(
              "Pricing & Other Details",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
            ),
            Container(height: 10),
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Sales Price (can)",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Sales Price (box)",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: const FaIcon(
                                FontAwesomeIcons.solidCircleQuestion),
                            onPressed: () {}),
                        label: const Text(
                          "Quantity",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Container(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: const FaIcon(
                                FontAwesomeIcons.solidCircleQuestion),
                            onPressed: () {}),
                        label: const Text(
                          "Stock Level",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 10),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text(
                "Supplier Contact",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              Switch(
                  activeColor: patowavePrimary,
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
                        height: 40,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text(
                              "Name",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text(
                              "Phone Number",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Container(height: 10),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text(
                              "Email",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
                            ),
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
          scrollable: true,
          // backgroundColor: patoBackgroundColor,
          title: const Text('Add Item Unit'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 40,
                child: DropdownButtonFormField2(
                  selectedItemHighlightColor: patowavePrimary,
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
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
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  items: primaryUnits
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
              SizedBox(
                height: 40,
                child: DropdownButtonFormField2(
                  selectedItemHighlightColor: patowavePrimary,
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Secondary Unit',
                    style: TextStyle(fontSize: 14),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                  ),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  items: secondaryUnits
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
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Service Name",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Service Charge",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Service Unit",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Description",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
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
