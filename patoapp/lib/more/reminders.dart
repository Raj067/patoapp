import 'package:flutter/material.dart';
import 'package:patoapp/api/constants.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReminderDialog extends StatefulWidget {
  const ReminderDialog({Key? key}) : super(key: key);

  @override
  State<ReminderDialog> createState() => _ReminderDialogState();
}

class _ReminderDialogState extends State<ReminderDialog> {
  bool selfPaymentReminder = box.read('selfPaymentReminder') ?? false;
  bool automaticReminder = box.read('automaticReminder') ?? false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.reminderAoutomation,
          style: const TextStyle(color: Colors.white),
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
                Text(AppLocalizations.of(context)!.selfPaymentReminder),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: selfPaymentReminder,
                  onChanged: (val) {
                    box.write('selfPaymentReminder', val);
                    selfPaymentReminder =
                        box.read('selfPaymentReminder') ?? false;
                    setState(() {});
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
                Text(AppLocalizations.of(context)!.automaticReminder),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: automaticReminder,
                  onChanged: (val) {
                    box.write('automaticReminder', val);
                    automaticReminder = box.read('automaticReminder') ?? false;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          const Divider(height: 0),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text("Remind payment due"),
          //       Switch(
          //         activeTrackColor: patowaveGreen400,
          //         activeColor: patowavePrimary,
          //         value: true,
          //         onChanged: (val) {},
          //       ),
          //     ],
          //   ),
          // ),
          // const Divider(height: 0),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(AppLocalizations.of(context)!.reminderMessage),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text("""
Mambo vipi <CUSTOMER_NAME>, unakumbushwa kuja kulipa deni lako <<BUSINESS_NAME> (<BUSINESS_PHONE)> Tsh: <OUTSTANDING_AMOUNT>  kama yalivyo makubaliano, 
Asante kwa kufanya biashara nasi.

<BUSINESS_NAME>
Powered by Patowave
https://patowave.com""", style: TextStyle()),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: TextFormField(
          //     minLines:
          //         6, // any number you need (It works as the rows for the textarea)
          //     keyboardType: TextInputType.multiline,
          //     maxLines: null,
          //     decoration: const InputDecoration(
          //       label: Text(
          //         "Descriptions",
          //         style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
          //       ),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(
          //           Radius.circular(15),
          //         ),
          //       ),
          //     ),
          //   ),
          // )
          // // const Center(
          // //   child: Text("Reminders"),
          // // ),
        ],
      ),
    );
  }
}
