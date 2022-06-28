// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    Key? key,
    required this.onTabTapped,
    required this.currentIndex,
    required this.showText,
    required this.makeTextDelayed,
  }) : super(key: key);

  final onTabTapped;
  int currentIndex;
  bool showText;
  final makeTextDelayed;
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        alignment: Alignment.center,
        height: 60,
        color: const Color(0xFFEDF0F0),
        child: SizedBox(
          //width: double.infinity,
          //height: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                bottomButtonContainer(
                    0,
                    const AssetImage("images/ic_home_light.png"),
                    const AssetImage("images/ic_home_dark.png"),
                    "Home"),
                bottomButtonContainer(
                    1,
                    const AssetImage("images/ic_search_light.png"),
                    const AssetImage("images/ic_search_dark.png"),
                    "Search"),
                bottomButtonContainer(
                    2,
                    const AssetImage("images/ic_chat_light.png"),
                    const AssetImage("images/ic_chat_dark.png"),
                    "Chats"),
                bottomButtonContainer(
                    3,
                    const AssetImage("images/ic_user_light.png"),
                    const AssetImage("images/ic_user_dark.png"),
                    "Profile"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomButtonContainer(int index, AssetImage tappedImage,
      AssetImage unTappedImage, String iconText) {
    return SizedBox(
      //height: 35,
      child: Center(
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              widget.onTabTapped(index);
              widget.currentIndex = index;
              widget.makeTextDelayed();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: AnimatedContainer(
                width: getContainerWidth(index),
                alignment: Alignment.centerLeft,
                //constraints: BoxConstraints(minWidth: 50.0),
                duration: const Duration(milliseconds: 700),
                //curve: Curves.linearToEaseOut,
                decoration: BoxDecoration(
                  color: getBackgroundColor(index),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(18.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (widget.currentIndex == index)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 2.0),
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: tappedImage,
                              ),
                            ),
                          ),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2.0, vertical: 2.0),
                          child: Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: unTappedImage,
                              ),
                            ),
                          ),
                        ),
                      Visibility(
                        maintainSize: false,
                        maintainAnimation: true,
                        maintainState: true,
                        visible:
                            (widget.currentIndex == index && widget.showText)
                                ? true
                                : false, //checkTextVisible(index),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              iconText,
                              textAlign: TextAlign.center,
                              style: FontType.normal.style(
                                  size: 15,
                                  color: ColorConstants.appGreenLight,
                                  appFontFamilyName: 'Segoe UI'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool checkTextVisible(int index) {
    if (widget.currentIndex == index) {
      return true;
    } else {
      return false;
    }
  }

  Color getBackgroundColor(int index) {
    if (widget.currentIndex == index) {
      return ColorConstants.appPurpleDark;
    } else {
      return const Color(0xFFEDF0F0);
    }
  }

  Color getTextColor(int index) {
    if (widget.currentIndex == index) {
      return ColorConstants.appGreenLight;
    } else {
      return ColorConstants.appPurpleDark;
    }
  }

  double getContainerWidth(int index) {
    if (widget.currentIndex == index) {
      return 100.0;
    } else {
      return 50.0;
    }
  }
}
