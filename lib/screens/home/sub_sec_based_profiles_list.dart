import 'dart:async';

import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/models/view_person.dart';
import 'package:heavenz/widgets/app_button.dart';
import 'package:heavenz/widgets/notification_counter.dart';
import 'package:heavenz/widgets/sub_sec_based_profile_container.dart';
import 'package:heavenz/widgets/want_type_container.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SubSectionBasedProfilesList extends StatefulWidget {
  const SubSectionBasedProfilesList(
      {Key? key,
      required this.onBackPressed,
      required this.moveToViewProfileScreen,
      required this.usersList,
      required this.categoryIndex,
      required this.subSectionIndex,
      required this.updateSubSectionIndex})
      : super(key: key);

  final onBackPressed;
  final moveToViewProfileScreen;
  final int categoryIndex;
  final int subSectionIndex;
  final List<ViewPerson> usersList;
  final updateSubSectionIndex;

  @override
  _SubSectionBasedProfilesListState createState() =>
      _SubSectionBasedProfilesListState();
}

class _SubSectionBasedProfilesListState
    extends State<SubSectionBasedProfilesList> {
  final ItemScrollController itemScrollController = ItemScrollController();

  int currentPersonIndex = 0;

  @override
  void initState() {
    super.initState();
    _getThingsOnStartup().then((value) {
      moveToVisibleIndex();
    });
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.onBackPressed,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: ColorConstants.appWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getCategoryTitle()!,
              getSubSectionsRow(),
              space(h: 4.0),
              Expanded(
                child: Container(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      for (int i = 0; i < widget.usersList.length; i++)
                        SubSectionBasedProfileContainer(
                          age: widget.usersList[i].age,
                          name: widget.usersList[i].name,
                          imageString: widget.usersList[i].imageString,
                          onlineNow: true,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  moveToProfileSceen() {
    //print("fkfvkv");
    widget.moveToViewProfileScreen(widget.usersList[currentPersonIndex]);
  }

  Widget? getCategoryTitle() {
    if (widget.categoryIndex == 0)
      return WantTypeContainer(
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
      );
    else if (widget.categoryIndex == 1)
      return WantTypeContainer(
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
      );
    else if (widget.categoryIndex == 2)
      return WantTypeContainer(
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
      );
    else if (widget.categoryIndex == 3)
      return WantTypeContainer(
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
      );
    else if (widget.categoryIndex == 4)
      return WantTypeContainer(
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
      );
  }

  getSubSectionsRow() {
    return Container(
      height: 50,
      child: ScrollablePositionedList.builder(
        scrollDirection: Axis.horizontal,
        initialScrollIndex: 0,
        itemCount: 5,
        itemScrollController: itemScrollController,
        itemBuilder: (BuildContext context, int index) =>
            getSubSecSingleItem(index),
      ),
    );
  }

  getSubSecSingleItem(int index) {
    if (index == 0)
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 119.0,
              child: AppButton(
                bgColor: widget.subSectionIndex == 0
                    ? ColorConstants.appGreen
                    : ColorConstants.appWhite,
                borderColor: ColorConstants.appGreen,
                borderRadius: 17.0,
                fontFamily: 'Poppins',
                fontSize: 15.0,
                onPressed: () {
                  widget.updateSubSectionIndex(0);
                },
                title: 'Matches',
                textColor:
                    widget.subSectionIndex == 0 ? Colors.white : Colors.black,
                height: 34.0,
              ),
            ),
          ),
          NotificationCounter(
            rightPosition: 2,
            counter: "2",
            topPosition: 0,
            bgColor: ColorConstants.notificationGreen,
            fontSize: 12,
            width: 20,
            radius: 12,
          ),
        ],
      );
    else if (index == 1)
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 166.0,
              child: AppButton(
                bgColor: widget.subSectionIndex == 1
                    ? ColorConstants.appGreen
                    : ColorConstants.appWhite,
                borderColor: ColorConstants.appGreen,
                borderRadius: 17.0,
                fontFamily: 'Poppins',
                fontSize: 15.0,
                onPressed: () {
                  widget.updateSubSectionIndex(1);
                },
                title: 'Interested shown',
                textColor:
                    widget.subSectionIndex == 1 ? Colors.white : Colors.black,
                height: 34.0,
              ),
            ),
          ),
          NotificationCounter(
            rightPosition: 2,
            counter: "2",
            topPosition: 0,
            bgColor: ColorConstants.notificationGreen,
            fontSize: 12,
            width: 20,
            radius: 12,
          ),
        ],
      );
    else if (index == 2)
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 119.0,
              child: AppButton(
                bgColor: widget.subSectionIndex == 2
                    ? ColorConstants.appGreen
                    : ColorConstants.appWhite,
                borderColor: ColorConstants.appGreen,
                borderRadius: 17.0,
                fontFamily: 'Poppins',
                fontSize: 15.0,
                onPressed: () {
                  widget.updateSubSectionIndex(2);
                },
                title: 'Online Now',
                textColor:
                    widget.subSectionIndex == 2 ? Colors.white : Colors.black,
                height: 34.0,
              ),
            ),
          ),
          NotificationCounter(
            rightPosition: 2,
            counter: "2",
            topPosition: 0,
            bgColor: ColorConstants.notificationGreen,
            fontSize: 12,
            width: 20,
            radius: 12,
          ),
        ],
      );
    else if (index == 3)
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 166.0,
              child: AppButton(
                bgColor: widget.subSectionIndex == 3
                    ? ColorConstants.appGreen
                    : ColorConstants.appWhite,
                borderColor: ColorConstants.appGreen,
                borderRadius: 17.0,
                fontFamily: 'Poppins',
                fontSize: 15.0,
                onPressed: () {
                  widget.updateSubSectionIndex(3);
                }, //widget.onSignInClicked,
                title: 'Interested in Me',
                textColor:
                    widget.subSectionIndex == 3 ? Colors.white : Colors.black,
                height: 34.0,
              ),
            ),
          ),
          NotificationCounter(
            rightPosition: 2,
            counter: "2",
            topPosition: 0,
            bgColor: ColorConstants.notificationGreen,
            fontSize: 12,
            width: 20,
            radius: 12,
          ),
        ],
      );
    else if (index == 4)
      return Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 119.0,
              child: AppButton(
                bgColor: widget.subSectionIndex == 4
                    ? ColorConstants.appGreen
                    : ColorConstants.appWhite,
                borderColor: ColorConstants.appGreen,
                borderRadius: 17.0,
                fontFamily: 'Poppins',
                fontSize: 15.0,
                onPressed: () {
                  widget.updateSubSectionIndex(4);
                }, //widget.onSignInClicked,
                title: 'Blocked',
                textColor:
                    widget.subSectionIndex == 4 ? Colors.white : Colors.black,
                height: 34.0,
              ),
            ),
          ),
          NotificationCounter(
            rightPosition: 2,
            counter: "2",
            topPosition: 0,
            bgColor: ColorConstants.appRed,
            fontSize: 12,
            width: 20,
            radius: 12,
          ),
        ],
      );
  }

  void moveToVisibleIndex() {
    itemScrollController.scrollTo(
        index: widget.subSectionIndex,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInOutCubic);
  }
}
