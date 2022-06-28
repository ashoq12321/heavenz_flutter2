import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:heavenz/api/api_service.dart';
import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/models/user_images.dart';
import 'package:heavenz/models/view_person.dart';
import 'package:heavenz/screens/searching_swipe_list.dart';
import 'package:heavenz/widgets/app_button.dart';
import 'package:heavenz/widgets/card_swipe_container.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipeScreen extends StatefulWidget {
  SwipeScreen(
      {Key? key,
      required this.onBackPressed,
      required this.categoryIndex,
      required this.moveToViewProfileScreen,
      required this.swipePeople,
      required this.updateSwipeScreenFields,
      required this.findMoreSwipePeople,
      required this.swipeScreenOffset})
      : super(key: key);

  final onBackPressed;
  final moveToViewProfileScreen;
  final int categoryIndex;
  final updateSwipeScreenFields;
  List<ViewPerson> swipePeople;
  bool findMoreSwipePeople;
  int swipeScreenOffset;

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen>
    with TickerProviderStateMixin {
  late List<SwipeItem> _swipeItems = <SwipeItem>[];
  late List<ViewPerson> restSwipePeople;
  MatchEngine? _matchEngine;

  SlideRegion? region;

  //int currentIndex = 0;

  bool listNotEmpty = true;

  //int clickedContainerIndex = -1;
  late bool searchingAnimationEnabled = false;

  @override
  void initState() {
    initializeScreen();

    super.initState();

    /*_getThingsOnStartup().then((value) {
      setState(() {
        Timer(const Duration(milliseconds: 3000), () => showDemo());
      });
    });*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //showDemo();
    //Future.delayed(Duration.zero, () => showAlert(context));
    return WillPopScope(
      onWillPop: widget.onBackPressed,
      child: SafeArea(
          child: Stack(
        children: [
          if (searchingAnimationEnabled)
            Container(
              color: ColorConstants.appWhite,
              width: double.infinity,
              height: double.infinity,
              child:
                  SearchingSwipeListScreen(wantTypeIndex: widget.categoryIndex),
            )
          else
            Column(
              children: [
                space(h: 8.0),
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: FutureBuilder(
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            return SwipeCards(
                              matchEngine: _matchEngine!,
                              itemBuilder: (BuildContext context, int index) {
                                return CardSwipeContainer(
                                  dobAndAge:
                                      '${_swipeItems[index].content.dob} & ${_swipeItems[index].content.age} years',
                                  address:
                                      '${_swipeItems[index].content.address}',
                                  //reportText: 'Report',
                                  name: _swipeItems[index].content.name,
                                  sex: _swipeItems[index].content.sex,
                                  imageString:
                                      '${_swipeItems[index].content.imageString}',
                                  titleBackground: false,
                                  onlineNowBgColor: ColorConstants
                                      .appPurpleLight
                                      .withOpacity(0.65),
                                  //ColorConstants.appPurpleLight,
                                  onlineNowDotColor:
                                      ColorConstants.onlineIndicator,
                                  onlineTextDotColor:
                                      ColorConstants.onlineIndicator,
                                  //onlineTextDotColor: Colors.white,
                                );
                              },
                              onStackFinished: () {
                                print("region : $region");

                                setState(() {
                                  listNotEmpty = false;
                                  //widget.swipePeople = [];
                                  _swipeItems = [];

                                  print(
                                      "\n\n\nrestSwipePeopleeee : ${restSwipePeople.toString()}");
                                  //restSwipePeople.removeAt(0);

                                  widget.updateSwipeScreenFields(
                                      restSwipePeople,
                                      widget.swipeScreenOffset,
                                      widget.findMoreSwipePeople);
                                });

                                //print("\n\n widget.findMoreSwipePeople : ${widget.findMoreSwipePeople}");

                                //print("\n\n widget.swipeScreenOffset : ${widget.swipeScreenOffset}");

                                if (widget.findMoreSwipePeople) {
                                  initializeScreen();
                                  //showSearchingAnimationAndFetchProfilesList();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("List is over")));
                                }

                                //if (region != SlideRegion.inSuperLikeRegion) {
                                /*ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("List is over")));*/

                                // widget.onBackPressed();
                                //}
                              },
                              upSwipeAllowed: true,
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: region == SlideRegion.inLikeRegion
                            ? Alignment.centerRight
                            : region == SlideRegion.inNopeRegion
                                ? Alignment.centerLeft
                                : Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 34.0),
                          child: Text(
                            region == SlideRegion.inLikeRegion
                                ? "Interested"
                                : region == SlideRegion.inNopeRegion
                                    ? "Not Interested"
                                    : region == SlideRegion.inSuperLikeRegion
                                        ? "Profile quick view"
                                        : "",
                            style: FontType.normal.style(
                              size: 30,
                              color: region == SlideRegion.inLikeRegion
                                  ? ColorConstants.notificationGreen
                                  : region == SlideRegion.inNopeRegion
                                      ? ColorConstants.appRed
                                      : Colors.white,
                              appFontFamilyName: 'Poppins',
                              shadows: [
                                Shadow(
                                  blurRadius: 0.5,
                                  color: ColorConstants.appPurpleDark,
                                  offset: Offset(0.3, 0.3),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                space(h: 23.0),
                if (listNotEmpty)
                  Container(
                    width: 234.0,
                    child: AppButton(
                      bgColor: ColorConstants.appPurpleDark,
                      borderRadius: 24.0,
                      fontFamily: 'Poppins',
                      fontSize: 20.0,
                      onPressed: moveToProfileSceen,
                      title: 'About Profile',
                      textColor: Colors.white,
                      height: 47,
                      borderColor: ColorConstants.appGrey,
                    ),
                  ),
                space(h: 10),
              ],
            ),
        ],
      )),
    );
  }

  /*void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("hi"),
            ));
  }*/

  moveToProfileSceen() {
    widget.updateSwipeScreenFields(
        restSwipePeople, widget.swipeScreenOffset, widget.findMoreSwipePeople);
    EasyLoading.show(
        status: 'Please wait', maskType: EasyLoadingMaskType.black);
    APIService apiservice = APIService();

    // fetch images by user id
    apiservice
        .getImagesById(context, restSwipePeople[0].id!, true)
        .then((userImages) => {
              setImageFiles(userImages?.list),
            })
        .catchError((error, stackTrace) {
      EasyLoading.dismiss();
      //showInSnackBar("Something went wrong", context);
    });

    //print("fkfvkv");
  }

  setImageFiles(List<UserImageModel>? list) async {
    List<String> images = [];

    int count = 0;
    APIService apiService = APIService();

    for (UserImageModel item in list!) {
      images.insert(count++, item.image_url);
    }
    EasyLoading.dismiss();

    widget.moveToViewProfileScreen(restSwipePeople[0], images);
  }

  void likeUser(int id) {
    APIService apiservice = APIService();

    apiservice
        .likeUser(id, getCategory(widget.categoryIndex), context, true)
        .catchError((error, stackTrace) {
      debugPrint("error : $error");
      //showInSnackBar("Something went wrong", context);
    });
  }

  void dislikeUser(int id) {
    APIService apiservice = APIService();

    apiservice
        .dislikeUser(id, getCategory(widget.categoryIndex), context, true)
        .catchError((error, stackTrace) {
      debugPrint("error : $error");
      //showInSnackBar("Something went wrong", context);
    });
  }

  void setSwipeList() {
    restSwipePeople = [];
    restSwipePeople = widget.swipePeople;
    //widget.updateSwipePeople(restSwipePeople);

    print("AAAAAAAAAAAA : ${widget.swipePeople.toString()}");

    for (int i = 0; i < widget.swipePeople.length; i++) {
      _swipeItems.add(
        SwipeItem(
          content: widget.swipePeople[i],
          likeAction: () {
            likeUser(restSwipePeople[0].id!);
            restSwipePeople.removeAt(0);
            //widget.updateSwipePeople(restSwipePeople);
            print("liked");
            //currentIndex++;
          },
          nopeAction: () {
            dislikeUser(restSwipePeople[0].id!);
            restSwipePeople.removeAt(0);
            //widget.updateSwipePeople(restSwipePeople);
            print("disliked");
            //currentIndex++;
          },
          superlikeAction: moveToProfileSceen,
          onSlideUpdate: (SlideRegion? slideRegion) async {
            print(slideRegion);
            setState(() {
              region = slideRegion;
            });
          },
        ),
      );
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  showSearchingAnimationAndFetchProfilesList() {
    setState(() {
      searchingAnimationEnabled = true;
      //clickedContainerIndex = index;
    });

    String category = getCategory(widget.categoryIndex);

    APIService apiservice = APIService();

    apiservice
        .getMatches(context, category, widget.swipeScreenOffset, true)
        .then((profiles) => {
              if (profiles != null && profiles.list!.length > 0)
                {
                  setState(() {
                    searchingAnimationEnabled = false;
                    //clickedContainerIndex = -1;
                  }),
                  print("profiles.list : " + profiles.list.toString()),
                  print(
                      "profiles.find_more : " + profiles.find_more.toString()),
                  print("profiles.offset : " + profiles.offset.toString()),
                  widget.findMoreSwipePeople = profiles.find_more,
                  widget.swipeScreenOffset = profiles.offset,
                  widget.swipePeople = profiles.list!,
                  setSwipeList(),
                }
              else
                {
                  showInSnackBar("No matching profiles found", context),
                  Future.delayed(Duration(milliseconds: 1000), () {
                    moveToHomeScreen();
                    //throw Exception();
                  }),
                }
            })
        .catchError((error, stackTrace) {
      print("Something went wrong $error");
    });

    /*Future.delayed(Duration(milliseconds: 10000), () {
      
    });*/
    //;
  }

  void initializeScreen() {
    print("widget.swipePeople.length : ${widget.swipePeople.length}");
    if (widget.swipePeople.length == 0)
      showSearchingAnimationAndFetchProfilesList();
    else
      setSwipeList();
  }

  String getCategory(categoryIndex) {
    if (categoryIndex == 0)
      return "FAMILY";
    else if (categoryIndex == 1)
      return "WORK";
    else if (categoryIndex == 2)
      return "FLING";
    else if (categoryIndex == 3)
      return "MARRIAGE";
    else
      return "FRIEND";
  }
}


/*Future _getThingsOnStartup() async {
  await Future.delayed(const Duration(milliseconds: 2500));
}*/


/*Future.delayed(Duration.zero, () {
  void showDemo() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });

          return Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
          );
        });
  }
});*/
