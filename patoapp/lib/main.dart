import 'dart:io';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:patoapp/accounts/welcome_page.dart';
import 'package:patoapp/api/apis.dart';
// import 'package:patoapp/backend/controllers/customers_controller.dart';
// import 'package:patoapp/backend/controllers/profile_controller.dart';
import 'package:patoapp/backend/db/db_Inventory.dart';
import 'package:patoapp/backend/db/db_business.dart';
import 'package:patoapp/backend/db/db_shedule.dart';
import 'package:patoapp/backend/db/db_customer.dart';
import 'package:patoapp/backend/db/db_invoices.dart';
import 'package:patoapp/backend/db/db_products.dart';
import 'package:patoapp/backend/db/db_profile.dart';
import 'package:patoapp/pages/index.dart';
import 'package:patoapp/themes/dark_theme.dart';
import 'package:patoapp/themes/light_theme.dart';
import 'package:patoapp/themes/providers.dart';
import 'package:patoapp/updates/updater.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:patoapp/accounts/set_account.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest.dart' as tz;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

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

      await DBHelperShedule.initDb();
      await DBHelperCustomer.initDb();
      await DBHelperBusiness.initDb();
      await DBHelperProfile.initDb();
      await DBHelperProduct.initDb();
      await DBHelperInvoice.initDb();
      await DBHelperInventory.initDb();

      tz.initializeTimeZones();
      // Plugin must be initialized before using
      await FlutterDownloader.initialize(
          debug:
              true, // optional: set to false to disable printing logs to console (default: true)
          ignoreSsl:
              true // option: set to false to disable working with http links (default: false)
          );

      HttpOverrides.global = MyHttpOverrides();
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

class MyApp extends StatefulWidget {
  final bool isLogin;
  final bool isShopProfile;
  const MyApp({
    Key? key,
    required this.isLogin,
    required this.isShopProfile,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  bool _checkVersion = true;
  void setLocale(Locale value) async {
    await storage.write(key: "languageCode", value: value.languageCode);
    setState(() {
      _locale = value;
    });
  }

  updateVersion() async {
    String? lang = await storage.read(key: 'languageCode');
    _locale = Locale(lang ?? 'sw', '');
    _checkVersion = await checkVersion();
    setState(() {});
  }

  @override
  void initState() {
    updateVersion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return GetMaterialApp(
      title: "PatoWave",
      theme: themeNotifier.getTheme(),
      home: _checkVersion
          ? widget.isLogin
              ? widget.isShopProfile
                  ? const HomePage()
                  : const SetAccountPage()
              : const WelcomePage()
          : const Updater(),
      darkTheme: patowaveDarkTheme(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('sw', ''), // English, no country code
        Locale('en', ''), // Swahili, no country code
      ],
      locale: _locale,
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocaleLanguage in supportedLocales) {
          if (supportedLocaleLanguage.languageCode == locale!.languageCode &&
              supportedLocaleLanguage.countryCode == locale.countryCode) {
            return supportedLocaleLanguage;
          }
        }
        return supportedLocales.first;
      },
    );
  }
}
