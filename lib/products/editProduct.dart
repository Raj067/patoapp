import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patoapp/themes/lightTheme.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Product',
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
          _addProduct(),
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
                  "Add Item",
                ),
              ),
            ),
          ],
        ),
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
                  label: const Text(
                    "Item Name",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  suffixIcon: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
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
                  label: Text(
                    "Item Code",
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
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Purchases Price",
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
            Container(height: 10),
            const Text(
              "Pricing & Other Details",
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Sales Price (can)",
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
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Sales Price (box)",
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
            Container(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
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
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 45,
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
                        border: const OutlineInputBorder(
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
                        height: 45,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text(
                              "Name",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
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
                            label: Text(
                              "Phone Number",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
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
                            label: Text(
                              "Email",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(height: 10)
                    ],
                  )
                : Container(height: 10),
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
                height: 45,
                child: DropdownButtonFormField2(
                  selectedItemHighlightColor: patowavePrimary,
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
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
                    borderRadius: BorderRadius.circular(15),
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
                height: 45,
                child: DropdownButtonFormField2(
                  selectedItemHighlightColor: patowavePrimary,
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
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
                    borderRadius: BorderRadius.circular(15),
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
}
