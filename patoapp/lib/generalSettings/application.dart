import 'package:flutter/material.dart';
import 'package:patoapp/api/constants.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApplicationSettings extends StatefulWidget {
  const ApplicationSettings({Key? key}) : super(key: key);

  @override
  State<ApplicationSettings> createState() => _ApplicationSettingsState();
}

class _ApplicationSettingsState extends State<ApplicationSettings> {
  bool isCurrencyDashboard = box.read('isCurrencyDashboard') ?? false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.applicationSettings,
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
                Text(AppLocalizations.of(context)!.showCurrencyDashboard),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: isCurrencyDashboard,
                  onChanged: (val) {
                    box.write('isCurrencyDashboard', val);
                    isCurrencyDashboard =
                        box.read('isCurrencyDashboard') ?? false;
                    setState(() {});
                  },
                ),
              ],
            ),
          ),

          // Text(AppLocalizations.of(context)!.helloWorld),
          // TextButton(
          //   child: const Text("Set locale to English"),
          //   onPressed: () =>
          //       MyApp.of(context).setLocale(const Locale('en', '')),
          // ),
          // TextButton(
          //   child: const Text("Set locale to Swahili"),
          //   onPressed: () =>
          //       MyApp.of(context).setLocale(const Locale('sw', '')),
          // ),
          // const Divider(height: 0),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       const Text("Automatic Reminder"),
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
        ],
      ),
    );
  }
}
