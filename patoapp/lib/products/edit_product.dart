import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/data/product_list.dart';
import 'package:patoapp/themes/light_theme.dart';

class EditProduct extends StatefulWidget {
  final SingleProduct product;
  final bool isProductImage;
  final bool isProductBarcode;
  final Function resetData;
  const EditProduct({
    Key? key,
    required this.product,
    required this.isProductImage,
    required this.isProductBarcode,
    required this.resetData,
  }) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  String? selectedPrimaryUnit;

  String? selectedValue;
  bool _isSupplierActivated = false;
  final editProductFormKey = GlobalKey<FormState>();
  final editServicesFormKey = GlobalKey<FormState>();

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
  void initState() {
    super.initState();
    productName.text = widget.product.productName;
    purchasesPrice.text = "${widget.product.purchasesPrice}";
    sellingPrice.text = "${widget.product.sellingPrice}";
    quantity.text = "${widget.product.quantity}";
    stockLevel.text = "${widget.product.stockLevel}";
    primaryUnit.text = widget.product.productUnit;
    supplierName.text = widget.product.supplierName;
    supplierNumber.text = widget.product.supplierContact;
    supplierEmail.text = widget.product.supplierEmail;
  }

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
          widget.product.isService ? _editService() : _editProduct(),
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
                  if (widget.product.isService) {
                    if (editServicesFormKey.currentState!.validate()) {
                      _submitProduct();
                    }
                  } else {
                    if (editProductFormKey.currentState!.validate()) {
                      _submitProduct();
                    }
                  }
                },
                child: const Text(
                  "Edit Item",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _editProduct() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: editProductFormKey,
          child: ListView(
            children: [
              Container(height: 15),
              TextFormField(
                controller: productName,
                cursorColor: patowavePrimary,
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
              Container(height: 15),
              widget.isProductBarcode
                  ? Column(
                      children: [
                        TextFormField(
                          initialValue: "${widget.product.productCode}",
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
                        Container(height: 15),
                      ],
                    )
                  : Container(),
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
                  //Do something when changing the item if you want.
                  primaryUnit.text = value.toString();
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
                controller: sellingPrice,
                cursorColor: patowavePrimary,
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
                controller: purchasesPrice,
                cursorColor: patowavePrimary,
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
                      controller: quantity,
                      cursorColor: patowavePrimary,
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
                      controller: stockLevel,
                      cursorColor: patowavePrimary,
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
                          controller: supplierName,
                          cursorColor: patowavePrimary,
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
                          controller: supplierNumber,
                          cursorColor: patowavePrimary,
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
                          controller: supplierEmail,
                          cursorColor: patowavePrimary,
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

  _editService() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: editServicesFormKey,
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
          content: Text("Item available before start using Patowave"),
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

  _submitProduct() async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    String accessToken = await storage.read(key: 'access') ?? "";
    final response = await http.post(
      Uri.parse('${baseUrl}api/edit-product/'),
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
        'id': widget.product.id,
      }),
    );

    if (response.statusCode == 201) {
      widget.resetData();
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
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
