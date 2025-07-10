import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  seedColor: Color.fromARGB(255, 34, 49, 255),
);

final lightTheme = ThemeData().copyWith(
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: lightColorScheme.surface,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
  ),
  inputDecorationTheme: InputDecorationTheme().copyWith(
    labelStyle: TextStyle(fontSize: 14),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
    ),
  ),
  textTheme: TextTheme().copyWith(
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  cardTheme: CardThemeData().copyWith(
    color: lightColorScheme.secondaryContainer,
    surfaceTintColor: lightColorScheme.secondaryContainer,
  ),
);

final darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 0, 10, 148),
);

final darkTheme = ThemeData().copyWith(
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: darkColorScheme.onSecondary,
  ),
  inputDecorationTheme: InputDecorationTheme().copyWith(
    labelStyle: TextStyle(fontSize: 16),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: darkColorScheme.onPrimaryFixed,
    ),
  ),
  textTheme: TextTheme().copyWith(
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  cardTheme: CardThemeData().copyWith(color: darkColorScheme.onSecondary),
);
