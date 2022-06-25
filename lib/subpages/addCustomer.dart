import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            Container(height: 10),
            Card(
              color: patowavePrimary,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.contact_page, size: 24),
                          Container(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Import Customer',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'From Contacts',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 14),
                    ],
                  ),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Customer Name",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Phone Number",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            SizedBox(
              height: 40,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Email Address",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: const FaIcon(
                                FontAwesomeIcons.solidCircleQuestion),
                            onPressed: () {}),
                        label: const Text(
                          "Opening Balance",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Container(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.calendarCheck,
                            ),
                            onPressed: () {}),
                        label: const Text(
                          "1-1-2022",
                          style: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 14),
                        ),
                        border: const OutlineInputBorder(),
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
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  // MaterialStateProperty<Color?>? backgroundColor,
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
                onPressed: () {},
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
