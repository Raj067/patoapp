import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/permission.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/customers_controller.dart';
import 'package:patoapp/backend/models/customer_list.dart';
// import 'package:patoapp/backend/sync/sync_all.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final CustomerController _customerController = Get.put(CustomerController());
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
  void initState() {
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
        key: addCustomerTransactionFormKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: [
            Container(height: 15),
            InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
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
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        // Text(
                        //   AppLocalizations.of(context)!.selectContact,
                        //   style: const TextStyle(
                        //       fontWeight: FontWeight.bold, fontSize: 16),
                        // ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return data[index];
                            },
                          ),
                        ),
                      ],
                    ),
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

        _customerController.customerChangeAdd(myData);
        // updating the previous instance
        widget.refreshData(myData);
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
