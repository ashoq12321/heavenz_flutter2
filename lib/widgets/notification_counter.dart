import 'package:flutter/material.dart';

class NotificationCounter extends StatelessWidget {
  const NotificationCounter({
    Key? key,
    required this.counter,
    required this.rightPosition,
    required this.topPosition,
    required this.bgColor,
    required this.fontSize,
    required this.width,
    required this.radius,
  }) : super(key: key);

  final String counter;
  final double rightPosition;
  final double topPosition;
  final Color bgColor;
  final double fontSize;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: rightPosition,
      top: topPosition,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        constraints: BoxConstraints(
          minWidth: width,
          minHeight: width,
        ),
        child: Center(
          child: Text(
            counter,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
            ),
            //textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
