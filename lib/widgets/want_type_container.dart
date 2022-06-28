import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/widgets/container_with_notification.dart';

enum ImagePosition { left, right }

class WantTypeContainer extends StatelessWidget {
  const WantTypeContainer({
    Key? key,
    required this.title,
    required this.textWidth,
    required this.imageHeight,
    required this.imageWidth,
    this.matchesCount,
    this.interestedShownCount,
    this.onlineNowCount,
    this.interestedInMeCount,
    this.blockedCount,
    required this.image,
    required this.extraPaddingForTitle,
    required this.imagePosition,
    required this.textAlign,
    this.onPressed,
    this.leftPaddingForSubSections,
    required this.decorationRequired,
    required this.subContainersRequired,
    required this.containerHeight,
    required this.columnMainAxisAlignment,
    required this.containerBgColor,
    this.moveToSubSecBasedProfilesListScreen,
    required this.categoryIndex,
    this.updateCategoryAndSubSectionIndex,
  }) : super(key: key);

  final int categoryIndex;
  final String title;
  final double textWidth;
  final double imageHeight;
  final double imageWidth;
  final double containerHeight;
  final String? matchesCount;
  final String? interestedShownCount;
  final String? onlineNowCount;
  final String? interestedInMeCount;
  final String? blockedCount;
  final AssetImage image;
  final double extraPaddingForTitle;
  final ImagePosition imagePosition;
  final TextAlign textAlign;
  final onPressed;
  final double? leftPaddingForSubSections;

  final bool decorationRequired;
  final bool subContainersRequired;
  final MainAxisAlignment columnMainAxisAlignment;
  final Color containerBgColor;
  final moveToSubSecBasedProfilesListScreen;

  final updateCategoryAndSubSectionIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            height: containerHeight,
            decoration: (decorationRequired == true)
                ? BoxDecoration(
                    color: containerBgColor,
                    borderRadius: const BorderRadius.all(Radius.circular(11.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4), blurRadius: 12.0)
                    ],
                  )
                : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Stack(
                //alignment: Alignment.topRight,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: imagePosition == ImagePosition.left
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Container(
                            height: imageHeight,
                            width: imageWidth,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: image,
                              ),
                              color: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(14.0),
                                bottomLeft: Radius.circular(14.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (imagePosition == ImagePosition.left)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: textWidth,
                        height: containerHeight,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: columnMainAxisAlignment,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: extraPaddingForTitle, right: 10.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  title,
                                  textAlign: textAlign,
                                  style: FontType.normal.style(
                                    size: 34,
                                    color: ColorConstants.appGreen,
                                    appFontFamilyName: 'Galada',
                                    /*shadows: [
                                      Shadow(
                                        blurRadius: 0.2,
                                        color: ColorConstants.appGreen,
                                        offset: const Offset(0.1, 0.1),
                                      ),
                                    ],*/
                                  ),
                                ),
                              ),
                            ),
                            if (subContainersRequired)
                              Padding(
                                padding: EdgeInsets.only(
                                    left: leftPaddingForSubSections!),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: ContainerWithNotification(
                                        bgColor: ColorConstants.appPurpleDark,
                                        notificationbgColor:
                                            ColorConstants.notificationGreen,
                                        notificationCounter: matchesCount!,
                                        title: 'Matches',
                                        width: 64,
                                        height: 18,
                                        borderRadius: 10.0,
                                        fontSize: 8.0,
                                        fontColor: Colors.white,
                                        notificationFontSize: 8.0,
                                        notificationRadius: 6.0,
                                        notificationWidth: 14.0,
                                        onclicked: () {
                                          updateCategoryAndSubSectionIndex(
                                              categoryIndex, 0);
                                          moveToSubSecBasedProfilesListScreen();
                                        },
                                      ),
                                    ),
                                    ContainerWithNotification(
                                        bgColor: ColorConstants.appPurpleDark,
                                        notificationbgColor:
                                            ColorConstants.notificationGreen,
                                        notificationCounter:
                                            interestedShownCount!,
                                        title: 'Interested shown',
                                        width: 102,
                                        height: 18,
                                        borderRadius: 10.0,
                                        fontSize: 8.0,
                                        fontColor: Colors.white,
                                        notificationFontSize: 8.0,
                                        notificationRadius: 6.0,
                                        notificationWidth: 14.0,
                                        onclicked: () {
                                          updateCategoryAndSubSectionIndex(
                                              categoryIndex, 1);
                                          moveToSubSecBasedProfilesListScreen();
                                        }),
                                    ContainerWithNotification(
                                        bgColor: ColorConstants.appPurpleDark,
                                        notificationbgColor:
                                            ColorConstants.notificationGreen,
                                        notificationCounter: onlineNowCount!,
                                        title: 'Online Now',
                                        width: 64,
                                        height: 18,
                                        borderRadius: 10.0,
                                        fontSize: 8.0,
                                        fontColor: Colors.white,
                                        notificationFontSize: 8.0,
                                        notificationRadius: 6.0,
                                        notificationWidth: 14.0,
                                        onclicked: () {
                                          updateCategoryAndSubSectionIndex(
                                              categoryIndex, 2);
                                          moveToSubSecBasedProfilesListScreen();
                                        }),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: ContainerWithNotification(
                                          bgColor: ColorConstants.appPurpleDark,
                                          notificationbgColor:
                                              ColorConstants.notificationGreen,
                                          notificationCounter:
                                              interestedInMeCount!,
                                          title: 'Interested in Me',
                                          width: 102,
                                          height: 18,
                                          borderRadius: 10.0,
                                          fontSize: 8.0,
                                          fontColor: Colors.white,
                                          notificationFontSize: 8.0,
                                          notificationRadius: 6.0,
                                          notificationWidth: 14.0,
                                          onclicked: () {
                                            updateCategoryAndSubSectionIndex(
                                                categoryIndex, 3);
                                            moveToSubSecBasedProfilesListScreen();
                                          }),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: ContainerWithNotification(
                                          bgColor: ColorConstants.appPurpleDark,
                                          notificationbgColor:
                                              ColorConstants.notificationRed,
                                          notificationCounter: blockedCount!,
                                          title: 'Blocked',
                                          width: 64,
                                          height: 18,
                                          borderRadius: 10.0,
                                          fontSize: 8.0,
                                          fontColor: Colors.white,
                                          notificationFontSize: 8.0,
                                          notificationRadius: 6.0,
                                          notificationWidth: 14.0,
                                          onclicked: () {
                                            updateCategoryAndSubSectionIndex(
                                                categoryIndex, 4);
                                            moveToSubSecBasedProfilesListScreen();
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  else
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: textWidth,
                        height: containerHeight,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: columnMainAxisAlignment,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(left: extraPaddingForTitle),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  title,
                                  textAlign: textAlign,
                                  style: FontType.normal.style(
                                    size: 34,
                                    color: ColorConstants.appGreen,
                                    appFontFamilyName: 'Galada',
                                    /*shadows: [
                                      Shadow(
                                        blurRadius: 0.3,
                                        color: ColorConstants.appGreen,
                                        offset: const Offset(0.15, 0.15),
                                      ),
                                    ],*/
                                  ),
                                ),
                              ),
                            ),
                            if (subContainersRequired)
                              Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: ContainerWithNotification(
                                        bgColor: ColorConstants.appPurpleDark,
                                        notificationbgColor:
                                            ColorConstants.notificationGreen,
                                        notificationCounter: matchesCount!,
                                        title: 'Matches',
                                        width: 64,
                                        height: 18,
                                        borderRadius: 10.0,
                                        fontSize: 8.0,
                                        fontColor: Colors.white,
                                        notificationFontSize: 8.0,
                                        notificationRadius: 6.0,
                                        notificationWidth: 14.0,
                                        onclicked: () {
                                          updateCategoryAndSubSectionIndex(
                                              categoryIndex, 0);
                                          moveToSubSecBasedProfilesListScreen();
                                        }),
                                  ),
                                  ContainerWithNotification(
                                      bgColor: ColorConstants.appPurpleDark,
                                      notificationbgColor:
                                          ColorConstants.notificationGreen,
                                      notificationCounter:
                                          interestedShownCount!,
                                      title: 'Interested shown',
                                      width: 102,
                                      height: 18,
                                      borderRadius: 10.0,
                                      fontSize: 8.0,
                                      fontColor: Colors.white,
                                      notificationFontSize: 8.0,
                                      notificationRadius: 6.0,
                                      notificationWidth: 14.0,
                                      onclicked: () {
                                        updateCategoryAndSubSectionIndex(
                                            categoryIndex, 1);
                                        moveToSubSecBasedProfilesListScreen();
                                      }),
                                  ContainerWithNotification(
                                      bgColor: ColorConstants.appPurpleDark,
                                      notificationbgColor:
                                          ColorConstants.notificationGreen,
                                      notificationCounter: onlineNowCount!,
                                      title: 'Online Now',
                                      width: 64,
                                      height: 18,
                                      borderRadius: 10.0,
                                      fontSize: 8.0,
                                      fontColor: Colors.white,
                                      notificationFontSize: 8.0,
                                      notificationRadius: 6.0,
                                      notificationWidth: 14.0,
                                      onclicked: () {
                                        updateCategoryAndSubSectionIndex(
                                            categoryIndex, 2);
                                        moveToSubSecBasedProfilesListScreen();
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: ContainerWithNotification(
                                        bgColor: ColorConstants.appPurpleDark,
                                        notificationbgColor:
                                            ColorConstants.notificationGreen,
                                        notificationCounter:
                                            interestedInMeCount!,
                                        title: 'Interested in Me',
                                        width: 102,
                                        height: 18,
                                        fontColor: Colors.white,
                                        borderRadius: 10.0,
                                        fontSize: 8.0,
                                        notificationFontSize: 8.0,
                                        notificationRadius: 6.0,
                                        notificationWidth: 14.0,
                                        onclicked: () {
                                          updateCategoryAndSubSectionIndex(
                                              categoryIndex, 3);
                                          moveToSubSecBasedProfilesListScreen();
                                        }),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: ContainerWithNotification(
                                        bgColor: ColorConstants.appPurpleDark,
                                        notificationbgColor:
                                            ColorConstants.notificationRed,
                                        notificationCounter: blockedCount!,
                                        title: 'Blocked',
                                        width: 64,
                                        height: 18,
                                        borderRadius: 10.0,
                                        fontSize: 8.0,
                                        fontColor: Colors.white,
                                        notificationFontSize: 8.0,
                                        notificationRadius: 6.0,
                                        notificationWidth: 14.0,
                                        onclicked: () {
                                          updateCategoryAndSubSectionIndex(
                                              categoryIndex, 4);
                                          moveToSubSecBasedProfilesListScreen();
                                        }),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
