import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:heavenz/api/api_service.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/models/user_settings.dart';
import 'package:heavenz/screens/user_profile/user_profile.dart';
import 'package:heavenz/widgets/app_button.dart';
import 'package:heavenz/widgets/custom_toggle_switch.dart';
import 'package:heavenz/widgets/custom_vertical_slider.dart';

class UserProfileSettings extends StatefulWidget {
  UserProfileSettings(
      {Key? key,
      required this.onBackPressed,
      required this.moveToInitialUserProfileScreen,
      required this.userSettingsList,
      required this.updateList})
      : super(key: key);

  final onBackPressed;
  final moveToInitialUserProfileScreen;
  List<UserSettingModel> userSettingsList;
  final updateList;

  @override
  _UserProfileSettingsState createState() => _UserProfileSettingsState();
}

class _UserProfileSettingsState extends State<UserProfileSettings> {
  int currentIndex = 0;
  late PageController pageController;

  setGender(GENDER gender) {
    widget.userSettingsList[currentIndex].gender = gender;
    widget.updateList(widget.userSettingsList);
  }

  setShowProfile(bool value) {
    setState(() {
      widget.userSettingsList[currentIndex].showProfile = value;
      widget.updateList(widget.userSettingsList);
    });
  }

  setOnlineVisibility(bool value) {
    setState(() {
      widget.userSettingsList[currentIndex].onlineVisibility = value;
      widget.updateList(widget.userSettingsList);
    });
  }

  setLastSeen(bool value) {
    setState(() {
      widget.userSettingsList[currentIndex].lastSeen = value;
      widget.updateList(widget.userSettingsList);
    });
  }

  setCurrentAgeRange(RangeValues rangeValues) {
    setState(() {
      if (rangeValues.start < 18) {
        widget.userSettingsList[currentIndex].ageStart = "18";
      } else {
        widget.userSettingsList[currentIndex].ageStart =
            rangeValues.start.toString();
      }

      widget.userSettingsList[currentIndex].ageEnd = rangeValues.end.toString();
      widget.updateList(widget.userSettingsList);
    });
  }

  setCurrentDistance(double distance) {
    setState(() {
      widget.userSettingsList[currentIndex].distance = distance.toString();
      widget.updateList(widget.userSettingsList);
    });
  }

