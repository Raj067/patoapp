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
  );
}

const DialogTheme _dialogTheme = DialogTheme(
    // backgroundColor: Colors.black87,
    // shape: ShapeBorder(),
    );

const FloatingActionButtonThemeData _floatingActionButtonTheme =
    FloatingActionButtonThemeData(
  backgroundColor: patowavePrimary,
  foregroundColor: patowaveWhite,
);
OutlinedButtonThemeData _outlinedButtonTheme = const OutlinedButtonThemeData(
  style: ButtonStyle(),
);

const TabBarTheme _tabBarTheme = TabBarTheme(
  labelColor: patowaveWhite,
  indicator: BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 2, color: patowavePrimary),
    ),
  ),
);
