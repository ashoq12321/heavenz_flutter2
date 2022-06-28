import 'package:flutter/material.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/widgets/want_type_container.dart';

class HomeInitial extends StatefulWidget {
  const HomeInitial(
      {Key? key,
      required this.moveToSwipeScreen,
      required this.moveToSubSecBasedProfilesListScreen,
      required this.updateCategoryAndSubSectionIndex})
      : super(key: key);

  final moveToSwipeScreen;
  final moveToSubSecBasedProfilesListScreen;
  final updateCategoryAndSubSectionIndex;

  @override
  _HomeInitialState createState() => _HomeInitialState();
}

class _HomeInitialState extends State<HomeInitial> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorConstants.appPurpleLight,
              ColorConstants.appGreenDark
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ListView(
            children: [
              WantTypeContainer(
                title: 'Want room Mate',
                textWidth: 320,
                onlineNowCount: '1',
                matchesCount: '2',
                interestedShownCount: '3',
                interestedInMeCount: '4',
                blockedCount: '5',
                imageHeight: 78,
                imageWidth: 82,
                image: AssetImage("images/ic_room_mate.png"),
                extraPaddingForTitle: 0,
                imagePosition: ImagePosition.left,
                textAlign: TextAlign.end,
                onPressed: () {
                  print("object");
                  //showSearchingAnimation(0);
                  widget.moveToSwipeScreen(0);
                },
                leftPaddingForSubSections: 40.0,
                containerHeight: 120.0,
                decorationRequired: true,
                subContainersRequired: true,
                columnMainAxisAlignment: MainAxisAlignment.start,
                containerBgColor: Colors.white,
                moveToSubSecBasedProfilesListScreen:
                    widget.moveToSubSecBasedProfilesListScreen,
                categoryIndex: 0,
                updateCategoryAndSubSectionIndex:
                    widget.updateCategoryAndSubSectionIndex,
              ),
              WantTypeContainer(
                title: 'Want Work',
                textWidth: 300,
                onlineNowCount: '1',
                matchesCount: '2',
                interestedShownCount: '3',
                interestedInMeCount: '4',
                blockedCount: '5',
                imageHeight: 80,
                imageWidth: 118,
                image: AssetImage("images/ic_want_work.png"),
                extraPaddingForTitle: 10,
                imagePosition: ImagePosition.right,
                textAlign: TextAlign.start,
                onPressed: () {
                  //showSearchingAnimation(1);
                  widget.moveToSwipeScreen(1);
                },
                leftPaddingForSubSections: 0,
                containerHeight: 120.0,
                decorationRequired: true,
                subContainersRequired: true,
                columnMainAxisAlignment: MainAxisAlignment.start,
                containerBgColor: Colors.white,
                moveToSubSecBasedProfilesListScreen:
                    widget.moveToSubSecBasedProfilesListScreen,
                categoryIndex: 1,
                updateCategoryAndSubSectionIndex:
                    widget.updateCategoryAndSubSectionIndex,
              ),
              WantTypeContainer(
                title: 'Want Love',
                textWidth: 296,
                onlineNowCount: '1',
                matchesCount: '2',
                interestedShownCount: '3',
                interestedInMeCount: '4',
                blockedCount: '5',
                imageHeight: 110,
                imageWidth: 73,
                image: AssetImage("images/ic_want_love.png"),
                extraPaddingForTitle: 28,
                imagePosition: ImagePosition.left,
                textAlign: TextAlign.start,
                onPressed: () {
                  //showSearchingAnimation(2);
                  widget.moveToSwipeScreen(2);
                },
                leftPaddingForSubSections: 20.0,
                containerHeight: 120.0,
                decorationRequired: true,
                subContainersRequired: true,
                columnMainAxisAlignment: MainAxisAlignment.start,
                containerBgColor: Colors.white,
                moveToSubSecBasedProfilesListScreen:
                    widget.moveToSubSecBasedProfilesListScreen,
                categoryIndex: 2,
                updateCategoryAndSubSectionIndex:
                    widget.updateCategoryAndSubSectionIndex,
              ),
              WantTypeContainer(
                title: 'Want Marriage',
                textWidth: 300,
                onlineNowCount: '1',
                matchesCount: '2',
                interestedShownCount: '3',
                interestedInMeCount: '4',
                blockedCount: '5',
                imageHeight: 101,
                imageWidth: 94,
                image: AssetImage("images/ic_want_marriage.png"),
                extraPaddingForTitle: 10,
                imagePosition: ImagePosition.right,
                textAlign: TextAlign.start,
                onPressed: () {
                  //showSearchingAnimation(3);
                  widget.moveToSwipeScreen(3);
                },
                leftPaddingForSubSections: 0,
                containerHeight: 120.0,
                decorationRequired: true,
                subContainersRequired: true,
                columnMainAxisAlignment: MainAxisAlignment.start,
                containerBgColor: Colors.white,
                moveToSubSecBasedProfilesListScreen:
                    widget.moveToSubSecBasedProfilesListScreen,
                categoryIndex: 3,
                updateCategoryAndSubSectionIndex:
                    widget.updateCategoryAndSubSectionIndex,
              ),
              WantTypeContainer(
                title: 'Want Friend',
                textWidth: 300,
                onlineNowCount: '1',
                matchesCount: '2',
                interestedShownCount: '3',
                interestedInMeCount: '4',
                blockedCount: '5',
                imageHeight: 86,
                imageWidth: 108,
                image: AssetImage("images/ic_want_friend.png"),
                extraPaddingForTitle: 28.0,
                imagePosition: ImagePosition.left,
                textAlign: TextAlign.start,
                onPressed: () {
                  //showSearchingAnimation(4);
                  widget.moveToSwipeScreen(4);
                },
                leftPaddingForSubSections: 20.0,
                containerHeight: 120.0,
                decorationRequired: true,
                subContainersRequired: true,
                columnMainAxisAlignment: MainAxisAlignment.start,
                containerBgColor: Colors.white,
                moveToSubSecBasedProfilesListScreen:
                    widget.moveToSubSecBasedProfilesListScreen,
                categoryIndex: 4,
                updateCategoryAndSubSectionIndex:
                    widget.updateCategoryAndSubSectionIndex,
              ),
            ],
          ),
        ),
      ),

      //
    );
  }
}
