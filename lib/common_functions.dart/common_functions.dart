import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:heavenz/screens/landingScreen.dart';
import 'package:heavenz/screens/signin_or_signup/signin.dart';
import 'package:heavenz/screens/signin_or_signup/signup.dart';
import 'package:heavenz/screens/user_profile/user_profile.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

Future getThingsDelayed(millisecons) async {
  await Future.delayed(Duration(milliseconds: millisecons));
}

void showInSnackBar(String value, BuildContext context) {
  Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(value)));
}

bool validateStructure(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = new RegExp(pattern);
  return regExp.hasMatch(value);
}

bool toBoolean(String value) {
  switch (value.toLowerCase()) {
    case "true":
      return true;
    case "t":
      return true;
    case "1":
      return true;
    case "0":
      return false;
    case "false":
      return false;
    case "f":
      return false;
  }
  return false;
}

bool isMobileNumberValid(String mobileNumber) {
  if (mobileNumber != null && mobileNumber != "" && mobileNumber.length != 10)
    return false;
  return true;
}

String getGenderAsString(gender) {
  if (gender == GENDER.MALE)
    return "Male";
  else if (gender == GENDER.FEMALE)
    return "Female";
  else
    return "Both";
}

GENDER getGenderAsEnum(String gender) {
  if (gender.toLowerCase() == "male")
    return GENDER.MALE;
  else if (gender.toLowerCase() == "female")
    return GENDER.FEMALE;
  else
    return GENDER.BOTH;
}

Future<File> generateThumbnailFile(String path) async {
  final thumbnail = await VideoThumbnail.thumbnailFile(
    video: path,
    //thumbnailPath: (await getTemporaryDirectory()).path,
    imageFormat: ImageFormat.PNG,
    maxHeight:
        100, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
    quality: 90,
  );
  File file = File(thumbnail!);
  return file;
}

Future<String> filePathFromImageUrl(String uri, String file_name) async {
  final response = await http.get(Uri.parse(uri));

  final documentDirectory = await getApplicationDocumentsDirectory();

  final file = File(join(documentDirectory.path, file_name));

  file.writeAsBytesSync(response.bodyBytes);

  print("file.path : " + file.path.toString());

  return file.path.toString();
}

void moveToSignUpScreen() {
  Get.to(SignupScreen(
    logoAsset: const AssetImage("images/ic_logo.png"),
    facebookLogo: "images/ic_facebook_logo.png",
    googleLogo: "images/ic_google_logo.png",
  ));
}

void moveToSignInScreen() {
  Get.to(SigninScreen(
    logoAsset: const AssetImage("images/ic_logo.png"),
    facebookLogo: "images/ic_facebook_logo.png",
    googleLogo: "images/ic_google_logo.png",
  ));
}

void screen_signedout() {
  Get.offAll(SigninScreen(
    logoAsset: const AssetImage("images/ic_logo.png"),
    facebookLogo: "images/ic_facebook_logo.png",
    googleLogo: "images/ic_google_logo.png",
  ));
}

void moveToHomeScreen() {
  //Get.to(const LandingScreeen());
  Get.offAll(const LandingScreen());
}
