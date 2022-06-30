import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:patoapp/themes/light_theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              left: 10,
              right: 10,
              top: 50,
              child: Column(
                children: [
                  const Text(
                    "Login To Patowave",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Welcome back!",
                    style: TextStyle(
                      fontSize: 12,
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
                  Container(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Forgot Password?"),
                  )
                ],
              ),
            ),
            Positioned(
                left: 10,
                right: 10,
                bottom: 100,
                child: SvgPicture.asset(
                  "assets/onboarding/welcome.svg",
                  // width: 25,
                  // height: 25,
                )),
            Positioned(
              left: 10,
              right: 10,
              bottom: 20,
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
            const Center(
              child: Text("Cashflow"),
            ),
          ],
        ),
      ),
    );
  }
}
