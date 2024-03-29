import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/business_controller.dart';
import 'package:patoapp/backend/controllers/products_controller.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/backend/models/product_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patoapp/themes/light_theme.dart';

class ProductsCart extends StatefulWidget {
  final List<SingleProduct> products;
  final Function resetData;
  const ProductsCart(
      {Key? key, required this.products, required this.resetData})
      : super(key: key);

  @override
  State<ProductsCart> createState() => _ProductsCartState();
}

class _ProductsCartState extends State<ProductsCart> {
  double totalAmount = 0;
  int balanceDue = 0;
  double discount = 0;
  DateTime transactionDate = DateTime.now();
  final ProductController _productController = Get.put(ProductController());
  final BusinessController _businessController = Get.put(BusinessController());

  int receiptNo = Random().nextInt(10000);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.cashSales,
          style: const TextStyle(color: Colors.white),
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
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: const Icon(
        //       Icons.cancel,
        //       color: patowaveWhite,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        children: [
          const Divider(height: 0),
          Table(
            border: TableBorder.all(
              width: 1.0,
              color: Colors.grey.withAlpha(100),
            ),
            children: [
              TableRow(children: [
                InkWell(
                  onTap: () {
                    Get.bottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Theme.of(context).cardColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(height: 10),
                            TextFormField(
                              initialValue: "$receiptNo",
                              cursorColor: patowavePrimary,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (val) {
                                if (val != '') {
                                  setState(() {
                                    receiptNo = int.parse(val);
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                label: Text(
                                  AppLocalizations.of(context)!.receipt,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                  ),
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
                                      Get.back();
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.save,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(height: 10),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "${AppLocalizations.of(context)!.receipt} No $receiptNo",
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: transactionDate,
                        firstDate: DateTime(DateTime.now().year - 3),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(DateTime.now().year + 1),
                        initialDatePickerMode: DatePickerMode.day,
                        helpText: "Select Transaction  Date");

                    if (pickedDate != null) {
                      setState(() {
                        transactionDate = pickedDate;
                      });
                    } else {}
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "${AppLocalizations.of(context)!.date}: ${DateFormat("dd-MM-yyyy").format(transactionDate)}",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
          const Divider(height: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ListView(
                children: [
                  Container(height: 10),
                  _allSelectedProducts(context),
                  _discount(),
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.discount,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Tsh: ${formatter.format(discount.toInt())}",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.totalAmount,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Tsh: ${formatter.format(totalAmount.toInt() - discount.toInt())}",
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(height: 10),
                ],
              ),
            ),
          ),
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
                  showPleaseWait(
                    context: context,
                    builder: (context) => const ModalFit(),
                  );
                  // A list of products
                  List<Map> items = [];
                  for (var element in widget.products) {
                    if (element.addedToCart > 0) {
                      items.add({
                        "id": element.id,
                        "price": element.getTotalPrice(),
                        "quantity": element.addedToCart,
                      });
                    }
                  }
                  submitSalesData(
                    amount: totalAmount.toInt() - discount.toInt(),
                    discount: discount,
                    items: items,
                  );
                },
                child: Text(AppLocalizations.of(context)!.save),
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
              ),
              Container(width: 5),
              Container(
                width: 30,
                height: 35,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(52, 255, 70, 57),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.percent,
                    color: patowaveErrorRed,
                    size: 16,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextFormField(
                    // controller: firstValue,
                    cursorColor: patowavePrimary,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (val) {
                      // secondValue.text = "";
                      if (val != "") {
                        discount = int.parse(val) / 100 * totalAmount;
                        setState(() {});
                      } else {
                        discount = 0;
                        setState(() {});
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "0",
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          color: patowavePrimary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(width: 10),
              Container(
                width: 30,
                height: 35,
                decoration: const BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Tsh:",
                    style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 35,
                  child: TextFormField(
                    cursorColor: patowavePrimary,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onChanged: (val) {
                      // firstValue.text = "";
                      if (val != "") {
                        discount = double.parse(val);
                        setState(() {});
                      } else {
                        discount = 0;
                        setState(() {});
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "0.00",
                      contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        borderSide: BorderSide(
                          color: patowavePrimary,
                          width: 2,
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

  Widget _allSelectedProducts(BuildContext context) {
    List<Widget> data = [];
    int price = 0;
    for (var element in widget.products) {
      if (element.addedToCart > 0) {
        price += element.getTotalPrice();
        data.add(_singleSelectedProduct(context, element));
      }
    }
    setState(() {
      totalAmount = price.toDouble();
    });
    return Column(children: data);
  }

  _singleSelectedProduct(BuildContext context, SingleProduct product) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    product.productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  "Tsh ${formatter.format(product.getTotalPrice())}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Subtotal:",
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  "${product.addedToCart} ${product.productUnit} x Tsh ${formatter.format(product.sellingPrice)} = Tsh ${formatter.format(product.getTotalPrice())}",
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  submitSalesData({
    required int amount,
    required double discount,
    required List<Map> items,
  }) async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');
    String accessToken = await storage.read(key: 'access') ?? "";

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/cash-sales-transaction/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'amount': amount,
          'discount': discount,
          'items': items,
          'receiptNo': receiptNo,
          'shopId': shopId,
          "transactionDate": DateFormat("dd-MM-yyyy").format(transactionDate),
        }),
      );

      if (response.statusCode == 201) {
        // updating the data status
        for (var element in widget.products) {
          if (element.addedToCart > 0) {
            element.quantity = element.quantity - element.addedToCart;
            _productController.productChangeUpdater(element);
          }
        }
        widget.resetData();

        // add transaction
        FinancialData myData = FinancialData(
          date: DateTime.parse(jsonDecode(response.body)['date']),
          isCashSale: true,
          isPaymentIn: false,
          isExpenses: false,
          isPaymentOut: false,
          isPurchases: false,
          isInvoice: false,
          name: "Cash Sales",
          description: "Cash Sales",
          details: jsonDecode(response.body)['details'],
          amount: (totalAmount - discount).toInt(),
          receipt: "$receiptNo",
          discount: discount.toInt(),
          id: jsonDecode(response.body)['id'],
          shopId: shopId,
        );
        _businessController.businessChangeAdd(myData);
        Get.back();
        Get.back();
      } else {
        Get.back();
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
