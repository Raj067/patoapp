import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:toggle_switch/toggle_switch.dart';
// import 'package:contacts_service/contacts_service.dart';

class AddCustomerDialog extends StatefulWidget {
  final Function refreshData;
  const AddCustomerDialog({Key? key, required this.refreshData})
      : super(key: key);

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final addCustomerFormKey = GlobalKey<FormState>();
  // Controllers for form
  TextEditingController customerName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController openingBalance = TextEditingController();
  bool toReceive = false;
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = DateFormat('yyyy-MM-dd')
        .format(DateTime.now()); //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Customer',
          style: TextStyle(color: Colors.white),
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: addCustomerFormKey,
          child: ListView(
            children: [
              Container(height: 10),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () async {
                  // if (await Permission.contacts.request().isGranted) {
                  //   // Either the permission was already granted before or the user just granted it.
                  //   List<Contact> contacts = await ContactsService.getContacts(
                  //       withThumbnails: false);
                  //   print(contacts);
                  // }
                  // List<Contact> contacts =
                  //     await ContactsService.getContacts(withThumbnails: false);
                  // print(contacts);
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
                              children: const [
                                Text(
                                  'Import Customer',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'From Contacts',
                                  style: TextStyle(
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
                    return 'Customer Name is required';
                  }
                  return null;
                },
                cursorColor: patowavePrimary,
                decoration: const InputDecoration(
                  label: Text(
                    "Customer Name*",
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
                controller: phoneNumber,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
                cursorColor: patowavePrimary,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  label: Text(
                    "Phone Number*",
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
                controller: address,
                cursorColor: patowavePrimary,
                decoration: const InputDecoration(
                  label: Text(
                    "Address",
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
                controller: emailAddress,
                cursorColor: patowavePrimary,
                decoration: const InputDecoration(
                  label: Text(
                    "Email Address",
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
                      controller: openingBalance,
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
                            _openingBalanceToolTip(context);
                          },
                        ),
                        label: const Text(
                          "Opening Balance",
                          style: TextStyle(
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
                      decoration: const InputDecoration(
                        label: Text(
                          "Date",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                        ),
                        border: OutlineInputBorder(
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
                              "To receive",
                              style: TextStyle(
                                color:
                                    toReceive ? patowaveWhite : patowaveBlack,
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
                              "To be paid",
                              style: TextStyle(
                                color:
                                    !toReceive ? patowaveWhite : patowaveBlack,
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
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 16),
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
    final response = await http.post(
      Uri.parse('${baseUrl}api/add-new-customer/'),
      headers: authHeaders,
      body: jsonEncode(<String, dynamic>{
        'customerName': customerName,
        'phoneNumber': phoneNumber,
        'address': address,
        'emailAddress': emailAddress,
        'openingBalance': openingBalance == "" ? 0 : int.parse(openingBalance),
        'transactionDate': transactionDate,
        'toReceive': toReceive,
      }),
    );

    if (response.statusCode == 201) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      widget.refreshData();
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
