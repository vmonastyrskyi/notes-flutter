import 'package:flutter/material.dart';

class MaterialThemes {
  static ThemeData get lightTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        titleSpacing: 0.0,
        elevation: 0.0,
      ),
      primaryColor: Color.fromARGB(255, 81, 125, 162),
      primaryColorLight: Color.fromARGB(255, 90, 143, 187),
      accentColor: Color.fromARGB(255, 102, 169, 224),
      splashFactory: InkSplash.splashFactory,
      // splashColor: Color.fromRGBO(175, 175, 175, 0.25),
      // highlightColor: Colors.transparent,
      canvasColor: Color.fromARGB(255, 247, 247, 247),
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      scaffoldBackgroundColor: Color.fromARGB(255, 247, 247, 247),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 57, 162, 219),
        foregroundColor: Color.fromARGB(255, 250, 255, 255),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        brightness: Brightness.dark,
        titleSpacing: 0.0,
        elevation: 0.0,
      ),
      primaryColor: Color.fromARGB(255, 31, 43, 55),
      primaryColorLight: Color.fromARGB(255, 59, 93, 128),
      accentColor: Color.fromARGB(255, 90, 158, 207),
      splashFactory: InkSplash.splashFactory,
      // splashColor: Color.fromRGBO(96, 125, 139, 0.25),
      // highlightColor: Colors.transparent,
      canvasColor: Color.fromARGB(255, 35, 35, 35),
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      scaffoldBackgroundColor: Color.fromARGB(255, 35, 35, 35),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 57, 162, 219),
        foregroundColor: Color.fromARGB(255, 250, 255, 255),
      ),
    );
  }
}
