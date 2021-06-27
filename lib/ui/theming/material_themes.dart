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
      splashFactory: InkSplash.splashFactory,
      // splashColor: Color.fromRGBO(175, 175, 175, 0.25),
      // highlightColor: Colors.transparent,
      canvasColor: Color.fromARGB(255, 247, 247, 247),
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      scaffoldBackgroundColor: Color.fromARGB(255, 247, 247, 247),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 249, 180, 15),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
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
      splashFactory: InkSplash.splashFactory,
      canvasColor: Color.fromARGB(255, 35, 35, 35),
      backgroundColor: Color.fromARGB(255, 35, 35, 35),
      scaffoldBackgroundColor: Color.fromARGB(255, 35, 35, 35),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color.fromARGB(255, 249, 180, 15),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }
}
