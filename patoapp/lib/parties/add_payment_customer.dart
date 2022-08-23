import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/customers_controller.dart';
import 'package:patoapp/backend/db/db_customer.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'dart:math';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddPaymentCustomerDialog extends StatefulWidget {
  final SingleCustomer customer;
  final bool isPaymentIn;
  const AddPaymentCustomerDialog({
    Key? key,
    required this.customer,
    required this.isPaymentIn,
  }) : super(key: key);

  @override
  State<AddPaymentCustomerDialog> createState() =>
      _AddPaymentCustomerDialogState();
}

class _AddPaymentCustomerDialogState extends State<AddPaymentCustomerDialog> {
  int _value = 1;
  String paidAmount = '0';
  String receivedAmount = '0';
  int receiptNo = Random().nextInt(10000);
  final paidAmountFormKey1 = GlobalKey<FormState>();
  final receivedAmountformKey1 = GlobalKey<FormState>();
  final CustomerController _customerController = Get.put(CustomerController());

  TextEditingController amountReceived = TextEditingController();
  TextEditingController amountPaid = TextEditingController();
  TextEditingController paymentInDesc = TextEditingController(text: "");
  TextEditingController paymentOutDesc = TextEditingController(text: "");
  @override
  void dispose() {
    amountReceived.dispose();
    amountPaid.dispose();
    paymentInDesc.dispose();
    paymentOutDesc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _value = widget.isPaymentIn ? 1 : 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.payments,
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
      ),
      body: Column(
        children: [
          Row(
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
                        Text(AppLocalizations.of(context)!.paymentIn),
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
                        Text(AppLocalizations.of(context)!.paymentOut),
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
                      _value == 1
                          ? "${AppLocalizations.of(context)!.receipt} No: $receiptNo"
                          : "${AppLocalizations.of(context)!.receipt} No: $receiptNo",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "${AppLocalizations.of(context)!.date}: ${DateFormat("dd-MM-yyyy").format(DateTime.now())}",
                      style: const TextStyle(
                          fontStyle: FontStyle.italic, fontSize: 14),
                    ),
                  ),
                ),
              ]),
            ],
          ),
          const Divider(height: 0),
          _value == 1
              ? _paymentIn(widget.customer)
              : _paymentOut(widget.customer),
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
                    {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (receivedAmountformKey1.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        showPleaseWait(
                          context: context,
                          builder: (context) => const ModalFit(),
                        );
                        _addPaymentCustomer(
                          isPaymentIn: true,
                          amount: int.parse(amountReceived.text),
                          description: paymentInDesc.text == ""
                              ? "Payment In"
                              : paymentInDesc.text,
                          id: widget.customer.id,
                        );
                      }
                    }
                  } else {
                    // for payment out
                    {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (paidAmountFormKey1.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        showPleaseWait(
                          context: context,
                          builder: (context) => const ModalFit(),
                        );
                        _addPaymentCustomer(
                          isPaymentIn: false,
                          amount: int.parse(amountPaid.text),
                          description: paymentOutDesc.text == ""
                              ? "Payment Out"
                              : paymentOutDesc.text,
                          id: widget.customer.id,
                        );
                      }
                    }
                  }
                },
                child: Text(AppLocalizations.of(context)!.addPayment),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _paymentIn(SingleCustomer customer) {
    return Expanded(
      child: Form(
        key: receivedAmountformKey1,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: [
            Container(height: 15),
            TextFormField(
              controller: amountReceived,
              cursorColor: patowavePrimary,
              onChanged: (val) {
                setState(() {
                  receivedAmount = val;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.amountReceivedRequired;
                }
                return null;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                label: Text(
                  AppLocalizations.of(context)!.amountReceived,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 14),
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            Container(height: 15),
            Container(
              decoration: BoxDecoration(
                color: patowaveBlack.withAlpha(30),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Text(
                  customer.fullName,
                  style: const TextStyle(
                    // color: Color.fromARGB(255, 124, 124, 124),
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.totalAmount,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tsh: $receivedAmount",
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(height: 20),
            TextFormField(
              controller: paymentInDesc,
              cursorColor: patowavePrimary,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 3,
              maxLines: null,
              decoration: InputDecoration(
                label: Text(
                  AppLocalizations.of(context)!.addNote,
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
    );
  }

  _paymentOut(SingleCustomer customer) {
    return Expanded(
      child: Form(
        key: paidAmountFormKey1,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: [
            Container(height: 15),
            TextFormField(
              controller: amountPaid,
              cursorColor: patowavePrimary,
              onChanged: (val) {
                setState(() {
                  paidAmount = val;
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.amountPaidRequired;
                }
                return null;
              },
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                label: Text(
                  AppLocalizations.of(context)!.amountPaid,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 14),
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
            Container(height: 15),
            Container(
              decoration: BoxDecoration(
                color: patowaveBlack.withAlpha(30),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Text(
                  customer.fullName,
                  style: const TextStyle(
                    // color: Color.fromARGB(255, 124, 124, 124),
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.totalAmount,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Tsh: $paidAmount",
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Container(height: 20),
            TextFormField(
              controller: paymentOutDesc,
              cursorColor: patowavePrimary,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 3,
              maxLines: null,
              decoration: InputDecoration(
                label: Text(
                  AppLocalizations.of(context)!.addNote,
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
    );
  }

  _addPaymentCustomer({
    required int amount,
    required String description,
    required bool isPaymentIn,
    required int id,
  }) async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');
    String accessToken = await storage.read(key: 'access') ?? "";

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/adding-payment-customer/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'amount': amount,
          'description': description,
          'isPaymentIn': isPaymentIn,
          'id': id,
          "receiptNo": receiptNo,
          'shopId': shopId,
        }),
      );

      if (response.statusCode == 201) {
        List<Map<String, dynamic>> customers = await DBHelperCustomer.query();
        List<SingleCustomer> finalData =
            customers.map((e) => fromJsonCustomer(e)).toList();
        SingleCustomer myData = finalData.firstWhere(
            (element) => element.id == jsonDecode(response.body)['customerId']);

        Map payment = isPaymentIn
            ? {
                "name": "Payment in",
                "description": "Payment in",
                "received": amount,
                "paid": 0,
                "date": DateTime.now().toIso8601String(),
              }
            : {
                "name": "Payment Out",
                "description": "Payment Out",
                "received": 0,
                "paid": amount,
                "date": DateTime.now().toIso8601String(),
              };
        if (isPaymentIn) {
          myData.amount -= amount;
        } else {
          myData.amount += amount;
        }
        myData.financialData = [payment, ...myData.financialData];
        _customerController.customerChangeUpdater(myData);

        Get.back();
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
      Get.back();
      showTimeOutMessage(
        context: context,
        builder: (context) => const ModalFitTimeOut(),
      );
    }
  }
}
