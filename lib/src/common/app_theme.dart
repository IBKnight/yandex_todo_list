import 'package:flutter/material.dart';
import 'palette.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        dividerTheme: const DividerThemeData(
          thickness: 0.5,
          color: Palette.separatorLight,
        ),
        useMaterial3: false,
        checkboxTheme: const CheckboxThemeData(
          fillColor: WidgetStatePropertyAll(Palette.backSecondaryLight),
          side: BorderSide(color: Palette.separatorLight, width: 2),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          outlineBorder: BorderSide.none,
        ),
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
