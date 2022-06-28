import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:heavenz/api/api_service.dart';
import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:heavenz/constants/app_font.dart';

import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/models/signup_model.dart';
import 'package:heavenz/widgets/app_button.dart';
import 'package:heavenz/widgets/custom_dropdown/DropListModel.dart';
import 'package:heavenz/widgets/custom_dropdown/custom_drop_list.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    Key? key,
    required this.logoAsset,
    required this.facebookLogo,
    required this.googleLogo,
  }) : super(key: key);

  final AssetImage logoAsset;
  final String facebookLogo;
  final String googleLogo;

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final confirmPwdController = TextEditingController();
  final dobController = TextEditingController();
  //final genderController = TextEditingController();
  FocusScopeNode? node;

  DateTime? dob = null;

  DropListModel genderDropListModel = DropListModel([
    OptionItem(id: "1", title: "Male"),
    OptionItem(id: "2", title: "Female"),
  ]);
  OptionItem genderOptionItemSelected = OptionItem(id: "-1", title: "Gender");

  late APIService apiservice;

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    apiservice = new APIService();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    pwdController.dispose();
    confirmPwdController.dispose();
    dobController.dispose();
    //genderController.dispose();
    super.dispose();
  }

  pickDateOfBirth(BuildContext context) async {
    if (dob == null) {
      dob = DateTime(
          DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
    }

    if (dob != null) {
      final DateTime? pickedDateOfBirth = await showDatePicker(
        context: context,
        initialDate: dob!,
        firstDate: DateTime(1900, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(
            DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
      );
      if (pickedDateOfBirth == null)
        dobController.text = DateFormat('MMM dd, yyyy').format(dob!);
      else
        dobController.text =
            DateFormat('MMM dd, yyyy').format(pickedDateOfBirth);

      if (pickedDateOfBirth != null) dob = pickedDateOfBirth;
    }
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    Size size = MediaQuery.of(context).size;
    //node?.unfocus();
    return GestureDetector(
      onTap: () => node?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Builder(
          builder: (context) => SafeArea(
            child: SingleChildScrollView(
              child: Stack(children: [
                Container(
                  //height: size.height,
                  color: ColorConstants.appGrey1,
                ),
                Positioned(
                  left: -50,
                  right: -50,
                  child: Container(
                    height: size.height * 0.69,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFFF7FAFA),
                          Color(0xFF0A544F),
                        ],
                      ),
                      border: Border.all(color: ColorConstants.appGrey),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(302.0),
                        bottomLeft: Radius.circular(302.0),
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      space(h: 41.0),
                      _icon(),
                      space(h: 17.0),
                      Container(
                        //height: 427,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          border: Border.all(color: Colors.white),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 12.0)
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 44.0),
                                  child: prepareForm(context),
                                ),
                              ],
                            ),
                            Positioned(
                              bottom: 50,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6.0, vertical: 2.0),
                                        child: Text(
                                          "Don't have an account ?",
                                          textAlign: TextAlign.center,
                                          style: FontType.medium.style(
                                            size: 25,
                                            color: Colors.black,
                                            appFontFamilyName: 'Segoe UI',
                                            shadows: [
                                              const Shadow(
                                                blurRadius: 0.7,
                                                color: Colors.black,
                                                offset: Offset(0.4, 0.4),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6.0, vertical: 4.0),
                                        child: GestureDetector(
                                          onTap: moveToSignInScreen,
                                          child: Text(
                                            "SIGN IN",
                                            textAlign: TextAlign.center,
                                            style: FontType.medium.style(
                                              size: 25,
                                              color:
                                                  ColorConstants.appPurpleLight,
                                              appFontFamilyName: 'Segoe UI',
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 1.7,
                                                  color: ColorConstants
                                                      .appPurpleLight,
                                                  offset:
                                                      const Offset(0.8, 0.8),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _icon() {
    return Center(
      child: Image(
        image: widget.logoAsset,
        width: 148,
        height: 119,
      ),
    );
  }

  Widget prepareForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        space(h: 19),
        Text(
          "Register",
          textAlign: TextAlign.center,
          style: FontType.bold.style(
            size: 25,
            color: Colors.black,
            appFontFamilyName: 'Lato',
            shadows: [
              const Shadow(
                blurRadius: 2.0,
                color: Colors.black,
                offset: Offset(0.5, 0.5),
              ),
            ],
          ),
        ),
        space(h: 20.0),
        // first name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            controller: firstNameController,
            //autofocus: true,
            onEditingComplete: () => node?.nextFocus(),
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'First Name',
              hintStyle: FontType.normal.style(
                  size: 22.0,
                  color: ColorConstants.appGrey,
                  appFontFamilyName: 'Lato'),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        space(h: 10.0),
        // lastname
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.text,
            controller: lastNameController,
            //autofocus: true,
            onEditingComplete: () => node?.nextFocus(),
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Last Name',
              hintStyle: FontType.normal.style(
                  size: 22.0,
                  color: ColorConstants.appGrey,
                  appFontFamilyName: 'Lato'),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        space(h: 10.0),
        // Email
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,

            //autofocus: true,
            onEditingComplete: () => node?.nextFocus(),
            decoration: InputDecoration(
              //border: InputBorder.none,
              hintText: 'Email Id',
              hintStyle: FontType.normal.style(
                  size: 22.0,
                  color: ColorConstants.appGrey,
                  appFontFamilyName: 'Lato'),
            ),
            textInputAction: TextInputAction.next,
          ),
        ),
        space(h: 10.0),
        // Password field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: pwdController,
            obscureText: true,
            onEditingComplete: () => node?.nextFocus(),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              //border: InputBorder.none,

              hintText: 'Password',
              hintStyle: FontType.normal.style(
                  size: 22.0,
                  color: ColorConstants.appGrey,
                  appFontFamilyName: 'Lato'),
            ),
          ),
        ),
        space(h: 10.0),
        // Confirm Password field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            controller: confirmPwdController,
            obscureText: true,
            onEditingComplete: () => node?.unfocus(),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              //border: InputBorder.none,

              hintText: 'Confirm Password',
              hintStyle: FontType.normal.style(
                  size: 22.0,
                  color: ColorConstants.appGrey,
                  appFontFamilyName: 'Lato'),
            ),
          ),
        ),
        space(h: 10.0),
        // dob field
        GestureDetector(
          onTap: () {
            node?.unfocus();
            pickDateOfBirth(context);
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: dobController,
                  enabled: false,
                  keyboardType: TextInputType.datetime,
                  onEditingComplete: () => node?.unfocus(),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    //border: InputBorder.none,

                    hintText: 'DOB',
                    hintStyle: FontType.normal.style(
                        size: 22.0,
                        color: ColorConstants.appGrey,
                        appFontFamilyName: 'Lato'),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 36),
                child: Container(
                  height: 20,
                  width: 20,
                  alignment: Alignment.center, // This is needed
                  child: Image.asset(
                    "images/ic_calender_green.png",
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          ),
        ),
        space(h: 10.0),
        // gender field
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                //controller: genderController,
                keyboardType: TextInputType.text,
                enabled: false,
                onEditingComplete: () => node?.unfocus(),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  //border: InputBorder.none,

                  hintText: '',
                  hintStyle: FontType.normal.style(
                      size: 22.0,
                      color: ColorConstants.appGrey,
                      appFontFamilyName: 'Lato'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 16.0),
              child: CustomDropList(
                dropListModel: genderDropListModel,
                itemSelected: genderOptionItemSelected,
                decorationRequired: false,
                onOptionSelected: (OptionItem optionItem) {
                  genderOptionItemSelected = optionItem;
                  setState(() {});
                },
              ),
            ),

            /*Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: ColorConstants.appGreenDark,
                    size: 50.0,
                  ),
                ),
              )*/
          ],
        ),

        space(h: 42),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: AppButton(
            bgColor: ColorConstants.appPurpleLight,
            borderRadius: 27.0,
            fontFamily: 'Segoe UI',
            fontSize: 25.0,
            onPressed: () {
              EasyLoading.show(
                  status: 'Please wait', maskType: EasyLoadingMaskType.black);
              node?.unfocus();
              if (validateSignupForm(context)) {
                signup(context);
              } else {
                EasyLoading.dismiss();
              }
            },
            title: 'SIGN UP',
            textColor: Colors.white,
            height: 54,
          ),
        ),
        space(h: 18.0),
        Text(
          "I agree Terms& Conditions",
          textAlign: TextAlign.center,
          style: FontType.medium.style(
            size: 16,
            color: Colors.black,
            appFontFamilyName: 'Segoe UI',
            shadows: [
              const Shadow(
                blurRadius: 0.5,
                color: Colors.black,
                offset: Offset(0.2, 0.2),
              ),
            ],
          ),
        ),
        space(h: 25),
        Stack(
          alignment: Alignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Color(0xFFDCDCDC),
                thickness: 2,
              ),
            ),
            Container(
              height: 17,
              width: 29,
              decoration: const BoxDecoration(
                color: Color(0xFFDCDCDC),
                borderRadius: BorderRadius.all(
                  Radius.circular(9.0),
                ),
              ),
              child: Text(
                "OR",
                textAlign: TextAlign.center,
                style: FontType.medium.style(
                  size: 12,
                  color: Colors.black.withOpacity(0.46),
                  appFontFamilyName: 'Segoe UI',
                  shadows: [
                    Shadow(
                      blurRadius: 0.8,
                      color: ColorConstants.appPurpleLight,
                      offset: const Offset(0.5, 0.5),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        space(h: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(widget.facebookLogo, scale: 1),
            ),
            space(w: 31),
            Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(widget.googleLogo, scale: 1),
            ),
          ],
        ),
        space(h: 100),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Divider(
            color: Colors.black,
            thickness: 5,
          ),
        ),
      ],
    );
  }

  bool validateSignupForm(BuildContext context) {
    if (firstNameController.text == "") {
      showInSnackBar("First Name should not be empty", context);
      return false;
    } else if (firstNameController.text.length > 20) {
      showInSnackBar("First Name is too long", context);
      return false;
    } else if (lastNameController.text == "") {
      showInSnackBar("Last Name should not be empty", context);
      return false;
    } else if (lastNameController.text.length > 20) {
      showInSnackBar("Last Name is too long", context);
      return false;
    } else if (emailController.text == "") {
      showInSnackBar("Email should not be empty", context);
      return false;
    } else if (emailController.text.length > 40 ||
        !emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      showInSnackBar("Email should be vaild", context);
      return false;
    } else if (pwdController.text == "") {
      showInSnackBar("Please enter password", context);
      return false;
    } else if (pwdController.text.length < 8) {
      showInSnackBar("Password should be atleast 8 characters", context);
      return false;
    } else if (pwdController.text.length > 40) {
      showInSnackBar("Password should not exceed 40 characters", context);
      return false;
    } else if (pwdController.text.contains(' ')) {
      showInSnackBar("Password should not contain space", context);
      return false;
    } else if (confirmPwdController.text == "") {
      showInSnackBar("Please confirm password", context);
      return false;
    } else if (confirmPwdController.text.length < 8) {
      showInSnackBar(
          "Confirm password should be atleast 8 characters", context);
      return false;
    } else if (confirmPwdController.text.length > 40) {
      showInSnackBar(
          "Confirm password should not exceed 40 characters", context);
      return false;
    } else if (confirmPwdController.text.contains(' ')) {
      showInSnackBar("Confirm password should not contain space", context);
      return false;
    } else if (pwdController.text != confirmPwdController.text) {
      showInSnackBar("Passwords should not be diffrent", context);
      return false;
    } else if (dob == null) {
      showInSnackBar("Pick your date of birth", context);
      return false;
    } else if (genderOptionItemSelected.title == "Gender") {
      showInSnackBar("Pick your Gender", context);
      return false;
    }
    return true;
  }

  void signup(BuildContext context) {
    print("\n\nsignup func called");
    SignupModel signupModel = SignupModel(
        first_name: firstNameController.text,
        last_name: lastNameController.text,
        email: emailController.text,
        password: pwdController.text,
        dob: dob.toString(),
        gender: genderOptionItemSelected.title,
        email_visibility: false.toString(),
        mobile_visibility: false.toString());

    apiservice
        .signup(signupModel, context)
        .then((value) => {
              print("value $value"),
              if (value != null && value)
                {
                  EasyLoading.dismiss(),
                  moveToSignInScreen(),
                }
              else
                {
                  print("aaaaaaaaa"),
                  EasyLoading.dismiss(),
                  throw Exception(),
                }
            })
        .catchError((error, stackTrace) {
      print("error $error");
      EasyLoading.dismiss();
      //showInSnackBar("Something went wrong", context);
    });
  }
}
