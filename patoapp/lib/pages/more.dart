import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/more/feedback.dart';
import 'package:patoapp/more/general_settings.dart';
import 'package:patoapp/more/greetings.dart';
import 'package:patoapp/more/invoices.dart';
import 'package:patoapp/more/reports.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:store_redirect/store_redirect.dart';
import '../components/top_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 48,
            color: Theme.of(context).primaryColor,
            child: const DarkModeSettingsIcon(),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Column(
                  children: [
                    _firstRow(context),
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
                              Get.to(const GeneralSettingsDialog());
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
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .generalSettings,
                                        ),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 14),
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
                              try {
                                launchUrl(
                                  Uri.parse('${baseUrl}tutorials/'),
                                  mode: LaunchMode.externalApplication,
                                );
                              } catch (e) {
                                //
                              }
                            },
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
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .tutorials,
                                        ),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 14),
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
                    Container(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          AppLocalizations.of(context)!.contactUs,
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
                              final Uri phoneLaunchUri = Uri(
                                scheme: 'tel',
                                path: '+255765865640',
                              );
                              launchUrl(phoneLaunchUri);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.call,
                                    color: Colors.green,
                                  ),
                                  Container(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.callUs,
                                        ),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 14),
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
                            onTap: () async {
                              String whatsapp = '+255765865640';
                              String message = 'Habari, ...';
                              var whatsappAndroid = Uri.parse(
                                  "whatsapp://send?phone=$whatsapp&text=$message");
                              if (await canLaunchUrl(whatsappAndroid)) {
                                await launchUrl(whatsappAndroid);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "WhatsApp is not installed on the device"),
                                  ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  SvgPicture.asset("assets/svg/whatsapp.svg",
                                      width: 20, height: 20),
                                  Container(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .whatsappUs,
                                        ),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 14),
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
                    Container(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: Text(
                          AppLocalizations.of(context)!.information,
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
                              try {
                                launchUrl(
                                  Uri.parse('${baseUrl}terms-conditions/'),
                                  mode: LaunchMode.externalApplication,
                                );
                              } catch (e) {
                                //
                              }
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
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .termsAndConditins,
                                        ),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 14),
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
                              try {
                                launchUrl(
                                  Uri.parse('${baseUrl}privacy-policy/'),
                                  mode: LaunchMode.externalApplication,
                                );
                              } catch (e) {
                                //
                              }
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
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .privacyPolicy,
                                        ),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 14),
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
                              Get.to(const FeedbackDialog());
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
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .feedback,
                                        ),
                                        const Icon(Icons.arrow_forward_ios,
                                            size: 14),
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
                              StoreRedirect.redirect(
                                androidAppId: "com.patowave.patoapp",
                              );
                            },
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
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .ratePatowave,
                                        ),
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
          ),
        ],
      ),
    );
  }

  _firstRow(BuildContext context) {
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                onTap: () {
                  Get.to(const MainInvoicePage());
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute<void>(
                  //     builder: (BuildContext context) =>
                  //         const MainInvoicePage(),
                  //     fullscreenDialog: true,
                  //   ),
                  // );
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/files.svg",
                        width: 35, height: 35),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.invoices,
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                onTap: () {
                  Get.to(const MainReportsPage());
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/positiveDynamic.svg",
                        width: 35, height: 35),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.reports,
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                onTap: () {
                  Get.to(const MainGreetingsCards());
                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/svg/whatsapp.svg",
                        width: 35, height: 35),
                    const SizedBox(height: 10),
                    Text(
                      AppLocalizations.of(context)!.whatsapp,
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      AppLocalizations.of(context)!.greetings,
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
