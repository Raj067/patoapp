import 'package:flutter/material.dart';
import 'package:patoapp/themes/lightTheme.dart';

class EditMyBusiness extends StatefulWidget {
  const EditMyBusiness({Key? key}) : super(key: key);

  @override
  State<EditMyBusiness> createState() => _EditMyBusinessState();
}

class _EditMyBusinessState extends State<EditMyBusiness> {
  int _value = 1;
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
      body: const Center(
        child: Text("Reminders"),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text("Back"),
              onPressed: () {
                setState(() {
                  _value = 1;
                });
              },
            ),
            Row(mainAxisSize: MainAxisSize.min, children: [
              Radio(
                activeColor: patowavePrimary,
                value: 1,
                groupValue: _value,
                onChanged: (val) {
                  setState(() {
                    _value = 1;
                  });
                },
              ),
              Radio(
                activeColor: patowavePrimary,
                value: 2,
                groupValue: _value,
                onChanged: (val) {
                  setState(() {
                    _value = 2;
                  });
                },
              ),
            ]),
            TextButton(
              child: const Text("Finish"),
              onPressed: () {
                setState(() {
                  _value = 2;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
