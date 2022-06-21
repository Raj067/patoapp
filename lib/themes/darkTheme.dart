import 'package:flutter/material.dart';
import 'package:patoapp/themes/lightTheme.dart';

ThemeData patowaveDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    floatingActionButtonTheme: _floatingActionButtonTheme,
    tabBarTheme: _tabBarTheme,
    dialogTheme: _dialogTheme,
    // outlinedButtonThemeData: _outlinedButtonThemeData,
    outlinedButtonTheme: _outlinedButtonTheme,
    textButtonTheme: _textButtonThemeData,
    elevatedButtonTheme: _elevatedButtonThemeData,
    inputDecorationTheme: _inputDecorationTheme,
  );
}

InputDecorationTheme _inputDecorationTheme = const InputDecorationTheme(
  iconColor: patowavePrimary,
  focusColor: patowavePrimary,
  hoverColor: patowavePrimary,
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
    shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
    side: MaterialStateProperty.resolveWith<BorderSide>(
        (Set<MaterialState> states) {
      final Color color =
          states.contains(MaterialState.pressed) ? patowavePrimary : Colors.red;
      return BorderSide(color: color, width: 2);
    }),
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
