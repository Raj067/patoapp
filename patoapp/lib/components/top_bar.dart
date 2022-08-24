import 'package:flutter/material.dart';
import 'package:patoapp/themes/dark_theme.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:patoapp/themes/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
