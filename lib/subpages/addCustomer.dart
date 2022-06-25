import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patoapp/themes/lightTheme.dart';
import 'package:toggle_switch/toggle_switch.dart';

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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
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
                          const FaIcon(
                            FontAwesomeIcons.addressBook,
                            color: patowaveWhite,
                          ),
                          Container(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Import Customer',
                                style: TextStyle(
                                    color: patowaveWhite,
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
              height: 45,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text(
                    "Customer Name",
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
                    "Phone Number",
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
                    "Email Address",
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
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
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
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 45,
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
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(height: 10),
            Row(
              children: [
                ToggleSwitch(
                  minWidth: MediaQuery.of(context).size.width - 50,
                  minHeight: 45,
                  cornerRadius: 20.0,
                  activeBgColors: const [
                    [patowavePrimary],
                    [patowavePrimary]
                  ],
                  activeFgColor: patowaveWhite,
                  inactiveBgColor: Colors.grey.withAlpha(100),
                  inactiveFgColor: patowaveBlack,
                  initialLabelIndex: 1,
                  totalSwitches: 2,
                  labels: const ['To receive', 'To be paid'],
                  radiusStyle: true,
                  // onToggle: (index) {
                  //   print('switched to: $index');
                  // },
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
