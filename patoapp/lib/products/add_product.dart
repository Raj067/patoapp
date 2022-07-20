import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/themes/light_theme.dart';

class AddProductPage extends StatefulWidget {
  final bool isProductImage;
  final bool isProductBarcode;
  final Function resetData;
  const AddProductPage({
    Key? key,
    required this.isProductImage,
    required this.isProductBarcode,
    required this.resetData,
  }) : super(key: key);

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  String? selectedPrimaryUnit;

  String? selectedValue;
  bool _isSupplierActivated = false;
  int _value = 1;
  final addProductFormKey = GlobalKey<FormState>();
  final addServicesFormKey = GlobalKey<FormState>();
  // Controllers

  TextEditingController productName = TextEditingController();
  TextEditingController purchasesPrice = TextEditingController();
  TextEditingController sellingPrice = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController stockLevel = TextEditingController();
  TextEditingController primaryUnit = TextEditingController();
  TextEditingController supplierName = TextEditingController();
  TextEditingController supplierNumber = TextEditingController();
  TextEditingController supplierEmail = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    productName.dispose();
    purchasesPrice.dispose();
    sellingPrice.dispose();
    quantity.dispose();
    stockLevel.dispose();
    primaryUnit.dispose();
    supplierName.dispose();
    supplierNumber.dispose();
    supplierEmail.dispose();
  }

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
        actions: widget.isProductImage
            ? [
                IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  onPressed: () {},
                ),
              ]
            : [],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  color: _value == 1
                      ? patowavePrimary.withAlpha(100)
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
              ),
              Expanded(
                child: Container(
                  color: _value == 2
                      ? patowavePrimary.withAlpha(100)
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
                onPressed: () {
                  if (_value == 1) {
                    // for payment in

                    // Validate returns true if the form is valid, or false otherwise.
                    if (addProductFormKey.currentState!.validate()) {
                      _submitProduct(isService: false);
                    }
                  } else {
                    // for payment out

                    // Validate returns true if the form is valid, or false otherwise.
                    if (addServicesFormKey.currentState!.validate()) {
                      _submitProduct(isService: true);
                    }
                  }
                },
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
        child: Form(
          key: addProductFormKey,
          child: ListView(
            children: [
              Container(height: 15),
              TextFormField(
                cursorColor: patowavePrimary,
                controller: productName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Item name is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Item Name*",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              widget.isProductBarcode
                  ? Column(
                      children: [
                        Container(height: 15),
                        TextFormField(
                          cursorColor: patowavePrimary,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            label: Text(
                              "Item Code",
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
                      ],
                    )
                  : Container(),
              Container(height: 15),
              DropdownButtonFormField2(
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Please select Unit';
                  }
                  return null;
                },
                value: selectedPrimaryUnit,
                selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                scrollbarAlwaysShow: true,
                dropdownMaxHeight: 200,
                decoration: InputDecoration(
                  label: const Text(
                    'Select Unit*',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
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
                  setState(() {
                    primaryUnit.text = value.toString();
                  });
                  //Do something when changing the item if you want.
                },
                onSaved: (value) {
                  selectedValue = value.toString();
                },
              ),
              Container(height: 20),
              const Text(
                "Pricing & Other Details",
                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              Container(height: 15),
              TextFormField(
                cursorColor: patowavePrimary,
                controller: sellingPrice,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sales Price is required';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  label: Text(
                    "Sales Price*",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              TextFormField(
                cursorColor: patowavePrimary,
                controller: purchasesPrice,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Purchases Price is required';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  label: Text(
                    "Purchases Price*",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: patowavePrimary,
                      controller: quantity,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const FaIcon(
                              FontAwesomeIcons.solidCircleQuestion),
                          onPressed: () {
                            _quantityToolTip(
                              context,
                            );
                          },
                        ),
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
                  Container(width: 10),
                  Expanded(
                    child: TextFormField(
                      cursorColor: patowavePrimary,
                      controller: stockLevel,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const FaIcon(
                              FontAwesomeIcons.solidCircleQuestion),
                          onPressed: () {
                            _stockLevelToolTip(context);
                          },
                        ),
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
                ],
              ),
              Container(height: 15),
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
                        Container(height: 15),
                        TextFormField(
                          cursorColor: patowavePrimary,
                          controller: supplierName,
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
                        Container(height: 15),
                        TextFormField(
                          cursorColor: patowavePrimary,
                          controller: supplierNumber,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
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
                        Container(height: 15),
                        TextFormField(
                          cursorColor: patowavePrimary,
                          controller: supplierEmail,
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
                        Container(height: 10)
                      ],
                    )
                  : Container(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  _addService() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: addServicesFormKey,
          child: ListView(
            children: [
              // _formField1(),
              Container(height: 15),
              TextFormField(
                cursorColor: patowavePrimary,
                controller: productName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Service Name is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Service Name*",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              TextFormField(
                cursorColor: patowavePrimary,
                controller: sellingPrice,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Service charge is required';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  label: Text(
                    "Service Charge*",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              TextFormField(
                cursorColor: patowavePrimary,
                controller: primaryUnit,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Service unit is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Service Unit*",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              TextFormField(
                cursorColor: patowavePrimary,
                controller: supplierName,
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _quantityToolTip(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          elevation: 0,
          content: Text('Items available before start using Patowave'),
        );
      },
    );
  }

  Future<void> _stockLevelToolTip(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          elevation: 0,
          content: Text(
              "Minimum quantity of item you wish to maintain. Patowave will notify you when stock falls below this level"),
        );
      },
    );
  }
// api/add-new-product/

  _submitProduct({required bool isService}) async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    String accessToken = await storage.read(key: 'access') ?? "";
    final response = await http.post(
      Uri.parse('${baseUrl}api/add-new-product/'),
      headers: getAuthHeaders(accessToken),
      body: jsonEncode(<String, dynamic>{
        'productName': productName.text,
        'purchasesPrice':
            purchasesPrice.text != '' ? int.parse(purchasesPrice.text) : 0,
        'sellingPrice':
            sellingPrice.text != '' ? int.parse(sellingPrice.text) : 0,
        'quantity': quantity.text != '' ? int.parse(quantity.text) : 0,
        'stockLevel': stockLevel.text != '' ? int.parse(stockLevel.text) : 0,
        'primaryUnit': primaryUnit.text,
        'supplierName': supplierName.text,
        'supplierNumber': supplierNumber.text,
        'supplierEmail': supplierEmail.text,
        'isService': isService,
      }),
    );

    if (response.statusCode == 201) {
      widget.resetData();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showErrorMessage(
        context: context,
        builder: (context) => const ModalFitError(),
      );
      // throw Exception('Failed to updated customer.');
    }
  }
}
