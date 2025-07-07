import 'package:flutter/material.dart';

final darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 4, 3, 71),
  surface: Color.fromARGB(255, 36, 39, 59),
);

final theme = ThemeData().copyWith(
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.secondaryContainer,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: darkColorScheme.onSecondary,
  ),
  inputDecorationTheme: InputDecorationTheme().copyWith(
    labelStyle: TextStyle(fontSize: 14),
  ),
);
