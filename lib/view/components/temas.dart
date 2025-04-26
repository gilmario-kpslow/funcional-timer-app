import 'package:flutter/material.dart';

final ThemeData temaVermelho = ThemeData(
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 192, 30, 0),
      onPrimary: Colors.white,
      secondary: Colors.red,
      onSecondary: Colors.red,
      error: Colors.red,
      onError: Colors.red,
      surface: Color.fromARGB(255, 255, 255, 255),
      onSurface: Colors.red,
      onTertiary: Color.fromARGB(255, 192, 30, 0),
      onTertiaryFixedVariant: Color.fromARGB(255, 255, 121, 111)),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 192, 30, 0),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 30, color: Colors.white),
      labelLarge: TextStyle(fontSize: 20, color: Colors.red),
      labelMedium: TextStyle(fontSize: 18, color: Colors.white),
      displayLarge: TextStyle(fontSize: 30, color: Colors.red),
      labelSmall: TextStyle(fontSize: 30, color: Colors.white),
      headlineLarge: TextStyle(
          fontSize: 35, color: Colors.red, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          color: Colors.redAccent, fontSize: 30, fontWeight: FontWeight.bold)),
  buttonTheme: const ButtonThemeData(
      buttonColor: Colors.redAccent, textTheme: ButtonTextTheme.accent),
  useMaterial3: true,
);

final ThemeData temaAzul = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromARGB(255, 9, 85, 185),
    onPrimary: Colors.white,
    secondary: Colors.blue,
    onSecondary: Colors.blue,
    error: Colors.blue,
    onError: Colors.blue,
    surface: Color.fromARGB(255, 255, 255, 255),
    onSurface: Colors.blue,
    onTertiary: Color.fromARGB(255, 9, 85, 185),
    onTertiaryFixedVariant: Color.fromARGB(255, 121, 170, 255),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 9, 85, 185),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: const TextTheme(
      titleLarge: TextStyle(fontSize: 30, color: Colors.white),
      labelLarge: TextStyle(fontSize: 20, color: Colors.blue),
      labelMedium: TextStyle(fontSize: 13, color: Colors.white),
      displayLarge: TextStyle(fontSize: 30, color: Colors.blue),
      labelSmall: TextStyle(fontSize: 30, color: Colors.white),
      headlineLarge: TextStyle(
          fontSize: 35, color: Colors.blue, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          color: Colors.blueAccent, fontSize: 30, fontWeight: FontWeight.bold)),
  buttonTheme: const ButtonThemeData(
      buttonColor: Colors.blueAccent, textTheme: ButtonTextTheme.accent),
  useMaterial3: true,
);
