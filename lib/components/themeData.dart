import 'package:flutter/material.dart';

ThemeData patowaveTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
      colorScheme: _patoColorScheme,
      scaffoldBackgroundColor: patoBackgroundColor,
      cardColor: patoWhite,
      primaryIconTheme: _customIconTheme(base.iconTheme),
      textTheme: _buildPatoTextTheme(base.textTheme),
      primaryTextTheme: _buildPatoTextTheme(base.primaryTextTheme),
      iconTheme: _customIconTheme(base.iconTheme),
      tabBarTheme: _tabBarTheme,
      chipTheme: _chipTheme,
      floatingActionButtonTheme: _floatingActionButtonTheme);
}

const FloatingActionButtonThemeData _floatingActionButtonTheme =
    FloatingActionButtonThemeData(
  backgroundColor: patoPrimaryColor,
  foregroundColor: patoWhite,
);

const ChipThemeData _chipTheme = ChipThemeData(
  backgroundColor: patoLightGreen,
);

const TabBarTheme _tabBarTheme = TabBarTheme(
  labelColor: patoWhite,
);

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: patoBlack);
}

TextTheme _buildPatoTextTheme(TextTheme base) {
  return base.apply(
    fontFamily: 'Rubik',
    displayColor: patoBlack,
    bodyColor: patoBlack,
  );
}

const ColorScheme _patoColorScheme = ColorScheme(
  primary: patoPrimaryColor,
  secondary: patoPrimaryColor,
  surface: patoWhite,
  background: patoWhite,
  error: patoRed,
  onPrimary: patoPrimaryColor,
  onSecondary: patoPrimaryColor,
  onSurface: patoPrimaryColor,
  onBackground: patoPrimaryColor,
  onError: patoWhite,
  brightness: Brightness.light,
);

const Color patoPrimaryColor = Color.fromARGB(255, 51, 121, 111);
const Color patoLightGreen = Color.fromARGB(255, 151, 186, 180);
const Color patoBackgroundColor = Color.fromARGB(255, 240, 240, 240);
const Color patoBlack = Color.fromARGB(255, 0, 0, 0);
const Color patoWhite = Color.fromARGB(255, 254, 255, 255);
const Color patoRed = Color(0xFFC5032B);
const Color patoGrey = Color.fromARGB(255, 75, 74, 74);
const Color patoGreen = Colors.green;
const Color patoBlue = Colors.blue;
const Color patoWarning = Colors.yellow;
