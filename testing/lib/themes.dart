import 'package:flutter/material.dart';

class MyThemes{
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.green,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(
      color: Colors.white,
    ) ,
  );

  static final lightTheme = ThemeData(
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(
      color: Colors.green,
    ),
    appBarTheme: AppBarTheme(
    backgroundColor: Colors.green,)
  );
}