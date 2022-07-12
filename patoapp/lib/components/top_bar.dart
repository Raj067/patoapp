// ignore: file_names

import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/profile/top_notification_icon.dart';
import 'package:patoapp/profile/top_profile_icon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patoapp/themes/dark_theme.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:patoapp/themes/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

PreferredSizeWidget mainTopBar(
        PreferredSizeWidget button, BuildContext context) =>
    AppBar(
      automaticallyImplyLeading: false,
      title: const ProfileIcon(),
      actions: const [NotificationIcon(), SizedBox(width: 20)],
      bottom: button,
    );

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
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

class ProfileIcon extends StatefulWidget {
  const ProfileIcon({Key? key}) : super(key: key);

  @override
  State<ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  String name = "";
  String logoUrl = "";

  fetchData(String path) async {
    var data = await http.get(
      Uri.parse(baseUrl + path),
      headers: authHeaders,
    );
    name = jsonDecode(data.body)['name'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData("api/shop-profile-details/");
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      // backgroundColor: const Color.fromARGB(255, 151, 186, 180),
      avatar: const CircleAvatar(
          // backgroundColor: patoWhite,
          // foregroundColor: patoBlack,
          // child: Icon(Icons.add_shopping_cart_rounded),
          ),
      label: Text(name),
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

PreferredSizeWidget _moreButtomTopBar() => const PreferredSize(
      preferredSize: Size.fromHeight(48.0),
      child: DarkModeSettingsIcon(),
    );

PreferredSizeWidget mainMoreTopBar(BuildContext context) =>
    mainTopBar(_moreButtomTopBar(), context);

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