  moveLeft() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        pageController.animateToPage(
          currentIndex,
          curve: Curves.ease,
          duration: Duration(milliseconds: 500),
        );
      });
    }
  }

  moveRight() {
    if (currentIndex < widget.userSettingsList.length - 1) {
      setState(() {
        currentIndex++;
        pageController.animateToPage(
          currentIndex,
          curve: Curves.ease,
          duration: Duration(milliseconds: 500),
        );
      });
    }
  }

  onPageChanged(int index) {
    print("index : $index");
    if (index > currentIndex) {
      if (currentIndex < widget.userSettingsList.length - 1) {
        setState(() {
          currentIndex++;
        });
      }
    } else if (index < currentIndex) {
      if (currentIndex > 0) {
        setState(() {
          currentIndex--;
        });
      }
    }
  }

  @override
  void initState() {
    pageController = PageController();
    fetchUserSettings();
    //gender = widget.userSettingsList[currentIndex].gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.onBackPressed,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Stack(
            //alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 301,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorConstants.appGreen,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: moveLeft,
                          child: Container(
                            color: Colors.transparent,
                            height: double.infinity,
                            width: 50,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                            child: Image.asset(
                              'images/ic_arrow_left_white.png',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            widget.userSettingsList[currentIndex].categoryName,
                            textAlign: TextAlign.center,
                            style: FontType.normal.style(
                              size: 20,
                              color: Colors.white,
                              appFontFamilyName: 'Poppins',
                              shadows: [
                                const Shadow(
                                  blurRadius: 0.2,
                                  color: Colors.white,
                                  offset: Offset(0.1, 0.1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: moveRight,
                          child: Container(
                            color: Colors.transparent,
                            height: double.infinity,
                            width: 50,
                            padding: const EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 20.0),
                            child: Image.asset(
                              'images/ic_arrow_right_white.png',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 58.0, bottom: 60.0),
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: onPageChanged,
                  itemBuilder: (context, index) {
                    return _buildBody();
                  },
                  itemCount: widget.userSettingsList.length,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  //padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  constraints: BoxConstraints(maxWidth: 301.0),
                  child: AppButton(
                    bgColor: ColorConstants.appGreen,
                    borderRadius: 8.0,
                    fontFamily: 'Poppins',
                    fontSize: 20.0,
                    onPressed: () => updateUserSettings(context),
                    title: 'Save Changes',
                    textColor: Colors.white,
                    height: 52,
                    //borderColor: ColorConstants.appGrey,
                  ),
                ),
              ),
            ],
          ),
        ),
        //
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
        color: ColorConstants.appWhite,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          children: [
            space(h: 10.0),
            Text(
              "Gender",
              textAlign: TextAlign.center,
              style: FontType.normal.style(
                size: 20,
                color: ColorConstants.appPurpleDark,
                appFontFamilyName: 'Poppins',
                shadows: [
                  Shadow(
                    blurRadius: 0.1,
                    color: ColorConstants.appPurpleDark,
                    offset: Offset(0.1, 0.1),
                  ),
                ],
              ),
            ),
            space(h: 18.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () => setGender(GENDER.MALE),
                      child: Container(
                        width: 91.0,
                        height: 34.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              (widget.userSettingsList[currentIndex].gender ==
                                      GENDER.MALE)
                                  ? ColorConstants.appViolet
                                  : Colors.black.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(17.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.6,
                              color: (widget.userSettingsList[currentIndex]
                                          .gender ==
                                      GENDER.MALE)
                                  ? ColorConstants.appViolet.withOpacity(0.03)
                                  : Colors.black.withOpacity(0.03),
                              offset: Offset(0.0, 0.3),
                            )
                          ],
                        ),
                        child: Text(
                          "Male",
                          textAlign: TextAlign.center,
                          style: FontType.normal.style(
                            size: 15,
                            color:
                                (widget.userSettingsList[currentIndex].gender ==
                                        GENDER.MALE)
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.5),
                            appFontFamilyName: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () => setGender(GENDER.FEMALE),
                      child: Container(
                        width: 91.0,
                        height: 34.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              (widget.userSettingsList[currentIndex].gender ==
                                      GENDER.FEMALE)
                                  ? ColorConstants.appViolet
                                  : Colors.black.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(17.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.6,
                              color: (widget.userSettingsList[currentIndex]
                                          .gender ==
                                      GENDER.FEMALE)
                                  ? ColorConstants.appViolet.withOpacity(0.03)
                                  : Colors.black.withOpacity(0.03),
                              offset: Offset(0.0, 0.3),
                            )
                          ],
                        ),
                        child: Text(
                          "Female",
                          textAlign: TextAlign.center,
                          style: FontType.normal.style(
                            size: 15,
                            color:
                                (widget.userSettingsList[currentIndex].gender ==
                                        GENDER.FEMALE)
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.5),
                            appFontFamilyName: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                      onTap: () => setGender(GENDER.BOTH),
                      child: Container(
                        width: 91.0,
                        height: 34.0,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              (widget.userSettingsList[currentIndex].gender ==
                                      GENDER.BOTH)
                                  ? ColorConstants.appViolet
                                  : Colors.black.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(17.0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.6,
                              color: (widget.userSettingsList[currentIndex]
                                          .gender ==
                                      GENDER.BOTH)
                                  ? ColorConstants.appViolet.withOpacity(0.03)
                                  : Colors.black.withOpacity(0.03),
                              offset: Offset(0.0, 0.3),
                            )
                          ],
                        ),
                        child: Text(
                          "Both",
                          textAlign: TextAlign.center,
                          style: FontType.normal.style(
                            size: 15,
                            color:
                                (widget.userSettingsList[currentIndex].gender ==
                                        GENDER.BOTH)
                                    ? Colors.white
                                    : Colors.black.withOpacity(0.5),
                            appFontFamilyName: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            space(h: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0, right: 40.0),
                      child: VerticalSlider(
                        rangeSlider: true,
                        maxValue: 100,
                        onChanged: setCurrentAgeRange,
                        currentRangeValues: RangeValues(
                            double.parse(
                                widget.userSettingsList[currentIndex].ageStart),
                            double.parse(
                                widget.userSettingsList[currentIndex].ageEnd)),
                        currentValue: 0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20.0,
                      ),
                      child: Text(
                        "Age",
                        textAlign: TextAlign.center,
                        style: FontType.normal.style(
                          size: 20,
                          color: ColorConstants.appPurpleDark,
                          appFontFamilyName: 'Poppins',
                          shadows: [
                            Shadow(
                              blurRadius: 0.1,
                              color: ColorConstants.appPurpleDark,
                              offset: Offset(0.1, 0.1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 60.0),
                      child: VerticalSlider(
                        rangeSlider: false,
                        maxValue: 500,
                        onChanged: setCurrentDistance,
                        currentValue: double.parse(
                            widget.userSettingsList[currentIndex].distance),
                        currentRangeValues: RangeValues(0, 0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        "Distance",
                        textAlign: TextAlign.center,
                        style: FontType.normal.style(
                          size: 20,
                          color: ColorConstants.appPurpleDark,
                          appFontFamilyName: 'Poppins',
                          shadows: [
                            Shadow(
                              blurRadius: 0.1,
                              color: ColorConstants.appPurpleDark,
                              offset: Offset(0.1, 0.1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            space(h: 30.0),
            Container(
              height: 173.0,
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.9,
                    color: Colors.black.withOpacity(0.4),
                    offset: Offset(0.0, 0.6),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomToggleSwitch(
                          bgColor: ColorConstants.appViolet,
                          scaleSize: 1.15,
                          switchValue:
                              widget.userSettingsList[currentIndex].showProfile,
                          onChanged: setShowProfile,
                        ),
                        space(h: 10.0),
                        Container(
                          height: 60.0,
                          alignment: Alignment.center,
                          child: Text(
                            "Show profile",
                            textAlign: TextAlign.center,
                            style: FontType.normal.style(
                              size: 20,
                              color: ColorConstants.appPurpleDark,
                              appFontFamilyName: 'Poppins',
                              shadows: [
                                Shadow(
                                  blurRadius: 0.1,
                                  color: ColorConstants.appPurpleDark,
                                  offset: Offset(0.1, 0.1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  space(w: 8.0),
                  SizedBox(
                    width: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomToggleSwitch(
                          bgColor: ColorConstants.appViolet,
                          scaleSize: 1.15,
                          switchValue: widget
                              .userSettingsList[currentIndex].onlineVisibility,
                          onChanged: setOnlineVisibility,
                        ),
                        space(h: 10.0),
                        Container(
                          height: 60.0,
                          alignment: Alignment.center,
                          child: Text(
                            "Online Visibility",
                            textAlign: TextAlign.center,
                            style: FontType.normal.style(
                              size: 20,
                              color: ColorConstants.appPurpleDark,
                              appFontFamilyName: 'Poppins',
                              shadows: [
                                Shadow(
                                  blurRadius: 0.1,
                                  color: ColorConstants.appPurpleDark,
                                  offset: Offset(0.1, 0.1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  space(w: 8.0),
                  SizedBox(
                    width: 100.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomToggleSwitch(
                          bgColor: ColorConstants.appViolet,
                          scaleSize: 1.15,
                          switchValue:
                              widget.userSettingsList[currentIndex].lastSeen,
                          onChanged: setLastSeen,
                        ),
                        space(h: 10.0),
                        Container(
                          height: 60.0,
                          alignment: Alignment.center,
                          child: Text(
                            "Last Seen",
                            textAlign: TextAlign.center,
                            style: FontType.normal.style(
                              size: 20,
                              color: ColorConstants.appPurpleDark,
                              appFontFamilyName: 'Poppins',
                              shadows: [
                                Shadow(
                                  blurRadius: 0.1,
                                  color: ColorConstants.appPurpleDark,
                                  offset: Offset(0.1, 0.1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            space(h: 40.0),
          ],
        ),
      ),
    );
  }

  void fetchUserSettings() {
    EasyLoading.show(
        status: 'Please wait', maskType: EasyLoadingMaskType.black);
    APIService apiservice = APIService();

    apiservice
        .getUserSettings(context, true)
        .then((userSettings) => {
              if (userSettings != null && userSettings.list?.length == 5)
                {
                  print("list : ${userSettings.list.toString()}"),
                  setState(() {
                    widget.userSettingsList = userSettings.list!;
                  }),
                  EasyLoading.dismiss(),
                }
              else
                {
                  EasyLoading.dismiss(),
                  throw Exception(),
                }
            })
        .catchError((error, stackTrace) {
      EasyLoading.dismiss();
      //showInSnackBar("Something went wrong", context);
    });
  }

  void updateUserSettings(BuildContext context) {
    EasyLoading.show(
        status: 'Please wait', maskType: EasyLoadingMaskType.black);

    APIService apiservice = APIService();

    apiservice
        .updateUserSettings(
            UserSettings(
                list: widget.userSettingsList) /*widget.userSettingsList*/,
            context,
            true)
        .then((value) => {
              if (value != null && value)
                {
                  EasyLoading.dismiss(),
                  widget.moveToInitialUserProfileScreen(),
                }
              else
                {
                  EasyLoading.dismiss(),
                  throw Exception(),
                }
            })
        .catchError((error, stackTrace) {
      print("error : $error");
      print("stackTrace : $stackTrace");
      EasyLoading.dismiss();
      //showInSnackBar("Something went wrong", context);
    });
  }
}
