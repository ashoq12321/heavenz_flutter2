import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';

class VerticalSlider extends StatefulWidget {
  const VerticalSlider({
    Key? key,
    required this.currentRangeValues,
    required this.currentValue,
    required this.rangeSlider,
    required this.maxValue,
    required this.onChanged,
  }) : super(key: key);

  final RangeValues currentRangeValues;
  final double currentValue;
  final bool rangeSlider;
  final double maxValue;
  final onChanged;

  @override
  _VerticalSliderState createState() => _VerticalSliderState();
}

class _VerticalSliderState extends State<VerticalSlider> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 13.0,
        overlayShape: RoundSliderOverlayShape(
          overlayRadius: 20.0,
        ),
        overlayColor: Colors.transparent,
        rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 7.5),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.5),
        thumbColor: ColorConstants.appViolet,
        activeTrackColor: ColorConstants.appViolet,
        inactiveTrackColor: ColorConstants.appViolet.withOpacity(0.1),
      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Column(
          children: [
            if (widget.rangeSlider)
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.8 * 0.25,
                    width: 282,
                    alignment: Alignment.bottomCenter,
                    child: RangeSlider(
                      values: widget.currentRangeValues,
                      max: widget.maxValue,
                      divisions: widget.maxValue.toInt(),
                      onChanged: (RangeValues values) {
                        setState(() {
                          widget.onChanged(values);
                        });
                      },
                    ),
                  ),
                  Positioned(
                    left: 10 + widget.currentRangeValues.start * 2.42,
                    bottom: 0,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          widget.currentRangeValues.start.round().toString(),
                          textAlign: TextAlign.start,
                          style: FontType.normal.style(
                            size: 12,
                            color: ColorConstants.appViolet,
                            appFontFamilyName: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10 + widget.currentRangeValues.end * 2.42,
                    bottom: 0,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          widget.currentRangeValues.end.round().toString(),
                          textAlign: TextAlign.start,
                          style: FontType.normal.style(
                            size: 12,
                            color: ColorConstants.appViolet,
                            appFontFamilyName: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            else
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.8 * 0.25,
                    width: 282,
                    child: Slider(
                      max: widget.maxValue,
                      divisions: widget.maxValue ~/ 10,
                      onChanged: (value) {
                        setState(() {
                          widget.onChanged(value);
                        });
                      },
                      value: widget.currentValue,
                    ),
                  ),
                  Positioned(
                    left: 10 + widget.currentValue * 2.42 / 5,
                    bottom: 0,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          widget.currentValue.round().toString(),
                          textAlign: TextAlign.start,
                          style: FontType.normal.style(
                            size: 12,
                            color: ColorConstants.appViolet,
                            appFontFamilyName: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
