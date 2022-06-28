// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';

import 'app_button.dart';

enum Preferences { main, level, timing, training }

class MatchDialogBox extends StatefulWidget {
  MatchDialogBox({
    Key? key,
    required this.name,
    required this.image_url_1,
    required this.image_url_2,
  }) : super(key: key);

  final String name;
  final String image_url_1;
  final String image_url_2;

  @override
  _MatchDialogBoxState createState() => _MatchDialogBoxState();
}

class _MatchDialogBoxState extends State<MatchDialogBox> {
  var tappedLevel = "Intermedio";

  var noOfPages = 3;

  List<int> selectedTrainingsIndexes = [];

  @override
  Widget build(BuildContext context) {
    return buildAlertBox(context);
  }

  buildAlertBox(BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 14),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: const BorderRadius.all(Radius.circular(24.0))),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.01),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 72.0, bottom: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Match",
                          style: FontType.extraBold.style(
                            size: 40,
                            color: Colors.white,
                            appFontFamilyName: 'Poppins',
                            shadows: [
                              Shadow(
                                blurRadius: 0.5,
                                color: Colors.grey,
                                offset: Offset(0.3, 0.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      space(h: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          "You and ${widget.name} have shown interest each other",
                          textAlign: TextAlign.center,
                          style: FontType.normal.style(
                            size: 20.0,
                            color: Colors.white,
                            appFontFamilyName: 'Poppins',
                            shadows: [
                              Shadow(
                                blurRadius: 0.4,
                                color: Colors.grey,
                                offset: Offset(0.2, 0.2),
                              ),
                            ],
                          ),
                        ),
                      ),
                      space(h: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(2), // Border width
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(60), // Image radius
                                child: Image.network(widget.image_url_1,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          space(w: 28.0),
                          Container(
                            padding: EdgeInsets.all(2), // Border width
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: ClipOval(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(60), // Image radius
                                child: Image.network(widget.image_url_2,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          )
                        ],
                      ),
                      space(h: 8.0),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: AppButton(
                                bgColor: Colors.white.withOpacity(0.45),
                                borderRadius: 27.0,
                                fontFamily: 'Segoe UI',
                                fontSize: 22.0,
                                onPressed: () {},
                                title: 'Chat Now',
                                textColor: Colors.white,
                                height: 54,
                              ),
                            ),
                            space(h: 12.0),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: AppButton(
                                bgColor: Colors.white.withOpacity(0.45),
                                borderRadius: 27.0,
                                fontFamily: 'Segoe UI',
                                fontSize: 22.0,
                                onPressed: () {},
                                title: 'Later',
                                textColor: Colors.white,
                                height: 54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ) //
            ],
          ),
        ),
      );
}
