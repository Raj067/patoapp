// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:patoapp/components/darkTheme.dart';
import 'package:patoapp/subpages/feedback.dart';
import 'package:patoapp/subpages/generalSettings.dart';
import 'package:patoapp/subpages/greetings.dart';
import 'package:patoapp/subpages/invoices.dart';
import 'package:patoapp/subpages/overview.dart';
import 'package:patoapp/subpages/privacyPolicy.dart';
import 'package:patoapp/subpages/reminders.dart';
import 'package:patoapp/subpages/reports.dart';
import 'package:patoapp/subpages/termsConditions.dart';

import '../components/topBar.dart';

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
                        const Icon(
                          Icons.generating_tokens,
                          color: Colors.black38,
                        ),
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
                        const Icon(
                          Icons.youtube_searched_for_outlined,
                          color: Colors.black38,
                        ),
                        Container(
                          width: 10,
                        ),
                        const Text('Business Tips'),
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
                        const Icon(
                          Icons.settings,
                          color: Colors.black38,
                        ),
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
                        const Icon(
                          Icons.notifications,
                          color: Colors.black38,
                        ),
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
                        const Icon(
                          Icons.file_copy,
                          color: Colors.black38,
                        ),
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
                        const Icon(
                          Icons.privacy_tip,
                          color: Colors.black38,
                        ),
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
                        const Icon(
                          Icons.feedback,
                          color: Colors.black38,
                        ),
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
                        const Icon(
                          Icons.star,
                          color: Colors.black38,
                        ),
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
                  children: const [
                    Icon(Icons.file_copy_outlined, size: 35),
                    SizedBox(height: 10),
                    Text(
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
                  children: const [
                    Icon(Icons.graphic_eq, size: 35),
                    SizedBox(height: 10),
                    Text(
                      "Reports",
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
                          const MainGreetingsCards(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.whatsapp, size: 35),
                    SizedBox(height: 10),
                    Text(
                      "WhatsApp",
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      "Greetings",
                      style: TextStyle(fontSize: 12),
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
