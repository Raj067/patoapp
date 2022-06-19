import 'package:flutter/material.dart';
import 'package:patoapp/themes/lightTheme.dart';

ThemeData patowaveDarkTheme() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    floatingActionButtonTheme: _floatingActionButtonTheme,
    tabBarTheme: _tabBarTheme,
    dialogTheme: _dialogTheme,
    buttonTheme: ButtonThemeData(
      colorScheme: forButton,
      textTheme: ButtonTextTheme.normal,
    ),
  );
}

// SwitchThemeData _SwitchThemeData = const SwitchThemeData(
//   thumbColor?: Colors.yellow,
// );

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
      bottom: BorderSide(width: 2, color: patowaveWhite),
    ),
  ),
);
