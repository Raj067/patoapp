import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';

class EditMyBusiness extends StatefulWidget {
  const EditMyBusiness({Key? key}) : super(key: key);

  @override
  State<EditMyBusiness> createState() => _EditMyBusinessState();
}

class _EditMyBusinessState extends State<EditMyBusiness> {
  final List<String> businessCategories = [
    "Category 1",
    "Category 2",
    "Category 3",
    "Category 4",
    "Category 5",
  ];
  final List<String> businessTypes = [
    "Type 1",
    "Type 2",
    "Type 3",
    "Type 4",
    "Type 5",
  ];

  int value = 1;
  String? selectedBusinessCategory;
  String? selectedBusinessType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Business',
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
      body: value == 1 ? _firstScreen() : _secondScreen(),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(255, 235, 59, 1),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              value == 2
                  ? TextButton(
                      child: const Text("Back"),
                      onPressed: () {
                        setState(() {
                          value = 1;
                        });
                      },
                    )
                  : const Text(""),
              // Row(mainAxisSize: MainAxisSize.min, children: [
              //   Radio(
              //     activeColor: patowavePrimary,
              //     value: 1,
              //     groupValue: value,
              //     onChanged: (val) {
              //       setState(() {
              //         value = 1;
              //       });
              //     },
              //   ),
              //   Radio(
              //     activeColor: patowavePrimary,
              //     value: 2,
              //     groupValue: value,
              //     onChanged: (val) {
              //       setState(() {
              //         value = 2;
              //       });
              //     },
              //   ),
              // ]),
              TextButton(
                child: Text(value == 1 ? "Next" : "Finish"),
                onPressed: () {
                  setState(() {
                    value == 1 ? value = 2 : Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _firstScreen() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          SizedBox(
            height: 45,
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text(
                  "Business Name",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
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
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
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
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
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
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
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
          const Text(
            "Signature",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(height: 10),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 0,
            child: Container(
              height: 100,
              // width: 100,
            ),
          ),
          Container(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text("Change"),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text("Upload"),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all(
                    const BorderSide(color: patowaveErrorRed),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text("Remove"),
              ),
            ],
          )
        ],
      ),
    );
  }

  _secondScreen() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: [
          SizedBox(
            height: 45,
            child: DropdownButtonFormField2(
              selectedItemHighlightColor: patowavePrimary.withAlpha(50),
              scrollbarAlwaysShow: true,
              dropdownMaxHeight: 200,
              decoration: InputDecoration(
                label: const Text(
                  'Business Type',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: businessTypes
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                selectedBusinessType = value.toString();
              },
            ),
          ),
          Container(height: 10),
          SizedBox(
            height: 45,
            child: DropdownButtonFormField2(
              selectedItemHighlightColor: patowavePrimary.withAlpha(50),
              scrollbarAlwaysShow: true,
              dropdownMaxHeight: 200,
              decoration: InputDecoration(
                label: const Text(
                  'Business Category',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              isExpanded: true,
              icon: const Icon(
                Icons.arrow_drop_down,
              ),
              dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              items: businessCategories
                  .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (value) {
                //Do something when changing the item if you want.
              },
              onSaved: (value) {
                selectedBusinessCategory = value.toString();
              },
            ),
          ),
          Container(height: 10),
          SizedBox(
            height: 45,
            child: TextFormField(
              decoration: const InputDecoration(
                label: Text(
                  "Business Slogan",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
