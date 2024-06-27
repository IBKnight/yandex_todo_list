import 'package:flutter/material.dart';

/// icon-fonts
/// Таким же образом реализованы материаловские иконки
extension CustomIcons on Icons {
  static const _kFontFam = 'iconFonts';
  static const String? _kFontPkg = null;

  static const IconData _exclamationPoint =
      IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData _arrowDown =
      IconData(0xe801, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  static IconData get exclamationPoint {
    return _exclamationPoint;
  }

  static IconData get arrowDown {
    return _arrowDown;
  }
}
