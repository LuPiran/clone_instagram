import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.dark(
    //very dark - app bar + drawer color
    surface: Color.fromARGB(255, 9, 9, 9),
    //=slight light
    primary: Color.fromARGB(255, 105, 105, 105),
    //very dark - app bar + drawer color
    secondary: Color.fromARGB(255, 20, 20, 20),
    //very dark - app bar + drawer color
    tertiary: Color.fromARGB(255, 29, 29, 29),
    //very dark - app bar + drawer color
    inversePrimary: Color.fromARGB(255, 195, 195, 195),
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 9, 9, 9),
);
