import 'package:flutter/material.dart';

final ThemeData myappTheme = ThemeData(
  navigationBarTheme: NavigationBarThemeData(
    labelTextStyle: MaterialStateProperty.resolveWith((state) {
      if (state.contains(MaterialState.selected)) {
        return const TextStyle(color: Colors.white);
      }
      return const TextStyle(color: Colors.white);
    }),
  ),
);