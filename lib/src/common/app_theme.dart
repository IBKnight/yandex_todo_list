import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/palette.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: false,
        shadowColor: Colors.red,
        textTheme: const TextTheme(
          //? Large title
          titleLarge: TextStyle(
            fontSize: 32,
            height: 38 / 32,
            color: Palette.labelPrimaryLight,
            fontWeight: FontWeight.w500,
          ),
          //? Title
          titleMedium: TextStyle(
            fontSize: 20,
            height: 32 / 20,
            color: Palette.labelPrimaryLight,
            fontWeight: FontWeight.w500,
          ),
          //? Body
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 20 / 16,
            color: Palette.labelPrimaryLight,
            fontWeight: FontWeight.w400,
          ),
          //? Button
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 24 / 14,
            color: Palette.labelPrimaryLight,
            fontWeight: FontWeight.w500,
          ),
          //? Subhead
          bodySmall: TextStyle(
            fontSize: 14,
            height: 20 / 14,
            color: Palette.labelPrimaryLight,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: false,
        textTheme: const TextTheme(
          //? Large title
          titleLarge: TextStyle(
            fontSize: 32,
            height: 38 / 32,
            color: Palette.labelPrimaryDark,
            fontWeight: FontWeight.w500,
          ),
          //? Title
          titleMedium: TextStyle(
            fontSize: 20,
            height: 32 / 20,
            color: Palette.labelPrimaryDark,
            fontWeight: FontWeight.w500,
          ),
          //? Body
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 20 / 16,
            color: Palette.labelPrimaryDark,
            fontWeight: FontWeight.w400,
          ),
          //? Button
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 24 / 14,
            color: Palette.labelPrimaryDark,
            fontWeight: FontWeight.w500,
          ),
          //? Subhead
          bodySmall: TextStyle(
            fontSize: 14,
            height: 20 / 14,
            color: Palette.labelPrimaryDark,
            fontWeight: FontWeight.w400,
          ),
        ),
      );
}
