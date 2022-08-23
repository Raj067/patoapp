// ignore: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/backend/models/profile_details.dart';
import 'package:patoapp/backend/sync/sync_profile.dart';
import 'package:patoapp/profile/top_notification_icon.dart';
import 'package:patoapp/profile/top_profile_icon.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patoapp/themes/dark_theme.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:patoapp/themes/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  // ProfileData profileData;
  const ProfileIcon({Key? key}) : super(key: key);

  @override
  State<ProfileIcon> createState() => _ProfileIconState();
}

class _ProfileIconState extends State<ProfileIcon> {
  String name = "";
  String logoUrl = "";
  ProfileData profileData = ProfileData(
    businessName: 'Loading...',
    id: 0,
  );
  fetchProfileDB() async {
    List<Map<String, dynamic>> profile = await DBHelperProfile.query();
    List<ProfileData> finalData = [];
    finalData.addAll(profile.map((dx) => fromJsonProfile(dx)).toList());
    String? activeShop = await storage.read(key: 'activeShop');

    if (finalData.isNotEmpty) {
      if (activeShop == null) {
        profileData = finalData[0];
      } else {
        int id = int.parse(activeShop);
        profileData = finalData.firstWhere((element) => element.id == id);
      }
    }
    setState(() {});
  }

  refreshDataDB() async {
    SyncProfile syncProfile = SyncProfile();
    await syncProfile.fetchData();
    fetchProfileDB();
  }

  @override
  void initState() {
    super.initState();
    fetchProfileDB();
    refreshDataDB();
  }

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: profileData.businessLogo != ''
          ? CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                profileData.businessLogo,
              ),
            )
          : const CircleAvatar(),
      label: Text(profileData.businessName),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => TopProfileIcon(
              profileData: profileData,
              refreshData: () {
                fetchProfileDB();
              },
            ),
            fullscreenDialog: true,
          ),
        );
      },
    );
  }
}

// PreferredSizeWidget _moreButtomTopBar() => const PreferredSize(
//       preferredSize: Size.fromHeight(48.0),
//       child: DarkModeSettingsIcon(),
//     );

// PreferredSizeWidget mainMoreTopBar(BuildContext context) =>
//     mainTopBar(_moreButtomTopBar(), context);

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
