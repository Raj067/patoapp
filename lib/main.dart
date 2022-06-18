import 'package:flutter/material.dart';
// import 'package:patoapp/components/darkTheme.dart';
import 'package:patoapp/components/themeData.dart';
import 'package:patoapp/pages/index.dart';
import 'package:patoapp/themes/darkThene.dart';
import 'package:patoapp/themes/lightTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "PatoApp",
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
      theme: patowaveLightTheme(),
      themeMode: ThemeMode.dark,
      darkTheme: patowaveDarkTheme(),
    );
  }
}
