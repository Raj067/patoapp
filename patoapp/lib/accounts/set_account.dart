import 'package:flutter/material.dart';
import 'package:patoapp/pages/index.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetAccountPage extends StatefulWidget {
  const SetAccountPage({Key? key}) : super(key: key);

  @override
  State<SetAccountPage> createState() => _SetAccountPageState();
}

class _SetAccountPageState extends State<SetAccountPage> {
  final setAccountFormKey = GlobalKey<FormState>();

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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => const HomePage())));
                            }
                            // Login user
                            var prefs = await SharedPreferences.getInstance();
                            prefs.setBool('isLogin', true);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) =>
                            //         const MainEntryHomePage(),
                            //     fullscreenDialog: true,
                            //   ),
                            // );
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
}
