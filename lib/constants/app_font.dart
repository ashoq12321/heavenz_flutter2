import 'package:flutter/material.dart';

enum FontType { normal, medium, bold, extraBold }

//const String appFontFamilyName = 'Poppins';

/*
// Font weight
400	Normal (Regular)
500	Medium
600	Semi Bold (Demi Bold)
700	Bold
*/
extension FontTypeExtn on FontType {
  TextStyle style({
    required double size,
    required Color color,
    double? lineSpace,
    TextDecoration? decoration,
    required String appFontFamilyName,
    List<Shadow>? shadows,
  }) {
    FontWeight weight = FontWeight.normal;
    switch (this) {
      case FontType.normal:
        weight = FontWeight.w400;
        break;
      case FontType.medium:
        weight = FontWeight.w500;
        break;

      case FontType.bold:
        weight = FontWeight.w700;
        break;
      case FontType.extraBold:
        weight = FontWeight.w800;
        break;
    }

    return TextStyle(
      decoration: decoration,
      fontSize: size,
      color: color,
      height: lineSpace,
      fontWeight: weight,
      fontFamily: appFontFamilyName,
      shadows: shadows,
    );
  }
}
