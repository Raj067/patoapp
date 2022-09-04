import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:patoapp/accounts/language_account.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/controllers/profile_controller.dart';
import 'package:patoapp/backend/models/profile_details.dart';
// import 'package:patoapp/pages/index.dart';
import 'package:patoapp/themes/light_theme.dart';

class SetAccountPage extends StatefulWidget {
  const SetAccountPage({Key? key}) : super(key: key);

  @override
  State<SetAccountPage> createState() => _SetAccountPageState();
}

class _SetAccountPageState extends State<SetAccountPage> {
  final setAccountFormKey = GlobalKey<FormState>();

  ProfileController get _profileController => Get.put(ProfileController());
  TextEditingController businessName = TextEditingController();
  TextEditingController businessEmail = TextEditingController();
  TextEditingController businessAddress = TextEditingController();
  TextEditingController instagramName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Form(
        key: setAccountFormKey,
        child: SingleChildScrollView(
          child: SizedBox(
            // color: Color.fromARGB(255, 221, 144, 144),
            height: MediaQuery.of(context).size.height > 500
                ? MediaQuery.of(context).size.height
                : 500,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  right: 10,
                  top: 30,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Words have Meaning, Name Have Power",
                          style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Container(height: 15),
                      const Text(
                        "It's the little details that make big things happen",
                      ),
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
                        cursorColor: patowavePrimary,
                        controller: businessEmail,
                        decoration: const InputDecoration(
                          label: Text(
                            "Business Email",
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
                        cursorColor: patowavePrimary,
                        controller: instagramName,
                        decoration: const InputDecoration(
                          label: Text(
                            "Instagram Name",
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
                  ),
                ),
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ButtonStyle(
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
                          onPressed: () async {
                            if (setAccountFormKey.currentState!.validate()) {
                              _settingAccount(context);
                            }
                          },
                          child: const Text(
                            "Finish",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _settingAccount(BuildContext context) async {
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
        // Activate shop
        ProfileData profile = ProfileData(
          id: jsonDecode(response.body)['id'],
          businessName: businessName.text,
          businessEmail: businessEmail.text,
          businessAddress: businessAddress.text,
          instagramName: instagramName.text,
        );
        // widget.refreshData(); profileChangeAdd
        _profileController.profileChangeAdd(profile);
        _profileController.myProfileChangeUpdaterProfile(profile);
        await storage.write(
            key: "activeShop", value: "${jsonDecode(response.body)['id']}");
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        await storage.write(key: "shopName", value: businessName.text);

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const LanguageAccount(),
            ),
            (route) => false);
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
