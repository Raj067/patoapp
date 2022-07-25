import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patoapp/accounts/login.dart';
import 'package:patoapp/accounts/signup.dart';
import 'package:patoapp/themes/light_theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

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
                left: 10,
                right: 10,
                top: 300,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Go Paperless With",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(height: 5),
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Patowave",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(height: 15),
                    const Center(
                      child: SizedBox(
                        width: 200,
                        child: Center(
                          child: Text(
                            "Ditch paper and pens,go digital with patowave and put your business at finguretips",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                top: 50,
                child: SvgPicture.asset(
                  "assets/onboarding/launch.svg",
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                bottom: 80,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const SignupPage(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                        child: const Text(
                          "SignUp",
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
                bottom: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          // MaterialStateProperty<Color?>? backgroundColor,
                          backgroundColor:
                              MaterialStateProperty.all(patowaveGreen200),
                          elevation: MaterialStateProperty.all(0),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => const LoginPage(),
                              fullscreenDialog: true,
                            ),
                          );
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
            ],
          ),
        ),
      ),
    );
  }
}
