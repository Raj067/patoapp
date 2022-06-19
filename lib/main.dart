import 'package:flutter/material.dart';
import 'package:patoapp/pages/index.dart';
import 'package:patoapp/themes/darkTheme.dart';
import 'package:patoapp/themes/lightTheme.dart';
import 'package:patoapp/themes/providers.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) {
        return ThemeNotifier(patowaveLightTheme());
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      title: "PatoApp",
      theme: themeNotifier.getTheme(),
      home: const HomePage(),
      darkTheme: patowaveDarkTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
