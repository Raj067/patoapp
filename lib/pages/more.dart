// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
// import 'package:patoapp/components/darkTheme.dart';
import 'package:patoapp/subpages/feedback.dart';
import 'package:patoapp/subpages/generalSettings.dart';
import 'package:patoapp/subpages/greetings.dart';
import 'package:patoapp/subpages/invoices.dart';
import 'package:patoapp/subpages/overview.dart';
import 'package:patoapp/subpages/privacyPolicy.dart';
import 'package:patoapp/subpages/reminders.dart';
import 'package:patoapp/subpages/reports.dart';
import 'package:patoapp/subpages/termsConditions.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/topBar.dart';
// import 'package:koukicons/settings.dart';

// SvgPicture.asset("svg/alarmoff.svg", width: 25, height: 25),

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainMoreTopBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Column(
            children: [
              const FirstRowData(),
              Container(
                height: 10,
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const OverviewDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/viewDetails.svg",
                            width: 25, height: 25),
                        Container(
                          width: 10,
                        ),
                        const Text('Overview'),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/template.svg",
                            width: 25, height: 25),
                        Container(
                          width: 10,
                        ),
                        const Text('Tutorials'),
                      ],
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    'Settings',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const GeneralSettingsDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/settings.svg",
                            width: 25, height: 25),
                        Container(
                          width: 10,
                        ),
                        const Text('General Settings'),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const ReminderDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/ringing2.svg",
                            width: 25, height: 25),
                        Container(
                          width: 10,
                        ),
                        const Text('Reminder Automation'),
                      ],
                    ),
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text(
                    'Informations',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const TermsConditionsDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/rules.svg",
                            width: 25, height: 25),
                        Container(
                          width: 10,
                        ),
                        const Text('Terms & Conditions'),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const PrivacyPolicyDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/privacy.svg",
                            width: 25, height: 25),
                        Container(
                          width: 10,
                        ),
                        const Text('Privacy Policy'),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const FeedbackDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/feedback.svg",
                            width: 25, height: 25),
                        Container(
                          width: 10,
                        ),
                        const Text('Feedback'),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/favourite2.svg",
                            width: 25, height: 25),
                        Container(
                          width: 10,
                        ),
                        const Text('Rate Patowave'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstRowData extends StatelessWidget {
  const FirstRowData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const MainInvoicePage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/files.svg",
                        width: 35, height: 35),
                    const SizedBox(height: 10),
                    const Text(
                      "Invoices",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const MainReportsPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/positiveDynamic.svg",
                        width: 35, height: 35),
                    const SizedBox(height: 10),
                    const Text(
                      "Reports",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const MainGreetingsCards(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/whatsapp.svg",
                        width: 35, height: 35),
                    const SizedBox(height: 10),
                    const Text(
                      "WhatsApp",
                      style: TextStyle(fontSize: 12),
                    ),
                    const Text(
                      "Greetings",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
