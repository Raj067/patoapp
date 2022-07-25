import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/accounts/signup.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/login_authenticate.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/pages/index.dart';
import 'package:patoapp/themes/light_theme.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginFormKey = GlobalKey<FormState>();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          // color: Color.fromARGB(255, 221, 144, 144),
          height: MediaQuery.of(context).size.height > 600
              ? MediaQuery.of(context).size.height
              : 600,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 10,
                right: 10,
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                top: 100,
                child: Form(
                  key: loginFormKey,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login To Patowave",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(height: 5),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Welcome back!",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Container(height: 15),
                      TextFormField(
                        cursorColor: patowavePrimary,
                        controller: phoneNumber,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          label: Text(
                            "Phone Number",
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
                        controller: password,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text(
                            "Password",
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
                      // Container(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // print(MediaQuery.of(context).size.height);
                          },
                          child: const Text("Forgot Password?"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  left: 10,
                  right: 10,
                  bottom: 120,
                  child: SvgPicture.asset(
                    "assets/onboarding/welcome.svg",
                    // width: 25,
                    // height: 25,
                  )),
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
                          // Validate returns true if the form is valid, or false otherwise.
                          if (loginFormKey.currentState!.validate()) {
                            _loginUser(context);
                          }
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                bottom: 0,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const SignupPage(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: const Text("Don't have account?"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _loginUser(BuildContext context) async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    final response = await http.post(
      Uri.parse('${baseUrl}api/token/'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'username': phoneNumber.text,
        'password': password.text,
      }),
    );
    if (response.statusCode == 200) {
      // Create storage
      Map tokens = jsonDecode(response.body);
      // Write value
      await storage.write(key: "refresh", value: tokens['refresh']);
      await storage.write(key: "access", value: tokens['access']);
      await storage.write(key: "shopName", value: "true");
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage(),
        ),
      );
    } else if (response.statusCode == 401) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showLoginAuthenticateMessage(
        context: context,
        builder: (context) => const ModalFitLoginAuthenticate(),
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showErrorMessage(
        context: context,
        builder: (context) => const ModalFitError(),
      );
    }
  }
}
