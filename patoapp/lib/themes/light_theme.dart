// ignore: file_names
import 'package:flutter/material.dart';

ThemeData patowaveLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: patowavePrimary,
    colorScheme: _patoColorScheme,
    scaffoldBackgroundColor: patowaveBackground,
    cardColor: patowaveWhite,
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildPatoTextTheme(base.textTheme),
    primaryTextTheme: _buildPatoTextTheme(base.primaryTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
    tabBarTheme: _tabBarTheme,
    chipTheme: _chipTheme,
    floatingActionButtonTheme: _floatingActionButtonTheme,
    dialogTheme: _dialogTheme,
    inputDecorationTheme: _inputDecorationTheme,
    checkboxTheme: _checkboxTheme,
  );
}

CheckboxThemeData _checkboxTheme = CheckboxThemeData(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
  // MaterialStateProperty<Color?>? checkColor,
  checkColor: MaterialStateProperty.all(patowavePrimary),
);

InputDecorationTheme _inputDecorationTheme = const InputDecorationTheme(
  contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
  iconColor: Colors.grey,
);

const DialogTheme _dialogTheme = DialogTheme(
  backgroundColor: patowaveBackground,
  // shape: ShapeBorder(),
);

const FloatingActionButtonThemeData _floatingActionButtonTheme =
    FloatingActionButtonThemeData(
  backgroundColor: patowavePrimary,
  foregroundColor: patowaveWhite,
);

const ChipThemeData _chipTheme = ChipThemeData(
  backgroundColor: patowaveGreen400,
);

const TabBarTheme _tabBarTheme = TabBarTheme(
  labelColor: patowaveWhite,
  indicator: BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 2, color: patowaveWhite),
    ),
  ),
);

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: patowaveBlack);
}

TextTheme _buildPatoTextTheme(TextTheme base) {
  return base
      .copyWith(
        caption: base.caption?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
        button: base.button?.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: defaultLetterSpacing,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: patowaveBlack,
        bodyColor: patowaveBlack,
      );
}

const ColorScheme _patoColorScheme = ColorScheme(
  primary: patowavePrimary,
  secondary: patowavePrimary,
  surface: patowaveWhite,
  background: patowaveWhite,
  error: patowaveErrorRed,
  onPrimary: patowaveWhite,
  onSecondary: patowaveWhite,
  onSurface: patowaveBlack,
  onBackground: patowaveBlack,
  onError: patowaveWhite,
  brightness: Brightness.light,
  tertiary: patowaveGreen50,
);

const Color patowaveGreen50 = Color(0xFFC2F2F1);
const Color patowaveGreen100 = Color(0xFFB8DFDC);
const Color patowaveGreen200 = Color(0xFF8BCDC6);
const Color patowaveGreen300 = Color(0xFF62B6AE);
const Color patowaveGreen400 = Color(0xFF49A69D);
const Color patowaveGreen500 = Color(0xFF3C968B);
const Color patowaveGreen600 = Color(0xFF38897E);
const Color patowavePrimary = Color(0xFF33796F);
const Color patowaveGreen800 = Color(0xFF2F695F);
const Color patowaveGreen900 = Color(0xFF274C44);

const Color patowaveLightGreen = Color.fromARGB(55, 73, 166, 157);

const Color patowaveErrorRed = Color(0xFFC5032B);
const Color patowaveWhite = Colors.white;
const Color patowaveBlack = Colors.black;
const Color patowaveBackground = Color.fromARGB(255, 230, 230, 230);

const Color patowaveWarning = Colors.orange;
const Color patowaveGreen = Colors.green;
const Color patowaveBlue = Colors.blue;
const defaultLetterSpacing = 0.03;

// Color.fromARGB(55, 73, 166, 157),