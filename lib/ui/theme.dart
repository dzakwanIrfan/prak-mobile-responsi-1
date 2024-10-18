import 'package:flutter/material.dart';

final ThemeData brightYellowTheme = ThemeData(
  primaryColor: Colors.yellow,
  scaffoldBackgroundColor: Colors.yellow[50],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.yellow,
    foregroundColor: Colors.black,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontFamily: 'Helvetica'),
    bodyMedium: TextStyle(fontFamily: 'Helvetica'),
    titleLarge: TextStyle(fontFamily: 'Helvetica', fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.yellow[700],
      foregroundColor: Colors.black,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.yellow[700]!),
    ),
    labelStyle: TextStyle(color: Colors.black87),
  ),
);
