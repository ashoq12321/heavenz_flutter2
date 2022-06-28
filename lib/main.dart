import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:heavenz/constants/color_constants.dart';

import 'package:heavenz/screens/home/view_profile.dart';
import 'package:heavenz/screens/landingScreen.dart';
import 'package:heavenz/screens/searching_swipe_list.dart';
import 'package:heavenz/screens/signin_or_signup/signin.dart';
import 'package:heavenz/screens/signin_or_signup/signup.dart';
import 'package:heavenz/screens/splash_screen.dart';
import 'package:heavenz/screens/user_profile/user_profile.dart';
import 'package:heavenz/widgets/custom_animations/custom_searching_animation.dart';
import 'package:heavenz/widgets/sub_sec_based_profile_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: //LandingScreeen(),
          //SplashScreen(logoAssetString: "images/ic_logo.png"),
          /*SignupScreen(
        logoAsset: const AssetImage("images/ic_logo.png"),
        facebookLogo: "images/ic_facebook_logo.png",
        googleLogo: "images/ic_google_logo.png",
      ),*/
          /*SigninScreen(
        logoAsset: const AssetImage("images/ic_logo.png"),
        facebookLogo: "images/ic_facebook_logo.png",
        googleLogo: "images/ic_google_logo.png",
      ),*/
          LandingScreen(),
      builder: EasyLoading.init(),
      //UserProfile(),
      //SearchingSwipeListScreen(wantTypeIndex: 0),
      //SearchingAnimation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
