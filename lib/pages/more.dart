// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const FirstRowData(),
              Container(
                height: 10,
              ),
              Card(
                child: ListTile(
                  title: const Text('Overview'),
                  leading: const Icon(Icons.generating_tokens),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => OverviewDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.youtube_searched_for_outlined),
                  title: const Text('Business Tips'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ),
              const ListTile(
                // ignore: unnecessary_const
                title: Text(
                  'Settings',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('General Settings'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            GeneralSettingsDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Reminder Automation'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ReminderDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              const ListTile(
                title: Text(
                  'Informations',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.file_copy),
                  title: const Text('Terms & Conditions'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            TermsConditionsDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('Privacy Policy'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            PrivacyPolicyDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text('Feedback'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => FeedbackDialog(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.star),
                  title: const Text('Rate Patowave'),
                  onTap: () {},
                  trailing: const Icon(Icons.arrow_forward_ios),
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
            height: 150,
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => MainInvoicePage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.file_copy_outlined, size: 40),
                    SizedBox(height: 10),
                    Text("Invoices"),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 150,
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => MainReportsPage(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.graphic_eq, size: 40),
                    SizedBox(height: 10),
                    Text("Reports"),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 150,
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => MainGreetingsCards(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.whatsapp, size: 40),
                    SizedBox(height: 10),
                    Text("WhatsApp"),
                    Text("Greetings"),
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
