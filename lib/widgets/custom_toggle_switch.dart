import 'package:flutter/cupertino.dart';
import 'package:heavenz/constants/color_constants.dart';

class CustomToggleSwitch extends StatefulWidget {
  CustomToggleSwitch({
    Key? key,
    required this.switchValue,
    required this.scaleSize,
    required this.bgColor,
    required this.onChanged,
  }) : super(key: key);

  final bool switchValue;
  final double scaleSize;
  final Color bgColor;
  final onChanged;

  _CustomToggleSwitchState createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: widget.scaleSize,
      child: CupertinoSwitch(
        value: widget.switchValue,
        activeColor: widget.bgColor,
        trackColor: widget.bgColor,
        onChanged: (bool value) {
          widget.onChanged(value);
        },
      ),
    );
  }
}
