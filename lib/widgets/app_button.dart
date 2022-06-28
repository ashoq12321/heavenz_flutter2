import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {Key? key,
      required this.title,
      required this.bgColor,
      this.borderColor,
      required this.textColor,
      required this.onPressed,
      required this.fontSize,
      required this.borderRadius,
      required this.fontFamily,
      required this.height})
      : super(key: key);
  final Color bgColor;
  final Color? borderColor;
  final Color textColor;
  final String title;
  final double fontSize;
  final double borderRadius;
  final double height;
  final String fontFamily;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor ?? bgColor, width: 2.0)),
        child: Center(
          child: Text(
            title,
            style: FontType.normal.style(
              size: fontSize,
              color: textColor,
              appFontFamilyName: fontFamily,
              shadows: [
                Shadow(
                  blurRadius: 0.4,
                  color: textColor,
                  offset: Offset(0.2, 0.2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
