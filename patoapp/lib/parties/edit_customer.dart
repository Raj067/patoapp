import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/data/customer_list.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EditCustomer extends StatefulWidget {
  final Function refreshData;
  final SingleCustomer customer;
  const EditCustomer({
    Key? key,
    required this.customer,
    required this.refreshData,
  }) : super(key: key);

  @override
  State<EditCustomer> createState() => _EditCustomerState();
}

class _EditCustomerState extends State<EditCustomer> {
  final editCustomerFormKey = GlobalKey<FormState>();

  // Controllers for form
  TextEditingController customerName = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();

  TextEditingController address = TextEditingController(text: "");

  TextEditingController emailAddress = TextEditingController(text: "");
  @override
  void initState() {
    super.initState();
    customerName.text = widget.customer.fullName;
    phoneNumber.text = widget.customer.phoneNumber;
    address.text = widget.customer.address;
    emailAddress.text = widget.customer.email;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Customer',
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
          key: editCustomerFormKey,
          child: ListView(
            children: [
              Container(height: 15),
              TextFormField(
                controller: customerName,
                cursorColor: patowavePrimary,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Customer Name is required';
                  }
                  return null;
                },
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
                cursorColor: patowavePrimary,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
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
                  // Validate returns true if the form is valid, or false otherwise.
                  if (editCustomerFormKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    showPleaseWait(
                      context: context,
                      builder: (context) => const ModalFit(),
                    );
                    _editingCustomer(
                      customerName: customerName.text,
                      emailAddress: emailAddress.text,
                      id: widget.customer.id,
                      phoneNumber: phoneNumber.text,
                      address: address.text,
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

  _editingCustomer({
    required String customerName,
    required String phoneNumber,
    required String address,
    required String emailAddress,
    required int id,
  }) async {
    String accessToken = await storage.read(key: 'access') ?? "";
    final response = await http.post(
      Uri.parse('${baseUrl}api/edit-existing-customer/'),
      headers: getAuthHeaders(accessToken),
      body: jsonEncode(<String, dynamic>{
        'customerName': customerName,
        'phoneNumber': phoneNumber,
        'address': address,
        'emailAddress': emailAddress,
        'id': id,
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
}
