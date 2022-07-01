import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/accounts/signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                top: 30,
                left: 100,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/onboarding/welcome.svg",
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
              Positioned(
                left: 10,
                right: 10,
                top: 100,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Login To Patowave",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Welcome back!",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(height: 10),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
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
                    ),
                    Container(height: 10),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const LoginPage(),
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
