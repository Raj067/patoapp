import 'package:flutter/material.dart';

class SetAccountPage extends StatelessWidget {
  const SetAccountPage({Key? key}) : super(key: key);

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
                      "Tt's the little details tha make big things happen",
                    ),
                    Container(height: 15),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text(
                            "Business Name",
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
                    ),
                    Container(height: 10),
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text(
                            "Business Address",
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
                            "Website/social media link",
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
                        onPressed: () {
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
    );
  }
}
