import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:heavenz/api/api_service.dart';
import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/screens/utils/secure_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SideNavBar extends StatelessWidget {
  SideNavBar({
    Key? key,
    required this.name,
    required this.imageString,
    required this.percentage,
    required this.moveToProfileScreen,
  }) : super(key: key);

  final String name;
  final String imageString;
  final int percentage;
  final moveToProfileScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Drawer(
        child: Container(
          color: Color(0xFF5BB3B3),
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: 212.0,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Color(0xFFa4d6d5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: [
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 20.0),
                                child: CircularPercentIndicator(
                                  startAngle: 180,
                                  radius: 70.0,
                                  lineWidth: 4.0,
                                  percent: percentage / 100,
                                  center: CircleAvatar(
                                    radius: 55.0,
                                    backgroundColor: Colors.white,
                                    // Image radius
                                    backgroundImage: NetworkImage(imageString),
                                  ),
                                  progressColor: Color(0xFFBD0000),
                                ),
                              ),
                              Container(
                                height: 24.0,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: Color(0xFFa4d6d5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "${percentage}%",
                                  textAlign: TextAlign.center,
                                  style: FontType.medium.style(
                                    size: 16.0,
                                    color: Color(0xFFBD0000),
                                    appFontFamilyName: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Welcome",
                                      textAlign: TextAlign.center,
                                      style: FontType.medium.style(
                                        size: 24.0,
                                        color: Colors.black,
                                        appFontFamilyName: 'Poppins',
                                      ),
                                    ),
                                    Text(
                                      name,
                                      overflow: TextOverflow.fade,
                                      maxLines: 1,
                                      softWrap: false,
                                      textAlign: TextAlign.center,
                                      style: FontType.medium.style(
                                        size: 24.0,
                                        color: Colors.black.withOpacity(0.48),
                                        appFontFamilyName: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        moveToProfileScreen(3);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Color(0xFFBD0000),
                              size: 18.0,
                            ),
                            space(w: 6.0),
                            Text(
                              "Edit Profile",
                              textAlign: TextAlign.center,
                              style: FontType.medium.style(
                                size: 16.0,
                                color: Color(0xFFBD0000),
                                appFontFamilyName: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Upgrade to Premium",
                    textAlign: TextAlign.start,
                    style: FontType.normal.style(
                      size: 20.0,
                      color: Colors.white,
                      appFontFamilyName: 'Poppins',
                    ),
                  ),
                ),
              ),
              getDivider(),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Help & Support",
                    textAlign: TextAlign.start,
                    style: FontType.normal.style(
                      size: 20.0,
                      color: Colors.white,
                      appFontFamilyName: 'Poppins',
                    ),
                  ),
                ),
              ),
              getDivider(),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Privacy Policy",
                    textAlign: TextAlign.start,
                    style: FontType.normal.style(
                      size: 20.0,
                      color: Colors.white,
                      appFontFamilyName: 'Poppins',
                    ),
                  ),
                ),
              ),
              getDivider(),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Legal",
                    textAlign: TextAlign.start,
                    style: FontType.normal.style(
                      size: 20.0,
                      color: Colors.white,
                      appFontFamilyName: 'Poppins',
                    ),
                  ),
                ),
              ),
              getDivider(),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Delete my profile",
                    textAlign: TextAlign.start,
                    style: FontType.normal.style(
                      size: 20.0,
                      color: Colors.white,
                      appFontFamilyName: 'Poppins',
                    ),
                  ),
                ),
              ),
              getDivider(),
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    "Log Out",
                    textAlign: TextAlign.start,
                    style: FontType.normal.style(
                      size: 20.0,
                      color: Colors.white,
                      appFontFamilyName: 'Poppins',
                    ),
                  ),
                ),
                onTap: () => signoutAlert(context),
              ),
              getDivider(),
            ],
          ),
        ),
      ),
    );
  }

  getDivider() {
    return Divider(
      thickness: 2.0,
      color: Colors.white.withOpacity(0.1),
    );
  }

  Future<void> signout(BuildContext context) async {
    EasyLoading.show(
        status: 'Please wait', maskType: EasyLoadingMaskType.black);

    //if (token_str != null) {
    APIService apiservice = APIService();
    final SecureStorage secureStorage = SecureStorage();

    apiservice
        .signout(context, true)
        .then((value) => {
              print("value : " + value.toString()),
              if (value != null && value)
                {
                  secureStorage.deleteSecureData("accessToken"),
                  secureStorage.deleteSecureData("refreshToken"),
                  EasyLoading.dismiss(),
                  screen_signedout(),
                }
              else
                {
                  secureStorage.deleteSecureData("accessToken"),
                  secureStorage.deleteSecureData("refreshToken"),
                  EasyLoading.dismiss(),
                  screen_signedout(),
                  throw Exception(),
                }
            })
        .catchError((error, stackTrace) {
      secureStorage.deleteSecureData("accessToken");
      secureStorage.deleteSecureData("refreshToken");
      EasyLoading.dismiss();
      screen_signedout();
      print("dddddddd : $error");
      //showInSnackBar("Something went wrong", context);
    });
    /*} else {
      EasyLoading.dismiss();
      showInSnackBar("Something went wrong", context);
    }*/
  }

  signoutAlert(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = TextButton(
        child: Text("Yes"),
        onPressed: () {
          Navigator.pop(context, false);
          Navigator.pop(context, false);
          signout(context);
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sign out"),
      content: Text("Are you sure want to sign out?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
