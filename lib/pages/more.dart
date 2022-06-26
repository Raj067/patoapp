// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:patoapp/more/feedback.dart';
import 'package:patoapp/more/general_settings.dart';
import 'package:patoapp/more/greetings.dart';
import 'package:patoapp/more/inventory_analysis.dart';
import 'package:patoapp/more/invoices.dart';
import 'package:patoapp/more/privacy_policy.dart';
import 'package:patoapp/more/reminders.dart';
import 'package:patoapp/more/reports.dart';
import 'package:patoapp/more/terms_conditions.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../components/top_bar.dart';

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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                elevation: 0,
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const InventoryAnalysis(),
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
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Inventory Analysis'),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black38, size: 14),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
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
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Tutorials'),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black38, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                elevation: 0,
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
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
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('General Settings'),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black38, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
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
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Reminder Automation'),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black38, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                elevation: 0,
                child: Column(
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
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
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Terms & Conditions'),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black38, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
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
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Privacy Policy'),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black38, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
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
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Feedback'),
                                  Icon(Icons.arrow_forward_ios,
                                      color: Colors.black38, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
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
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text('Rate Patowave'),
                                  // Icon(Icons.arrow_forward_ios,
                                  //     color: Colors.black38, size: 14),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
              elevation: 0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              elevation: 0,
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
