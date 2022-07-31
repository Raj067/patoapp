import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationSettings extends StatefulWidget {
  const ApplicationSettings({Key? key}) : super(key: key);

  @override
  State<ApplicationSettings> createState() => _ApplicationSettingsState();
}

class _ApplicationSettingsState extends State<ApplicationSettings> {
  bool isCurrencyDashboard = false;
  fetchPreference() async {
    var prefs = await SharedPreferences.getInstance();
    isCurrencyDashboard = prefs.getBool('isCurrencyDashboard') ?? false;
    setState(() {});
  }

  @override
  void initState() {
    fetchPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Application Settings',
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
                const Text("Show currency dashboard"),
                Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: isCurrencyDashboard,
                  onChanged: (val) async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool('isCurrencyDashboard', val);
                    fetchPreference();
                  },
                ),
              ],
            ),
          ),
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
