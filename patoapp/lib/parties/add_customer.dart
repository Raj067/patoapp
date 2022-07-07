import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:toggle_switch/toggle_switch.dart';

class AddCustomerDialog extends StatefulWidget {
  const AddCustomerDialog({Key? key}) : super(key: key);

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final addCustomerFormKey = GlobalKey<FormState>();

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
        child: Form(
          key: addCustomerFormKey,
          child: ListView(
            children: [
              Container(height: 10),
              InkWell(
                borderRadius: BorderRadius.circular(15),
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    color: patowavePrimary.withAlpha(100),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.addressBook,
                            ),
                            Container(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Import Customer',
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'From Contacts',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Customer Name is required';
                  }
                  return null;
                },
                cursorColor: patowavePrimary,
                decoration: const InputDecoration(
                  label: Text(
                    "Customer Name*",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
                cursorColor: patowavePrimary,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  label: Text(
                    "Phone Number*",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Address is required';
                  }
                  return null;
                },
                cursorColor: patowavePrimary,
                decoration: const InputDecoration(
                  label: Text(
                    "Address*",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
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
              Container(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      cursorColor: patowavePrimary,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const FaIcon(
                              FontAwesomeIcons.solidCircleQuestion),
                          onPressed: () {
                            _openingBalanceToolTip(context);
                          },
                        ),
                        label: const Text(
                          "Opening Balance",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 10),
                  Expanded(
                    child: InputDatePickerFormField(
                      firstDate: DateTime(2000, 1, 1),
                      lastDate: DateTime(2025, 1, 1),
                      initialDate: DateTime.now(),
                    ),
                  )
                ],
              ),
              Container(height: 15),
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
                onPressed: () {
                  if (addCustomerFormKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
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

  Future<void> _openingBalanceToolTip(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          elevation: 0,
          content: Text(
              'Touch up dispatch to io.ec, event = MotionEvent { action=ACTION_UP, id[0]=0, x[0]=455.05197, y[0]=591.3076, toolType[0]=TOOL_TYPE_FINGER, buttonState=0, metaState=0, flags=0x0, edgeFlags=0x0, pointerCount=1, historySize=0, eventTime=3253190, downTime=3253161, deviceId=3, source=0x1002 }'),
        );
      },
    );
  }
}
