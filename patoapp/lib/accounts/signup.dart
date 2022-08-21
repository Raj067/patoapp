import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patoapp/accounts/login.dart';
import 'package:patoapp/accounts/set_account.dart';
import 'package:patoapp/animations/error.dart';
import 'package:patoapp/animations/please_wait.dart';
import 'package:patoapp/animations/signup_authenticate.dart';
import 'package:patoapp/animations/time_out.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final signupFormKey = GlobalKey<FormState>();

  bool initialValue = true;
  TextEditingController phone = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  // regular expression to check if string
  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String password = pass.trim();
    if (passValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          // color: Color.fromARGB(255, 221, 144, 144),
          height: MediaQuery.of(context).size.height > 500
              ? MediaQuery.of(context).size.height
              : 500,
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
                  key: signupFormKey,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(height: 15),
                      TextFormField(
                        controller: phone,
                        cursorColor: patowavePrimary,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          } else if (!value.startsWith('0')) {
                            return 'Phone number should start with 0';
                          } else if (value.length != 10) {
                            return 'Invalid phone number';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          icon: Text('+255'),
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
                        controller: password1,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          } else {
                            //call function to check password
                            bool result = validatePassword(value);
                            if (result) {
                              // create account event
                              return null;
                            } else {
                              return "Password should contain capital latter, \nsmall letter, number & special character";
                            }
                          }
                        },
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
                      Container(height: 15),
                      TextFormField(
                        controller: password2,
                        cursorColor: patowavePrimary,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          if (password1.text != password2.text) {
                            return "The password should match";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          label: Text(
                            "Re enter Password",
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
                      // Container(height: 15),
                      Row(
                        children: [
                          Checkbox(
                            value: initialValue,
                            onChanged: (val) {
                              setState(() {
                                initialValue
                                    ? initialValue = false
                                    : initialValue = true;
                              });
                            },
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('By signing up, you agree to our '),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        launchUrl(Uri.parse(
                                            '${baseUrl}privacy-policy/'));
                                      },
                                      child: const Text(
                                        'privacy policy ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: patowavePrimary,
                                        ),
                                      ),
                                    ),
                                    const Text('and'),
                                    InkWell(
                                      onTap: () async {
                                        launchUrl(
                                          Uri.parse(
                                              '${baseUrl}terms-conditions/'),
                                        );
                                      },
                                      child: const Text(
                                        ' Terms of conditions',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: patowavePrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // TextButton(
                          //   onPressed: () {},
                          //   child: const Text(
                          //     "",
                          //     textAlign: TextAlign.start,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
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
                        onPressed: () {
                          if (signupFormKey.currentState!.validate()) {
                            _signUpUser(context);
                          }
                        },
                        child: const Text(
                          "Sign Up",
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
                          builder: (BuildContext context) => const LoginPage(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: const Text("Already have an  account? Login"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _signUpUser(BuildContext context) async {
    showPleaseWait(
      context: context,
      builder: (context) => const ModalFit(),
    );
    try {
      final response = await http.post(
        Uri.parse('${baseUrl}api/signup-user/'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'username': phone.text,
          'password': password1.text,
        }),
      );
      if (response.statusCode == 201) {
        // Create storage
        Map tokens = jsonDecode(response.body);
        // Write value
        await storage.write(key: "refresh", value: tokens['refresh']);
        await storage.write(key: "access", value: tokens['access']);

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const SetAccountPage(),
            ),
            (route) => false);
      } else if (response.statusCode == 500) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        showAuthenticateMessage(
          context: context,
          builder: (context) => const ModalFitAuthenticate(),
        );
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
