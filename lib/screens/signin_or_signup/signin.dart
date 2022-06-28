import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:heavenz/api/api_service.dart';
import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:heavenz/constants/app_font.dart';

import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/models/signin_model.dart';
import 'package:heavenz/screens/utils/secure_storage.dart';
import 'package:heavenz/widgets/app_button.dart';
import 'package:heavenz/widgets/match.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({
    Key? key,
    required this.logoAsset,
    required this.facebookLogo,
    required this.googleLogo,
  }) : super(key: key);

  final AssetImage logoAsset;
  final String facebookLogo;
  final String googleLogo;

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  FocusScopeNode? node;

  late APIService apiservice;

  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    FocusManager.instance.primaryFocus?.unfocus();
    apiservice = new APIService();
    checkToken();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => node?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorConstants.appGrey1,
        body: Builder(
          builder: (context) => SafeArea(
            child: SingleChildScrollView(
              child: Stack(children: [
                Positioned(
                  left: -50,
                  right: -50,
                  child: Container(
                    height: size.height * 0.69,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFF7FAFA), Color(0xFF0A544F)]),
                      border: Border.all(color: ColorConstants.appGrey),
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(302.0),
                          bottomLeft: Radius.circular(302.0)),
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 44),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        space(h: 41.0),
                        _icon(),
                        space(h: 80.0),
                        Container(
                          height: 430,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  blurRadius: 12.0)
                            ],
                          ),
                          child: Column(
                            children: [
                              prepareForm(context),
                            ],
                          ),
                        ),
                        space(h: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child:
                              Wrap(alignment: WrapAlignment.center, children: [
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
                                      blurRadius: 0.5,
                                      color: Colors.black,
                                      offset: Offset(0.2, 0.2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 4.0),
                              child: GestureDetector(
                                onTap: moveToSignUpScreen,
                                child: Text(
                                  "REGISTER",
                                  textAlign: TextAlign.center,
                                  style: FontType.medium.style(
                                    size: 25,
                                    color: ColorConstants.appPurpleLight,
                                    appFontFamilyName: 'Segoe UI',
                                    shadows: [
                                      Shadow(
                                        blurRadius: 2.0,
                                        color: ColorConstants.appPurpleLight,
                                        offset: const Offset(1.0, 1.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        space(h: 50),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: Divider(
                            color: Colors.black,
                            thickness: 5,
                          ),
                        ),
                      ],
                    ),
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
          "Sign In Account",
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
            onEditingComplete: () => node?.unfocus(),
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
        space(h: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            "In case you forgot password ?",
            textAlign: TextAlign.start,
            style: FontType.medium.style(
              size: 18,
              color: ColorConstants.appPurpleLight,
              appFontFamilyName: 'Lato',
              shadows: [
                Shadow(
                  blurRadius: 1.0,
                  color: ColorConstants.appPurpleLight,
                  offset: const Offset(0.5, 0.5),
                ),
              ],
            ),
          ),
        ),
        space(h: 35),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0),
          child: AppButton(
            bgColor: ColorConstants.appPurpleLight,
            borderRadius: 27.0,
            fontFamily: 'Segoe UI',
            fontSize: 25.0,
            onPressed: () {
              /*showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) => MatchDialogBox(
                  name: 'Riya',
                  image_url_1:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQP_49sa5i0NXT-Q_3M37VPkkUhJLDzvO0c9g&usqp=CAU',
                  image_url_2:
                      'http://thenewcode.com/assets/images/thumbnails/sarah-parmenter.jpeg',
                ),
              );*/
              EasyLoading.show(
                  status: 'Please wait', maskType: EasyLoadingMaskType.black);
              node?.unfocus();
              if (validateSigninForm(context)) {
                signin(context);
              } else {
                EasyLoading.dismiss();
              }
            },
            title: 'SIGN IN',
            textColor: Colors.white,
            height: 54,
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
        space(h: 18),
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
        space(h: 24),
      ],
    );
  }

  void signin(BuildContext context) {
    SigninModel signinModel = SigninModel(
      email: emailController.text,
      password: pwdController.text,
    );

    apiservice
        .signin(signinModel, context)
        .then((value) => {
              if (value != null)
                {
                  if (value.success ?? false)
                    {
                      EasyLoading.dismiss(),
                      secureStorage.writeSecureData(
                          'accessToken', value.accessToken.toString()),
                      secureStorage.writeSecureData(
                          'refreshToken', value.refreshToken.toString()),
                      print("token saved"),
                      moveToHomeScreen()
                    }
                  else
                    {
                      EasyLoading.dismiss(),
                      throw Exception(),
                    }
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

  bool validateSigninForm(BuildContext context) {
    if (emailController.text == "") {
      showInSnackBar("Please enter email", context);
      return false;
    } else if (emailController.text.length > 40 ||
        !emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      showInSnackBar("Invalid email", context);
      return false;
    } else if (pwdController.text == "") {
      showInSnackBar("Please enter password", context);
      return false;
    } else if (pwdController.text.length < 8 ||
        pwdController.text.length > 40 ||
        pwdController.text.contains(' ')) {
      showInSnackBar("Invalid password", context);
      return false;
    }
    return true;
  }

  checkToken() async {
    var token_str = (await secureStorage.readSecureData("accessToken"));
    print(token_str);

    if (token_str != null) {
      moveToHomeScreen();
    }
  }
}
