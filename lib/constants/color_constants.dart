import 'package:flutter/material.dart';

class ColorConstants {
  static Color appPurple = const Color(0xFF300055);
  static Color appPurple2 = const Color(0xFF331749);
  static Color appPurpleDark = const Color(0xFF524A72);
  static Color appPurpleLight = const Color(0xFF662D91);
  static Color appWhiteLight = const Color(0xFFF8F8F8);
  static Color appWhite = const Color(0xFFF9F9F9);

  static Color appViolet = const Color(0xFF450DE5);

  static Color appGrey = const Color(0xFF707070);
  static Color appGrey1 = const Color(0xFFE3E3E3);
  static Color iconsGrey = const Color(0xFF666666);
  static Color appGreenDark = const Color(0xFF13A89E);
  static Color appGreenLight = const Color(0xFF98FDF7);
  static Color appGreen = const Color(0xFF44ABAA);
  static Color notificationRed = const Color(0xFFB60000);
  static Color appRed = const Color(0xFFCB0000);
  static Color notificationGreen = const Color(0xFF14C31A);
  static Color onlineIndicator = const Color(0xFF3FF95E);
}

Widget space({double? w, double? h}) {
  return SizedBox(
    width: w,
    height: h,
  );
}
