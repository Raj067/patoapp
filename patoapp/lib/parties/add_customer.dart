import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/permission.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/business_controller.dart';
import 'package:patoapp/backend/controllers/customers_controller.dart';
import 'package:patoapp/backend/models/business_financial_data.dart';
import 'package:patoapp/backend/models/customer_list.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

class AddCustomerDialog extends StatefulWidget {
  // final Function refreshData;
  const AddCustomerDialog({Key? key}) : super(key: key);

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final addCustomerFormKey = GlobalKey<FormState>();
  final CustomerController _customerController = Get.put(CustomerController());

  final BusinessController _businessController = Get.put(BusinessController());
  // Controllers for form
  TextEditingController customerName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController openingBalance = TextEditingController();
  bool toReceive = false;
  TextEditingController dateInput = TextEditingController();
  List<Contact> contacts = [];
  fetchContacts() async {
    var status = await Permission.contacts.request();
    if (status.isGranted) {
      contacts = await ContactsService.getContacts(withThumbnails: false);
    } else {
      // ignore: use_build_context_synchronously
      permissionDenied(context);
    }
  }

  @override
  void dispose() {
    customerName.dispose();
    phoneNumber.dispose();
    address.dispose();
    emailAddress.dispose();
    openingBalance.dispose();
    dateInput.dispose();
    super.dispose();
  }

  @override
  void initState() {
    dateInput.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now()); //set the initial value of text field
    fetchContacts();
    super.initState();
  }

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
        key: addCustomerFormKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: [
            Container(height: 10),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => _selectContact(context),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: patowavePrimary.withAlpha(100),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/contacts.svg",
                            width: 33,
                            height: 33,
                          ),
                          Container(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.importCustomer,
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                AppLocalizations.of(context)!.fromContacts,
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: patowaveBlack,
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
            TextFormField(
              controller: address,
              cursorColor: patowavePrimary,
              decoration: InputDecoration(
                label: Text(
                  AppLocalizations.of(context)!.address,
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
              controller: emailAddress,
              cursorColor: patowavePrimary,
              decoration: InputDecoration(
                label: Text(
                  AppLocalizations.of(context)!.emailAddress,
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
                    controller: openingBalance,
                    cursorColor: patowavePrimary,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon:
                            const FaIcon(FontAwesomeIcons.solidCircleQuestion),
                        onPressed: () {
                          _openingBalanceToolTip(context);
                        },
                      ),
                      label: Text(
                        AppLocalizations.of(context)!.openingBalance,
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
                ),
                Container(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: dateInput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      label: Text(
                        AppLocalizations.of(context)!.date,
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

                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 5),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(DateTime.now().year + 5));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                ),
              ],
            ),
            Container(height: 15),
            Container(
              decoration: BoxDecoration(
                color: patowavePrimary.withAlpha(100),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      // index == 0 ? toReceive = true : toReceive = false;

                      decoration: toReceive
                          ? const BoxDecoration(
                              color: patowavePrimary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            )
                          : const BoxDecoration(),
                      height: 45,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            !toReceive ? toReceive = true : toReceive = false;
                          });
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!.toBeReceived,
                            style: TextStyle(
                              color: toReceive ? patowaveWhite : patowaveBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: !toReceive
                          ? const BoxDecoration(
                              color: patowavePrimary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            )
                          : const BoxDecoration(),
                      height: 45,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            !toReceive ? toReceive = true : toReceive = false;
                          });
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!.toBePaid,
                            style: TextStyle(
                              color: !toReceive ? patowaveWhite : patowaveBlack,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                  if (addCustomerFormKey.currentState!.validate()) {
                    showPleaseWait(
                      context: context,
                      builder: (context) => const ModalFit(),
                    );
                    _addingCustomer(
                      customerName: customerName.text,
                      phoneNumber: phoneNumber.text,
                      openingBalance: openingBalance.text,
                      address: address.text,
                      toReceive: toReceive,
                      emailAddress: emailAddress.text,
                      transactionDate: dateInput.text,
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

  Widget _selectContact(BuildContext context) {
    List<Widget> data = [];

    for (Contact dx in contacts) {
      String phone = dx.phones![0].value ?? '-';
      String name = dx.displayName!;
      data.add(Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        elevation: 0,
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          onTap: () {
            customerName.text = name;
            phoneNumber.text = phone;

            Navigator.pop(context);
          },
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          leading: CircleAvatar(
            backgroundColor: patowaveGreen400,
            foregroundColor: patowaveWhite,
            child: Text(name.toUpperCase()[0]),
          ),
          title: Text(name),
          subtitle: Text(phone),
        ),
      ));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.selectContact,
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
      body: ListView(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: [
          Column(children: data),
        ],
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
        int balance = openingBalance == "" ? 0 : int.parse(openingBalance);
        List<Map> financialData = toReceive
            ? [
                {
                  "name": "Payment in",
                  "description": "Opening Balance",
                  "received": balance,
                  "paid": 0,
                  "date": DateTime.now().toString(),
                }
              ]
            : [
                {
                  "name": "Payment in",
                  "description": "Opening Balance",
                  "received": 0,
                  "paid": balance,
                  "date": DateTime.now().toString(),
                }
              ];
        SingleCustomer myData = SingleCustomer(
          address: address,
          email: emailAddress,
          financialData: financialData,
          fullName: customerName,
          phoneNumber: phoneNumber,
          amount: balance,
          id: jsonDecode(response.body)['customerId'],
          shopId: shopId,
        );
        // customerChangeAdd;
        _customerController.customerChangeAdd(myData);
        // Add transaction
        FinancialData fData = FinancialData(
          date: DateTime.now(),
          isCashSale: false,
          isPaymentIn: toReceive,
          isExpenses: false,
          isPaymentOut: !toReceive,
          isPurchases: false,
          isInvoice: false,
          name: customerName,
          description: "Opening Balance",
          details: [],
          amount: balance,
          receipt: " ",
          discount: 0,
          id: "payment-${jsonDecode(response.body)['id']}",
          shopId: shopId,
        );
        if (balance > 0) {
          _businessController.businessChangeAdd(fData);
        }

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

  Future<void> _openingBalanceToolTip(
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
              "Amount to be paid/received from the contact before adding them to Patowave"),
        );
      },
    );
  }
}
