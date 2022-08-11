import 'package:flutter/material.dart';
import 'package:patoapp/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:patoapp/themes/light_theme.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Language Settings',
          style: TextStyle(color: Colors.white),
        ),
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
        children: [
          Text(AppLocalizations.of(context)!.helloWorld),
          TextButton(
            child: const Text("Set locale to English"),
            onPressed: () =>
                MyApp.of(context).setLocale(const Locale('en', '')),
          ),
          TextButton(
            child: const Text("Set locale to Swahili"),
            onPressed: () =>
                MyApp.of(context).setLocale(const Locale('sw', '')),
          ),
        ],
      ),
    );
  }
}
