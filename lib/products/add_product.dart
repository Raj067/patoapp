import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patoapp/themes/light_theme.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final List<String> primaryUnits = [
    'BAGS (Bags)',
    'BOTTLES (Btl)',
    'BOX (Box)',
    'BUNDLES (Bdl)',
    'CANS (Can)',
    'CARTONS (Ctn)',
    'DOZENS (Dzn)',
    'GRAMMES (gm)',
    'KILOGRAMS (Kg)',
    'LITRE (Ltr)',
    'METERS (Mtr)',
    'MILILITRE (Ml)',
    'NUMBERS (Nos)',
    'PACKS (Pac)',
    'PAIRS (Prs)',
    'PIECES (Pcs)',
  ];
  final List<String> secondaryUnits = [
    'BOTTLES (Btl)',
    'BOX (Box)',
    'BUNDLES (Bdl)',
    'CANS (Can)',
    'CARTONS (Ctn)',
    'DOZENS (Dzn)',
    'GRAMMES (gm)',
    'KILOGRAMS (Kg)',
    'LITRE (Ltr)',
    'METERS (Mtr)',
    'MILILITRE (Ml)',
    'NUMBERS (Nos)',
    'PACKS (Pac)',
    'PAIRS (Prs)',
    'PIECES (Pcs)',
  ];
  String selectedPrimaryUnit = 'CANS (Can)';
  String selectedSecondaryUnit = 'BOX (Box)';

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
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          elevation: 0,
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
                  value: selectedPrimaryUnit,
                  selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  decoration: InputDecoration(
                    label: const Text(
                      'Primary Unit',
                      style: TextStyle(fontSize: 14),
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
                  value: selectedSecondaryUnit,
                  selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                  scrollbarAlwaysShow: true,
                  dropdownMaxHeight: 200,
                  decoration: InputDecoration(
                    label: const Text(
                      'Secondary Unit',
                      style: TextStyle(fontSize: 14),
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
              Center(
                child: Text(
                  "1 $selectedPrimaryUnit= 12 $selectedSecondaryUnit",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ButtonStyle(
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
                  child: const Text("Cancel"),
                ),
              ),
              Container(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
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
                  child: const Text("Save"),
                ),
              ),
            ])
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
                  label: Text(
                    "Service Name",
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
                    "Service Charge",
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
                    "Service Unit",
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
                    "Description",
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
