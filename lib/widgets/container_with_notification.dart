import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/widgets/notification_counter.dart';

class ContainerWithNotification extends StatelessWidget {
  ContainerWithNotification({
    Key? key,
    required this.title,
    required this.notificationCounter,
    required this.bgColor,
    required this.width,
    required this.onclicked,
    required this.notificationbgColor,
    required this.height,
    required this.borderRadius,
    required this.fontSize,
    required this.notificationWidth,
    required this.notificationFontSize,
    required this.notificationRadius,
    required this.fontColor,
    this.boxShadow,
  }) : super(key: key);

  final onclicked;
  final String title;
  final String notificationCounter;
  final Color notificationbgColor;
  final Color bgColor;
  final double width;
  final double height;
  final double borderRadius;
  final double fontSize;
  final double notificationWidth;
  final double notificationFontSize;
  final double notificationRadius;
  final Color fontColor;
  bool? boxShadow = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onclicked,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 7),
            child: Container(
              //alignment: Alignment.center,
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
                boxShadow: [
                  boxShadow == true
                      ? BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          blurRadius: 6.0,
                          offset: Offset(0, 3),
                        )
                      : BoxShadow(),
                ],
              ),
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: FontType.normal.style(
                        size: fontSize,
                        color: fontColor,
                        appFontFamilyName: 'Segoe UI'),
                  ),
                ),
              ),
            ),
          ),
        ),
        NotificationCounter(
          rightPosition: 2,
          counter: notificationCounter,
          topPosition: 0,
          bgColor: notificationbgColor,
          fontSize: notificationFontSize,
          width: notificationWidth,
          radius: notificationRadius,
        ),
      ],
    );
  }
}
