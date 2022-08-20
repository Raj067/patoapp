import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/products_controller.dart';
import 'package:patoapp/backend/models/product_list.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  final ProductController _productController = Get.put(ProductController());

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
        title: Text(
          AppLocalizations.of(context)!.addItem,
          style: const TextStyle(color: Colors.white),
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
        // actions: widget.isProductImage
        //     ? [
        //         IconButton(
        //           icon: const Icon(Icons.add_a_photo),
        //           onPressed: () {},
        //         ),
        //       ]
        //     : [],
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
                        Text(AppLocalizations.of(context)!.product),
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
                        Text(AppLocalizations.of(context)!.service),
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
          _value == 1 ? _addProduct() : _comingSoon(), // _addService(),
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
                child: Text(AppLocalizations.of(context)!.addItem),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _comingSoon() {
    return const Expanded(
      child: Center(
        child: Text(
          'Coming Soon',
          style: TextStyle(fontSize: 18),
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
                    return AppLocalizations.of(context)!.itemNameIsRequired;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text(
                    "${AppLocalizations.of(context)!.itemName}*",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: const OutlineInputBorder(
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
                          decoration: InputDecoration(
                            label: Text(
                              AppLocalizations.of(context)!.itemCode,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
                            ),
                            border: const OutlineInputBorder(
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
                    return AppLocalizations.of(context)!.pleaseSelectUnit;
                  }
                  return null;
                },
                value: selectedPrimaryUnit,
                selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                scrollbarAlwaysShow: true,
                dropdownMaxHeight: 200,
                decoration: InputDecoration(
                  label: Text(
                    '${AppLocalizations.of(context)!.selectUnit}*',
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 14),
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
              Text(
                AppLocalizations.of(context)!.pricingOtherDetails,
                style:
                    const TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
              ),
              Container(height: 15),
              TextFormField(
                cursorColor: patowavePrimary,
                controller: sellingPrice,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.salesPriceRequired;
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  label: Text(
                    "${AppLocalizations.of(context)!.salesPrice}*",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: const OutlineInputBorder(
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
                    return AppLocalizations.of(context)!.purchasesPriceRequired;
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  label: Text(
                    "${AppLocalizations.of(context)!.purchasesPrice}*",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: const OutlineInputBorder(
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
                        label: Text(
                          AppLocalizations.of(context)!.quantity,
                          style: const TextStyle(
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
                        label: Text(
                          AppLocalizations.of(context)!.stockLevel,
                          style: const TextStyle(
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
                Text(
                  AppLocalizations.of(context)!.supplierContact,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 14),
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
                          decoration: InputDecoration(
                            label: Text(
                              AppLocalizations.of(context)!.supplierName,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
                            ),
                            border: const OutlineInputBorder(
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
                          decoration: InputDecoration(
                            label: Text(
                              AppLocalizations.of(context)!.phoneNumber,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
                            ),
                            border: const OutlineInputBorder(
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
                          decoration: InputDecoration(
                            label: Text(
                              AppLocalizations.of(context)!.email,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 14),
                            ),
                            border: const OutlineInputBorder(
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
                    return AppLocalizations.of(context)!.serviceNameIsRequired;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text(
                    "${AppLocalizations.of(context)!.serviceName}*",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: const OutlineInputBorder(
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
                    return AppLocalizations.of(context)!
                        .serviceChargeIsRequired;
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: InputDecoration(
                  label: Text(
                    "${AppLocalizations.of(context)!.serviceCharge}*",
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: const OutlineInputBorder(
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
                    return AppLocalizations.of(context)!
                        .pleaseSelectServiceUnit;
                  }
                  return null;
                },
                // value: selectedPrimaryUnit,
                selectedItemHighlightColor: patowavePrimary.withAlpha(50),
                scrollbarAlwaysShow: true,
                dropdownMaxHeight: 200,
                decoration: InputDecoration(
                  label: Text(
                    '${AppLocalizations.of(context)!.serviceUnit}*',
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 14),
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
                items: serviceUnit
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
              Container(height: 15),
              TextFormField(
                cursorColor: patowavePrimary,
                controller: supplierName,
                decoration: InputDecoration(
                  label: Text(
                    AppLocalizations.of(context)!.description,
                    style: const TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: const OutlineInputBorder(
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
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');
    String accessToken = await storage.read(key: 'access') ?? "";

    try {
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
          'shopId': shopId,
        }),
      );

      if (response.statusCode == 201) {
        SingleProduct myData = SingleProduct(
          shopId: shopId,
          isService: isService,
          productUnit: primaryUnit.text,
          id: jsonDecode(response.body)['productId'],
          productName: productName.text,
          quantity: quantity.text != '' ? int.parse(quantity.text) : 0,
          purchasesPrice:
              purchasesPrice.text != '' ? int.parse(purchasesPrice.text) : 0,
          sellingPrice:
              sellingPrice.text != '' ? int.parse(sellingPrice.text) : 0,
          stockLevel: stockLevel.text != '' ? int.parse(stockLevel.text) : 0,
          supplierName: supplierName.text,
          supplierContact: supplierNumber.text,
          thumbnail: '',
        );
        await _productController.addProduct(myData);
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
    } catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }
}
