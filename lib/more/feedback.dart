import 'package:flutter/material.dart';
import 'package:patoapp/themes/lightTheme.dart';

class FeedbackDialog extends StatelessWidget {
  const FeedbackDialog({Key? key}) : super(key: key);

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(
          children: [
            Container(height: 10),
            SizedBox(
              height: 800,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                minLines: 1,
                maxLines: 6,
                decoration: const InputDecoration(
                  label: Text(
                    "Descriptions",
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(height: 10),
            const Center(
              child: Text("Feedback"),
            ),
          ],
        ),
      ),
    );
  }
}
