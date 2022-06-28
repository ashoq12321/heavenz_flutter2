import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/widgets/custom_animations/custom_searching_animation.dart';
import 'package:heavenz/widgets/want_type_container.dart';

class SearchingSwipeListScreen extends StatefulWidget {
  const SearchingSwipeListScreen({
    Key? key,
    required this.wantTypeIndex,
  }) : super(key: key);

  final int wantTypeIndex;

  @override
  _SearchingSwipeListScreenState createState() =>
      _SearchingSwipeListScreenState();
}

class _SearchingSwipeListScreenState extends State<SearchingSwipeListScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorConstants.appWhite,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: ColorConstants.appWhite,
            child: Column(
              children: [
                if (widget.wantTypeIndex == 0)
                  WantTypeContainer(
                    title: 'Want room Mate',
                    textWidth: 320,
                    imageHeight: 52,
                    imageWidth: 56,
                    image: AssetImage("images/ic_room_mate.png"),
                    extraPaddingForTitle: 0,
                    imagePosition: ImagePosition.left,
                    textAlign: TextAlign.end,
                    leftPaddingForSubSections: 40.0,
                    containerHeight: 60.0,
                    decorationRequired: false,
                    subContainersRequired: false,
                    columnMainAxisAlignment: MainAxisAlignment.center,
                    containerBgColor: ColorConstants.appGreen,
                    categoryIndex: 0,
                  )
                else if (widget.wantTypeIndex == 1)
                  WantTypeContainer(
                    title: 'Want Work',
                    textWidth: 300,
                    imageHeight: 52,
                    imageWidth: 56,
                    image: AssetImage("images/ic_want_work.png"),
                    extraPaddingForTitle: 10,
                    imagePosition: ImagePosition.right,
                    textAlign: TextAlign.start,
                    leftPaddingForSubSections: 0,
                    containerHeight: 60.0,
                    decorationRequired: false,
                    subContainersRequired: false,
                    columnMainAxisAlignment: MainAxisAlignment.center,
                    containerBgColor: ColorConstants.appWhite,
                    categoryIndex: 1,
                  )
                else if (widget.wantTypeIndex == 2)
                  WantTypeContainer(
                    title: 'Want Love',
                    textWidth: 296,
                    imageHeight: 52,
                    imageWidth: 56,
                    image: AssetImage("images/ic_want_love.png"),
                    extraPaddingForTitle: 52,
                    imagePosition: ImagePosition.left,
                    textAlign: TextAlign.start,
                    leftPaddingForSubSections: 20.0,
                    containerHeight: 60.0,
                    decorationRequired: false,
                    subContainersRequired: false,
                    columnMainAxisAlignment: MainAxisAlignment.center,
                    containerBgColor: ColorConstants.appWhite,
                    categoryIndex: 2,
                  )
                else if (widget.wantTypeIndex == 3)
                  WantTypeContainer(
                    title: 'Want Marriage',
                    textWidth: 300,
                    imageHeight: 52,
                    imageWidth: 56,
                    image: AssetImage("images/ic_want_marriage.png"),
                    extraPaddingForTitle: 10,
                    imagePosition: ImagePosition.right,
                    textAlign: TextAlign.start,
                    leftPaddingForSubSections: 0,
                    containerHeight: 60.0,
                    decorationRequired: false,
                    subContainersRequired: false,
                    columnMainAxisAlignment: MainAxisAlignment.center,
                    containerBgColor: ColorConstants.appWhite,
                    categoryIndex: 3,
                  )
                else if (widget.wantTypeIndex == 4)
                  WantTypeContainer(
                    title: 'Want Friend',
                    textWidth: 300,
                    imageHeight: 52,
                    imageWidth: 56,
                    image: AssetImage("images/ic_want_friend.png"),
                    extraPaddingForTitle: 74.0,
                    imagePosition: ImagePosition.left,
                    textAlign: TextAlign.start,
                    leftPaddingForSubSections: 20.0,
                    containerHeight: 60.0,
                    decorationRequired: false,
                    subContainersRequired: false,
                    columnMainAxisAlignment: MainAxisAlignment.center,
                    containerBgColor: ColorConstants.appWhite,
                    categoryIndex: 4,
                  ),
                SearchingAnimation(),
                Text(
                  "Stay cool !",
                  textAlign: TextAlign.center,
                  style: FontType.normal.style(
                    size: 20,
                    color: ColorConstants.appPurpleDark,
                    appFontFamilyName: 'Poppins',
                    shadows: [
                      Shadow(
                        blurRadius: 0.5,
                        color: ColorConstants.appPurpleDark,
                        offset: Offset(0.2, 0.2),
                      ),
                    ],
                  ),
                ),
                space(h: 18.0),
                Text(
                  "Searching for the suitable profiles",
                  textAlign: TextAlign.center,
                  style: FontType.normal.style(
                    size: 20,
                    color: ColorConstants.appPurpleDark,
                    appFontFamilyName: 'Poppins',
                    shadows: [
                      Shadow(
                        blurRadius: 0.5,
                        color: ColorConstants.appPurpleDark,
                        offset: Offset(0.2, 0.2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
