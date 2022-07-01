import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patoapp/generalSettings/application.dart';
import 'package:patoapp/generalSettings/transaction.dart';
import 'package:patoapp/generalSettings/user_management.dart';
import 'package:patoapp/themes/light_theme.dart';

class GeneralSettingsDialog extends StatelessWidget {
  const GeneralSettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'General Settings',
          style: TextStyle(color: Colors.white),
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView(
          children: [
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
                      const Text('Application'),
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
                      const Text('Transactions'),
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
                      const Text('User Management'),
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
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/print.svg",
                          width: 25, height: 25),
                      Container(
                        width: 10,
                      ),
                      const Text('Print'),
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
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/organization.svg",
                          width: 25, height: 25),
                      Container(
                        width: 10,
                      ),
                      const Text('Taxes'),
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
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/dataConfiguration.svg",
                          width: 25, height: 25),
                      Container(
                        width: 10,
                      ),
                      const Text('Items'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
