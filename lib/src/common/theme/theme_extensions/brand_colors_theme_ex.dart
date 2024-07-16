import 'package:flutter/material.dart';

@immutable
class BrandColors extends ThemeExtension<BrandColors> {
  final Color? separator;
  final Color? overlay;
  final Color? labelPrimary;
  final Color? labelSecondary;
  final Color? labelTertiary;
  final Color? labelDisable;
  final Color? red;
  final Color? green;
  final Color? blue;
  final Color? colorGray;
  final Color? colorLightGray;
  final Color? colorWhite;
  final Color? backPrimary;
  final Color? backSecondary;
  final Color? backElevated;

  const BrandColors({
    required this.separator,
    required this.overlay,
    required this.labelPrimary,
    required this.labelSecondary,
    required this.labelTertiary,
    required this.labelDisable,
    required this.red,
    required this.green,
    required this.blue,
    required this.colorGray,
    required this.colorLightGray,
    required this.colorWhite,
    required this.backPrimary,
    required this.backSecondary,
    required this.backElevated,
  });

  @override
  BrandColors lerp(ThemeExtension<BrandColors>? other, double t) {
    if (other is! BrandColors) {
      return this;
    }
    return BrandColors(
      separator: Color.lerp(separator, other.separator, t),
      overlay: Color.lerp(overlay, other.overlay, t),
      labelPrimary: Color.lerp(labelPrimary, other.labelPrimary, t),
      labelSecondary: Color.lerp(labelSecondary, other.labelSecondary, t),
      labelTertiary: Color.lerp(labelTertiary, other.labelTertiary, t),
      labelDisable: Color.lerp(labelDisable, other.labelDisable, t),
      red: Color.lerp(red, other.red, t),
      green: Color.lerp(green, other.green, t),
      blue: Color.lerp(blue, other.blue, t),
      colorGray: Color.lerp(colorGray, other.colorGray, t),
      colorLightGray: Color.lerp(colorLightGray, other.colorLightGray, t),
      colorWhite: Color.lerp(colorWhite, other.colorWhite, t),
      backPrimary: Color.lerp(backPrimary, other.backPrimary, t),
      backSecondary: Color.lerp(backSecondary, other.backSecondary, t),
      backElevated: Color.lerp(backElevated, other.backElevated, t),
    );
  }

  @override
  BrandColors copyWith({
    Color? separator,
    Color? overlay,
    Color? labelPrimary,
    Color? labelSecondary,
    Color? labelTertiary,
    Color? labelDisable,
    Color? red,
    Color? green,
    Color? blue,
    Color? colorGray,
    Color? colorLightGray,
    Color? colorWhite,
    Color? backPrimary,
    Color? backSecondary,
    Color? backElevated,
  }) {
    return BrandColors(
      separator: separator ?? this.separator,
      overlay: overlay ?? this.overlay,
      labelPrimary: labelPrimary ?? this.labelPrimary,
      labelSecondary: labelSecondary ?? this.labelSecondary,
      labelTertiary: labelTertiary ?? this.labelTertiary,
      labelDisable: labelDisable ?? this.labelDisable,
      red: red ?? this.red,
      green: green ?? this.green,
      blue: blue ?? this.blue,
      colorGray: colorGray ?? this.colorGray,
      colorLightGray: colorLightGray ?? this.colorLightGray,
      colorWhite: colorWhite ?? this.colorWhite,
      backPrimary: backPrimary ?? this.backPrimary,
      backSecondary: backSecondary ?? this.backSecondary,
      backElevated: backElevated ?? this.backElevated,
    );
  }
}
