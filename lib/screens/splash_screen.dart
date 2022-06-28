import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/screens/landingScreen.dart';
import 'package:heavenz/screens/initial_screen.dart';
import 'package:heavenz/screens/signin_or_signup/signin.dart';
import 'package:heavenz/screens/signin_or_signup/signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.logoAssetString})
      : super(key: key);

  //final AssetImage logoAsset;
  final String logoAssetString;

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Color logoBgColor = Colors.transparent;
  double imageScale = 1;

  @override
  void initState() {
    super.initState();

    _getThingsOnStartup().then((value) {
      //checkToken();
      setState(() {
        logoBgColor = Colors.white.withOpacity(0.87);
        imageScale = 1.3;
      });
      Timer(
          const Duration(milliseconds: 800),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => InitialScreen(
                        welcomeText: 'Welcome to the end of loneliness',
                        subText:
                            'The first relationship app offering to you 5 choices from marriage to roommates.',
                        buttonText: 'Get Started matching',
                        logoAssetString: 'images/ic_logo.png',
                        onTapped: moveToSignInScreen,
                      ))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appPurple,
      body: Center(
        child: AnimatedContainer(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: logoBgColor,
            borderRadius: const BorderRadius.all(Radius.circular(100.0)),
          ),
          duration: const Duration(milliseconds: 800),
          child: Image.asset(widget.logoAssetString, scale: imageScale),
          curve: Curves.slowMiddle,
        ),
      ),
    );
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(const Duration(milliseconds: 2500));
  }

  /*checkToken() async {
    var token_str = (await secureStorage.readSecureData("token"));

    print(token_str);

    if (token_str != null) {
      print("token2 " + token_str);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
    }
  }*/
}
