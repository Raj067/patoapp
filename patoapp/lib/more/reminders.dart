import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderDialog extends StatefulWidget {
  const ReminderDialog({Key? key}) : super(key: key);

  @override
  State<ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {
  bool selfPaymentReminder = false;

  bool automaticReminder = false;

  fetchPreference() async {
    var prefs = await SharedPreferences.getInstance();
    selfPaymentReminder = prefs.getBool('selfPaymentReminder') ?? true;
    automaticReminder = prefs.getBool('automaticReminder') ?? true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reminder Automation',
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
      body: ListView(
        children: [
          Container(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Self payment reminder"),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: selfPaymentReminder,
                  onChanged: (val) async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool('selfPaymentReminder', val);
                    fetchPreference();
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Automatic Reminder"),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: automaticReminder,
                  onChanged: (val) async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool('automaticReminder', val);
                    fetchPreference();
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Remind payment due"),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: true,
                  onChanged: (val) {},
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text("Reminder Message"),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              minLines:
                  6, // any number you need (It works as the rows for the textarea)
              keyboardType: TextInputType.multiline,
              maxLines: null,
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
          )
          // const Center(
          //   child: Text("Reminders"),
          // ),
        ],
      ),
    );
  }
}
