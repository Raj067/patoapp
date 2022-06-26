// ignore: file_names

import 'package:flutter/material.dart';
import 'package:patoapp/profile/top_notification_icon.dart';
import 'package:patoapp/reports/top_profile_icon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patoapp/themes/dark_theme.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:patoapp/themes/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

PreferredSizeWidget mainTopBar(
        PreferredSizeWidget button, BuildContext context) =>
    AppBar(
      title: const ProfileIcon(),
      actions: const [NotificationIcon(), SizedBox(width: 20)],
      bottom: button,
    );

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      // icon: const Icon(
      //   Icons.notifications,
      //   color: patoWhite,
      // ),
      icon: SvgPicture.asset("assets/svg/alarmoff.svg", width: 25, height: 25),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const TopNotificationIcon(),
            fullscreenDialog: true,
          ),
        );
      },
    );
  }
}

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      // backgroundColor: const Color.fromARGB(255, 151, 186, 180),
      avatar: const CircleAvatar(
          // backgroundColor: patoWhite,
          // foregroundColor: patoBlack,
          // child: Icon(Icons.add_shopping_cart_rounded),
          ),
      label: const Text('Mama Shop'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const TopProfileIcon(),
            fullscreenDialog: true,
          ),
        );
      },
    );
  }
}

PreferredSizeWidget _inventoryButtonTopBar() => const TabBar(
      tabs: <Widget>[
        Tab(
          text: "Items",
        ),
        Tab(
          text: "Analysis",
        ),
      ],
    );

PreferredSizeWidget _moreButtomTopBar() => const PreferredSize(
      preferredSize: Size.fromHeight(48.0),
      child: DarkModeSettingsIcon(),
    );

PreferredSizeWidget _partiesButtomTopBar() => PreferredSize(
      preferredSize: const Size.fromHeight(48.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                MyDropdownButtonParties(),
              ],
            ),
          ),
        ],
      ),
    );

PreferredSizeWidget mainInventoryTopBar(BuildContext context) =>
    mainTopBar(_inventoryButtonTopBar(), context);

PreferredSizeWidget mainMoreTopBar(BuildContext context) =>
    mainTopBar(_moreButtomTopBar(), context);

PreferredSizeWidget mainPartiesTopBar(BuildContext context) =>
    mainTopBar(_partiesButtomTopBar(), context);

// PreferredSizeWidget mainBusinessTopBar(BuildContext context) =>
//     mainTopBar(_businessButtomTopBar(), context);

// DROPDOWNS
class MyDropdownButtonParties extends StatefulWidget {
  const MyDropdownButtonParties({Key? key}) : super(key: key);

  @override
  State<MyDropdownButtonParties> createState() =>
      _MyDropdownButtonPartiesState();
}

class _MyDropdownButtonPartiesState extends State<MyDropdownButtonParties> {
  String dropdownValue = 'Last Week';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 12, 5),
      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(
          color: patowaveGreen400,
        ),
        color: Theme.of(context).chipTheme.backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton<String>(
        value: dropdownValue,
        alignment: AlignmentDirectional.topStart,
        underline: Container(
          height: 0,
        ),
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Last Week', 'Last Month']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(fontSize: 15)),
          );
        }).toList(),
      ),
    );
  }
}

// class MyDropdownButtonBusiness extends StatefulWidget {
//   const MyDropdownButtonBusiness({Key? key}) : super(key: key);

//   @override
//   State<MyDropdownButtonBusiness> createState() =>
//       _MyDropdownButtonBusinessState();
// }

// class _MyDropdownButtonBusinessState extends State<MyDropdownButtonBusiness> {
//   String dropdownValue = 'Last Month';

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // color: patoWhite,
//       margin: const EdgeInsets.all(12.0),
//       padding: const EdgeInsets.all(2),
//       height: 24,
//       decoration: BoxDecoration(
//         color: patoLightGreen,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       child: DropdownButton<String>(
//         value: dropdownValue,
//         alignment: AlignmentDirectional.topStart,
//         underline: Container(
//           height: 0,
//         ),
//         icon: const Icon(
//           Icons.arrow_drop_down_rounded,
//           size: 15,
//         ),
//         onChanged: (String? newValue) {
//           setState(() {
//             dropdownValue = newValue!;
//           });
//         },
//         items: <String>['Last Month', 'Last Week']
//             .map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value, style: const TextStyle(fontSize: 15)),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

class DarkModeSettingsIcon extends StatefulWidget {
  const DarkModeSettingsIcon({Key? key}) : super(key: key);

  @override
  State<DarkModeSettingsIcon> createState() => _DarkModeSettingsIconState();
}

class _DarkModeSettingsIconState extends State<DarkModeSettingsIcon> {
  bool isDarkMode = true;
  @override
  Widget build(BuildContext context) {
    final object = Provider.of<ThemeNotifier>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              const Text(
                'Dark Mode',
                style: TextStyle(color: Colors.white),
              ),
              const Spacer(),
              Switch(
                  activeTrackColor: patowaveGreen400,
                  activeColor: patowavePrimary,
                  value: object.getTheme() == patowaveDarkTheme(),
                  onChanged: (value) {
                    setState(() {
                      isDarkMode
                          ? {
                              isDarkMode = false,
                              _onThemeChanged(isDarkMode, object)
                            }
                          : {
                              isDarkMode = true,
                              _onThemeChanged(isDarkMode, object)
                            };
                    });
                  })
            ],
          ),
        ),
      ],
    );
  }

  void _onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(patowaveDarkTheme())
        : themeNotifier.setTheme(patowaveLightTheme());
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }
}
