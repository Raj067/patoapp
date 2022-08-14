import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patoapp/generalSettings/application.dart';
import 'package:patoapp/generalSettings/items.dart';
import 'package:patoapp/generalSettings/language.dart';
import 'package:patoapp/generalSettings/transaction.dart';
import 'package:patoapp/generalSettings/user_management.dart';
import 'package:patoapp/more/reminders.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralSettingsDialog extends StatelessWidget {
  const GeneralSettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.generalSettings,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
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
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        children: [
          Container(height: 15),
          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const ApplicationSettings(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.app_settings_alt,
                      color: Colors.red,
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(AppLocalizations.of(context)!.application),
                  ],
                ),
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
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const LanguageSettings(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.language,
                      color: Colors.blue,
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(AppLocalizations.of(context)!.language)
                  ],
                ),
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
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const TransactionSettings(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/currencyExchange.svg",
                        width: 25, height: 25),
                    Container(
                      width: 10,
                    ),
                    Text(AppLocalizations.of(context)!.transactions),
                  ],
                ),
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
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const UserManagement(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/portraitMode.svg",
                        width: 25, height: 25),
                    Container(
                      width: 10,
                    ),
                    Text(AppLocalizations.of(context)!.userManagement)
                  ],
                ),
              ),
            ),
          ),
          // Card(
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(15),
          //     ),
          //   ),
          //   elevation: 0,
          //   child: InkWell(
          //     borderRadius: BorderRadius.circular(15),
          //     onTap: () {},
          //     child: Padding(
          //       padding: const EdgeInsets.all(10),
          //       child: Row(
          //         children: [
          //           SvgPicture.asset("assets/svg/print.svg",
          //               width: 25, height: 25),
          //           Container(
          //             width: 10,
          //           ),
          //           const Text('Print'),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // Card(
          //   shape: const RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(15),
          //     ),
          //   ),
          //   elevation: 0,
          //   child: InkWell(
          //     borderRadius: BorderRadius.circular(15),
          //     onTap: () {},
          //     child: Padding(
          //       padding: const EdgeInsets.all(10),
          //       child: Row(
          //         children: [
          //           SvgPicture.asset("assets/svg/organization.svg",
          //               width: 25, height: 25),
          //           Container(
          //             width: 10,
          //           ),
          //           const Text('Taxes'),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),

          Card(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 0,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ItemsSettings(),
                    fullscreenDialog: true,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/svg/dataConfiguration.svg",
                        width: 25, height: 25),
                    Container(
                      width: 10,
                    ),
                    Text(AppLocalizations.of(context)!.items),
                  ],
                ),
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
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ReminderDialog(),
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
                    Text(AppLocalizations.of(context)!.reminderAoutomation),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
