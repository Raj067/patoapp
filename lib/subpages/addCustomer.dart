import 'package:flutter/material.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/themes/lightTheme.dart';

class AddCustomerDialog extends StatelessWidget {
  const AddCustomerDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Customer',
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Customer Name"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Phone Number"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text("Email Address"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        suffixIcon: Icon(Icons.question_mark_outlined),
                        label: Text(
                          "Open Balance",
                          style: TextStyle(fontSize: 13),
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Container(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text("date"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          child: const Text(
            "Add Customer",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
