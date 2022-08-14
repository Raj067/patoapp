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
        title: Text(
          AppLocalizations.of(context)!.languageSettings,
          style: const TextStyle(color: Colors.white),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppLocalizations.of(context)!.selectLanguage,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(height: 10),
            ElevatedButton(
                style: ButtonStyle(
                  // MaterialStateProperty<Color?>? backgroundColor,
                  backgroundColor: MaterialStateProperty.all(patowavePrimary),
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(
                    const Size(45, 45),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  MyApp.of(context).setLocale(const Locale('en', ''));
                },
                child: const Text('English')),
            Container(height: 10),
            ElevatedButton(
                style: ButtonStyle(
                  // MaterialStateProperty<Color?>? backgroundColor,
                  backgroundColor: MaterialStateProperty.all(patowaveGreen200),
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(
                    const Size(45, 45),
                  ),
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  MyApp.of(context).setLocale(const Locale('sw', ''));
                },
                child: const Text('Kiswahili'),),
          ],
        ),
      ),
    );
  }
}
