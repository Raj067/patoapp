import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/backend/sync/sync_all.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewCustomerTransaction extends StatefulWidget {
  final Function refreshData;
  const AddNewCustomerTransaction({
    Key? key,
    required this.refreshData,
  }) : super(key: key);

  @override
  State<AddNewCustomerTransaction> createState() =>
      _AddNewCustomerTransactionState();
}

class _AddNewCustomerTransactionState extends State<AddNewCustomerTransaction> {
  final addCustomerTransactionFormKey = GlobalKey<FormState>();
  // Controllers for form
  TextEditingController customerName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController openingBalance = TextEditingController();
  bool toReceive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addCustomer,
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
      body: Form(
        key: addCustomerTransactionFormKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: [
            Container(height: 15),
            TextFormField(
              controller: customerName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.customerNameRequired;
                }
                return null;
              },
              cursorColor: patowavePrimary,
              decoration: InputDecoration(
                label: Text(
                  "${AppLocalizations.of(context)!.customerName}*",
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
              controller: phoneNumber,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.phoneNumberRequired;
                }
                return null;
              },
              cursorColor: patowavePrimary,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                label: Text(
                  "${AppLocalizations.of(context)!.phoneNumber}*",
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
          ],
        ),
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
                  if (addCustomerTransactionFormKey.currentState!.validate()) {
                    showPleaseWait(
                      context: context,
                      builder: (context) => const ModalFit(),
                    );
                    _addingCustomer(
                      customerName: customerName.text,
                      phoneNumber: phoneNumber.text,
                      openingBalance: "",
                      address: "",
                      toReceive: false,
                      emailAddress: "",
                      transactionDate: "",
                    );
                  }
                },
                child: Text(
                  AppLocalizations.of(context)!.save,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addingCustomer({
    required String customerName,
    required String phoneNumber,
    required String address,
    required String emailAddress,
    required String openingBalance,
    required String transactionDate,
    required bool toReceive,
  }) async {
    // shop ID
    String? activeShop = await storage.read(key: 'activeShop');
    int shopId = int.parse(activeShop ?? '0');

    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/add-new-customer/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'customerName': customerName,
          'phoneNumber': phoneNumber,
          'address': address,
          'emailAddress': emailAddress,
          'openingBalance':
              openingBalance == "" ? 0 : int.parse(openingBalance),
          'transactionDate': transactionDate,
          'toReceive': toReceive,
          'shopId': shopId,
        }),
      );

      if (response.statusCode == 201) {
        // Only customer name and id are important
        SingleCustomer myData = SingleCustomer(
          address: '',
          email: '',
          financialData: [],
          fullName: jsonDecode(response.body)['customerName'],
          phoneNumber: '',
          amount: 0,
          id: jsonDecode(response.body)['customerId'],
          shopId: shopId,
        );

        widget.refreshData(myData);
        syncAllImportantContactOnly();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // Navigator
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
