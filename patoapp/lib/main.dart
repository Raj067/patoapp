import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patoapp/accounts/welcome_page.dart';
import 'package:patoapp/api/apis.dart';
import 'package:patoapp/pages/index.dart';
import 'package:patoapp/themes/dark_theme.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:patoapp/themes/providers.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:patoapp/accounts/set_account.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]).then((_) {
    SharedPreferences.getInstance().then((prefs) async {
      var darkModeOn = prefs.getBool('darkMode') ?? false;
      String? accessToken = await storage.read(key: 'access');
      String? shopName = await storage.read(key: 'shopName');
      bool isLogin = accessToken == null ? false : true;
      bool isShopProfile = shopName == null ? false : true;

      runApp(
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(
              darkModeOn ? patowaveDarkTheme() : patowaveLightTheme()),
          child: MyApp(isLogin: isLogin, isShopProfile: isShopProfile),
        ),
      );
    });
  });
}
// void main() {
//   SharedPreferences.getInstance().then((prefs) {
//     var darkModeOn = prefs.getBool('darkMode') ?? true;
//     runApp(
//       ChangeNotifierProvider<ThemeNotifier>(
//         create: (_) => ThemeNotifier(
//             darkModeOn ? patowaveDarkTheme() : patowaveLightTheme()),
//         child: const MyApp(),
//       ),
//     );
//   });
// }

class MyApp extends StatelessWidget {
  final bool isLogin;
  final bool isShopProfile;
  const MyApp({
    Key? key,
    required this.isLogin,
    required this.isShopProfile,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: "PatoWave",
      theme: themeNotifier.getTheme(),
      home: isLogin
          ? isShopProfile
              ? const HomePage()
              : const SetAccountPage()
          : const WelcomePage(),
      darkTheme: patowaveDarkTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
