import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';

class CustomDOBField extends StatefulWidget {
  const CustomDOBField({
    Key? key,
    required this.dobText,
    this.suffixIcon,
    this.containerHeight,
    this.onclicked,
  }) : super(key: key);
  final String dobText;
  final String? suffixIcon; // just to show checkmark
  final double? containerHeight;
  final onclicked;
  @override
  _CustomDOBFieldState createState() => _CustomDOBFieldState();
}

class _CustomDOBFieldState extends State<CustomDOBField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onclicked,
      child: Container(
        height: widget.containerHeight ?? 48,
        decoration: new BoxDecoration(
          border: Border.all(width: 1.0, color: ColorConstants.appGreen),
          borderRadius: BorderRadius.circular(8.0),
          color: ColorConstants.appWhite,
          boxShadow: [
            BoxShadow(
              blurRadius: 0.5,
              color: ColorConstants.appGreen,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 18.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.dobText,
                  style: FontType.normal.style(
                    size: 18.0,
                    color: Colors.black.withOpacity(0.52),
                    appFontFamilyName: 'Poppins',
                    shadows: [
                      Shadow(
                        blurRadius: 0.5,
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(0.3, 0.3),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12,
                      ),
                      child: Image.asset(
                        'images/ic_dropdown.png',
                        color: ColorConstants.appGreen,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
