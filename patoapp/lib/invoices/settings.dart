import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patoapp/api/constants.dart';
import 'package:patoapp/themes/light_theme.dart';

class InvoiceSettings extends StatefulWidget {
  const InvoiceSettings({Key? key}) : super(key: key);

  @override
  State<InvoiceSettings> createState() => _InvoiceSettingsState();
}

class _InvoiceSettingsState extends State<InvoiceSettings> {
  TextEditingController noteController = TextEditingController();
  TextEditingController paymentController = TextEditingController();

  String? note = box.read('note');
  String? paymentMethod = box.read('paymentMethod');

  @override
  void initState() {
    if (note != null) {
      noteController.text = note!;
    }
    if (paymentMethod != null) {
      paymentController.text = paymentMethod!;
    }
    super.initState();
  }

  @override
  void dispose() {
    noteController.dispose();
    paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Invoice Settings',
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
      body: Form(
        // key: addFeedbackFormKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: [
            Container(height: 10),
            TextFormField(
              controller: noteController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Name is required';
              //   }
              //   return null;
              // },
              // initialValue: "Thanks for your business",
              cursorColor: patowavePrimary,
              decoration: const InputDecoration(
                label: Text(
                  "Note",
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
              controller: paymentController,
              cursorColor: patowavePrimary,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              minLines: 6,
              maxLines: null,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'paymentController is required';
              //   }
              //   return null;
              // },
              decoration: const InputDecoration(
                label: Text(
                  "Payment Method",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
              ),
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
                onPressed: () {
                  if (noteController.text != "") {
                    box.write('note', noteController.text);
                  }
                  if (paymentController.text != '') {
                    box.write('paymentMethod', paymentController.text);
                  }

                  Get.back();
                  Get.back();
                },
                child: const Text(
                  "Save",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
