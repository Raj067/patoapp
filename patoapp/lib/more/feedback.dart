import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patoapp/themes/light_theme.dart';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({Key? key}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  TextEditingController customerName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController description = TextEditingController();
  final addFeedbackFormKey = GlobalKey<FormState>();
  @override
  void dispose() {
    customerName.dispose();
    phoneNumber.dispose();
    businessName.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feedback',
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
        key: addFeedbackFormKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          children: [
            Container(height: 10),
            const Text(
              "Contact us at:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  size: 16,
                ),
                Container(width: 10),
                const Text("0123456789"),
              ],
            ),
            Container(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.phone_android,
                  size: 16,
                ),
                Container(width: 10),
                const Text("0123456789"),
              ],
            ),
            Container(height: 30),
            const Text(
              "Feedback",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: customerName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              cursorColor: patowavePrimary,
              decoration: const InputDecoration(
                label: Text(
                  "Your Name*",
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
              controller: phoneNumber,
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
              controller: businessName,
              cursorColor: patowavePrimary,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Business Name is required';
                }
                return null;
              },
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
            Container(height: 15),
            SizedBox(
              child: TextFormField(
                controller: description,
                cursorColor: patowavePrimary,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 6,
                maxLines: null,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Descriptions",
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
                  if (addFeedbackFormKey.currentState!.validate()) {}
                },
                child: const Text(
                  "Submit Feedback",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
