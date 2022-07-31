import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/themes/light_theme.dart';

class AddNewShop extends StatefulWidget {
  final Function refreshData;
  const AddNewShop({Key? key, required this.refreshData}) : super(key: key);

  @override
  State<AddNewShop> createState() => _AddNewShopState();
}

class _AddNewShopState extends State<AddNewShop> {
  final addShopFormKey = GlobalKey<FormState>();

  TextEditingController businessName = TextEditingController();
  TextEditingController businessEmail = TextEditingController();
  TextEditingController businessAddress = TextEditingController();
  TextEditingController instagramName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Shop',
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
          key: addShopFormKey,
          child: ListView(
            children: [
              Container(height: 15),
              TextFormField(
                controller: businessName,
                cursorColor: patowavePrimary,
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Business Name is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Business Name*",
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
                controller: businessEmail,
                decoration: const InputDecoration(
                  label: Text(
                    "Business Email",
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
                controller: businessAddress,
                validator: (value) {
                  if (value == null || value == "") {
                    return 'Business Address is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Business Address*",
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
                controller: instagramName,
                decoration: const InputDecoration(
                  label: Text(
                    "Instagram Name",
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
                  if (addShopFormKey.currentState!.validate()) {
                    _addShop(context);
                  }
                },
                child: const Text(
                  "Add Shop",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _addShop(BuildContext context) async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    String accessToken = await storage.read(key: 'access') ?? "";
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/setting-account/'),
        headers: getAuthHeaders(accessToken),
        body: jsonEncode(<String, dynamic>{
          'businessName': businessName.text,
          'businessEmail': businessEmail.text,
          'businessAddress': businessAddress.text,
          'instagramName': instagramName.text,
        }),
      );

      if (response.statusCode == 201) {
        widget.refreshData();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        await storage.write(key: "shopName", value: businessName.text);
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
