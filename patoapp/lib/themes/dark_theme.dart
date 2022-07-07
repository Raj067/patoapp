import 'package:flutter/material.dart';
import 'package:patoapp/themes/light_theme.dart';

ThemeData patowaveDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    primaryColor: patowavePrimary.withAlpha(50),
    floatingActionButtonTheme: _floatingActionButtonTheme,
    tabBarTheme: _tabBarTheme,
    dialogTheme: _dialogTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    textButtonTheme: _textButtonThemeData,
    elevatedButtonTheme: _elevatedButtonThemeData,
    inputDecorationTheme: _inputDecorationTheme,
    appBarTheme: _appBarTheme,
  );
}

AppBarTheme _appBarTheme = const AppBarTheme(elevation: 0);

InputDecorationTheme _inputDecorationTheme = const InputDecorationTheme(
  contentPadding: EdgeInsets.fromLTRB(10, 5, 5, 5),
  iconColor: Colors.grey,
  focusColor: patowavePrimary,
  hintStyle: TextStyle(color: patowavePrimary),
  labelStyle: TextStyle(color: Colors.grey),
  floatingLabelStyle: TextStyle(color: patowavePrimary),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(15),
    ),
    borderSide: BorderSide(
      color: patowavePrimary,
      width: 2,
    ),
  ),
);

ElevatedButtonThemeData _elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(patowavePrimary),
    foregroundColor: MaterialStateProperty.all<Color>(patowaveWhite),
  ),
);
TextButtonThemeData _textButtonThemeData = TextButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(patowavePrimary),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered)) {
          return patowavePrimary.withOpacity(0.04);
        }
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed)) {
          return patowavePrimary.withOpacity(0.12);
        }
        return null; // Defer to the widget's default.
      },
    ),
  ),
);

OutlinedButtonThemeData _outlinedButtonTheme = OutlinedButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(patowavePrimary),
    shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
  ),
);

const DialogTheme _dialogTheme = DialogTheme(
    // backgroundColor: Colors.black87,
    // shape: ShapeBorder(),
    );

const FloatingActionButtonThemeData _floatingActionButtonTheme =
    FloatingActionButtonThemeData(
  backgroundColor: patowavePrimary,
  foregroundColor: patowaveWhite,
);

const TabBarTheme _tabBarTheme = TabBarTheme(
  labelColor: patowaveWhite,
  indicator: BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 2, color: patowavePrimary),
    ),
  ),
);
