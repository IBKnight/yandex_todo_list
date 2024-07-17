import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/theme/theme_extensions/brand_colors_theme_ex.dart';
import '../palette.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        extensions: const [
          BrandColors(
            overlay: Palette.overlayLight,
            labelPrimary: Palette.labelPrimaryLight,
            separator: Palette.separatorLight,
            labelSecondary: Palette.labelSecondaryLight,
            labelTertiary: Palette.labelTertiaryLight,
            labelDisable: Palette.labelDisableLight,
            red: Palette.redLight,
            green: Palette.greenLight,
            blue: Palette.blueLight,
            colorGray: Palette.colorGrayLight,
            colorLightGray: Palette.colorLightGrayLight,
            colorWhite: Palette.colorWhiteLight,
            backPrimary: Palette.backPrimaryLight,
            backSecondary: Palette.backSecondaryLight,
            backElevated: Palette.backElevatedLight,
          ),
        ],
        scaffoldBackgroundColor: Palette.backPrimaryLight,
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.backPrimaryLight,
        ),
        snackBarTheme: const SnackBarThemeData(
          actionBackgroundColor: Palette.colorWhiteLight,
          actionTextColor: Palette.labelPrimaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          backgroundColor: Palette.redLight,
        ),
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
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Palette.blueDark,
          onPrimary: Palette.labelPrimaryDark,
          secondary: Palette.blueDark,
          onSecondary: Palette.labelPrimaryDark,
          error: Palette.redDark,
          onError: Palette.redDark,
          surface: Palette.blueDark,
          onSurface: Palette.labelPrimaryDark,
        ),
        snackBarTheme: const SnackBarThemeData(
          actionBackgroundColor: Palette.colorWhiteLight,
          actionTextColor: Palette.labelPrimaryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          backgroundColor: Palette.redLight,
        ),
        extensions: const [
          BrandColors(
            overlay: Palette.overlayDark,
            labelPrimary: Palette.labelPrimaryDark,
            separator: Palette.separatorDark,
            labelSecondary: Palette.labelSecondaryDark,
            labelTertiary: Palette.labelTertiaryDark,
            labelDisable: Palette.labelDisableDark,
            red: Palette.redDark,
            green: Palette.greenDark,
            blue: Palette.blueDark,
            colorGray: Palette.colorGrayDark,
            colorLightGray: Palette.colorLightGrayDark,
            colorWhite: Palette.colorWhiteDark,
            backPrimary: Palette.backPrimaryDark,
            backSecondary: Palette.backSecondaryDark,
            backElevated: Palette.backElevatedDark,
          ),
        ],
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Palette.backSecondaryDark,
          yearForegroundColor: WidgetStatePropertyAll(Palette.labelPrimaryDark),
          headerForegroundColor: Palette.labelPrimaryDark,
          weekdayStyle: TextStyle(color: Palette.labelTertiaryDark),
        ),
        scaffoldBackgroundColor: Palette.backPrimaryDark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.backPrimaryDark,
        ),
        useMaterial3: false,
        checkboxTheme: const CheckboxThemeData(
          fillColor: WidgetStatePropertyAll(Palette.backSecondaryDark),
          side: BorderSide(color: Palette.separatorDark, width: 2),
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
