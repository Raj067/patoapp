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
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  InvoiceButton(),
                  SizedBox(height: 10),
                  Text("Invoices"),
                ],
              ))),
        ),
        Expanded(
          child: SizedBox(
              height: 150,
              child: Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ReportsButton(),
                  SizedBox(height: 10),
                  Text("Reports"),
                ],
              ))),
        ),
        Expanded(
          child: SizedBox(
              height: 150,
              child: Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  GreetingsButton(),
                  SizedBox(height: 10),
                  Text("WhatsApp"),
                  Text("Greetings"),
                ],
              ))),
        ),
        Expanded(
          child: SizedBox(
              height: 150,
              child: Card(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  TipsButton(),
                  SizedBox(height: 10),
                  Text("Business"),
                  Text("Tips"),
                ],
              ))),
        ),
      ],
    );
  }
}

class InvoiceButton extends StatelessWidget {
  const InvoiceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => MainInvoicePage(),
            fullscreenDialog: true,
          ),
        );
      },
      icon: const Icon(Icons.file_copy_outlined),
      iconSize: 40,
    );
  }
}

class ReportsButton extends StatelessWidget {
  const ReportsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => MainReportPage(),
            fullscreenDialog: true,
          ),
        );
      },
      icon: const Icon(Icons.graphic_eq),
      iconSize: 40,
    );
  }
}

class GreetingsButton extends StatelessWidget {
  const GreetingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => MainGreetingsCards(),
            fullscreenDialog: true,
          ),
        );
      },
      icon: const Icon(Icons.whatsapp),
      iconSize: 40,
    );
  }
}

class TipsButton extends StatelessWidget {
  const TipsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.youtube_searched_for_outlined),
      iconSize: 40,
    );
  }
}
