import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/accounts/signup.dart';
import 'package:patoapp/pages/index.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  final loginFormKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);
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
                            // Navigator.popUntil(context, (route) => false);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const HomePage(),
                              ),
                            );
                            var prefs = await SharedPreferences.getInstance();
                            prefs.setBool('isLogin', true);
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
}
