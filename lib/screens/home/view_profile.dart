import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:heavenz/api/api_service.dart';
import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/models/user_images.dart';
import 'package:heavenz/models/view_person.dart';
import 'package:image_picker/image_picker.dart';

class ViewProfile extends StatefulWidget {
  ViewProfile({
    Key? key,
    required this.onBackPressed,
    required this.swipePerson,
    required this.images,
  }) : super(key: key);

  final onBackPressed;
  final ViewPerson swipePerson;
  final List<String> images;

  @override
  _ViewProfileState createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  String lastSeen = "Last seen 20 minutes ago"; //Online Now

  /*String about =
      "If you're looking for random paragraphssss, you've come to the right place. Generating random paragraphs can be an excellent way for writers to get their creative flow going at the beginning of the day. The writer has no idea what topic the random paragraph will be about when it appears. A few examples of how some people use this generator are listed in the following paragraphs.";*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.onBackPressed,
      child: SafeArea(
        child: Container(
          color: ColorConstants.appWhiteLight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 4.0,
                      )
                    ],
                  ),
                  child: Carousel(
                    boxFit: BoxFit.fill,
                    images: [
                      if (widget.images.length > 0)
                        for (int i = 0; i < widget.images.length; i++)
                          NetworkImage(
                            widget.images[i],
                          )
                      else
                        AssetImage("images/ic_user_dark.png")
                    ],
                    dotSize: 5.0,
                    dotSpacing: 15.0,
                    dotIncreaseSize: 2.0,
                    //animationDuration: const Duration(milliseconds: 1000),
                    //autoplayDuration: const Duration(milliseconds: 800),
                    autoplay: false,
                    //onImageChange: stopAutoplay(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 6.0, horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.swipePerson.name,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: FontType.medium.style(
                              size: 32.0,
                              color: Colors.black,
                              appFontFamilyName: 'Poppins',
                              shadows: [
                                Shadow(
                                  blurRadius: 0.4,
                                  color: ColorConstants.appPurpleDark,
                                  offset: Offset(0.3, 0.3),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                widget.swipePerson.sex == 'male'
                                    ? Icons.male
                                    : Icons.female,
                                color: widget.swipePerson.sex == 'male'
                                    ? Color(0xFF2ecafd)
                                    : Color(0xFFdc2fbd),
                                size: 22.0,
                              ),
                              //
                              Text(
                                '${widget.swipePerson.sex}',
                                style: FontType.normal.style(
                                  size: 13.0,
                                  color: ColorConstants.appPurpleDark,
                                  appFontFamilyName: 'Poppins',
                                ),
                              ),
                              space(w: 10.0),
                            ],
                          ),
                        ],
                      ),
                      space(h: 24.0),
                      Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            alignment: Alignment.center, // This is needed
                            child: Image.asset(
                              "images/ic_calender_4x.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          space(w: 14.0),
                          Flexible(
                            child: Text(
                              '${widget.swipePerson.dob} & ${widget.swipePerson.age} years',
                              style: FontType.normal.style(
                                size: 20.0,
                                color: ColorConstants.appPurpleDark,
                                appFontFamilyName: 'Poppins',
                                shadows: [
                                  Shadow(
                                    blurRadius: 0.4,
                                    color: ColorConstants.appPurpleDark,
                                    offset: Offset(0.2, 0.2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      space(h: 10.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3.0),
                            child: Container(
                              height: 26,
                              width: 26,
                              alignment: Alignment.center, // This is needed
                              child: Image.asset(
                                "images/ic_location_4x.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          space(w: 14.0),
                          Flexible(
                            child: Text(
                              '${widget.swipePerson.address}',
                              style: FontType.normal.style(
                                size: 20.0,
                                color: ColorConstants.appPurpleDark,
                                appFontFamilyName: 'Poppins',
                                shadows: [
                                  Shadow(
                                    blurRadius: 0.4,
                                    color: ColorConstants.appPurpleDark,
                                    offset: Offset(0.2, 0.2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      space(h: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (lastSeen == "Online Now")
                            Icon(
                              Icons.access_time,
                              color: Colors.greenAccent.shade700,
                              size: 18.0,
                            )
                          else
                            Icon(
                              Icons.access_time,
                              color: ColorConstants.appPurpleDark,
                              size: 18.0,
                            ),
                          space(w: 8.0),
                          Text(
                            lastSeen,
                            style: FontType.normal.style(
                              size: 14.0,
                              color: lastSeen == "Online Now"
                                  ? Colors.greenAccent.shade700
                                  : ColorConstants.appPurpleDark,
                              appFontFamilyName: 'Poppins',
                            ),
                          ),
                          space(w: 10.0),
                        ],
                      ),
                      space(h: 20.0),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 14.0),
                        decoration: BoxDecoration(
                          color: ColorConstants.appPurpleDark,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: Text(
                          "About Profile",
                          textAlign: TextAlign.center,
                          style: FontType.medium.style(
                            size: 22.0,
                            color: Colors.white,
                            appFontFamilyName: 'Poppins',
                            shadows: [
                              Shadow(
                                blurRadius: 0.4,
                                color: ColorConstants.appPurpleDark,
                                offset: Offset(0.3, 0.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      space(h: 6.0),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(minHeight: 200.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(22.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 4.0,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 16.0),
                          child: Text(
                            widget.swipePerson.about_me ?? "",
                            style: FontType.normal.style(
                              size: 15.0,
                              color: Colors.black,
                              appFontFamilyName: 'Poppins',
                              shadows: [
                                Shadow(
                                  blurRadius: 0.3,
                                  color: ColorConstants.appPurpleDark,
                                  offset: Offset(0.2, 0.2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      space(h: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.onBackPressed();
                            },
                            child: Container(
                              height: 75,
                              width: 75,
                              alignment: Alignment.center, // This is needed
                              child: Image.asset(
                                "images/ic_wrong_tick.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          space(w: 16.0),
                          GestureDetector(
                            onTap: () {
                              widget.onBackPressed();
                            },
                            child: Container(
                              height: 58,
                              width: 58,
                              alignment: Alignment.center, // This is needed
                              child: Image.asset(
                                "images/ic_right_tick.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                      space(h: 30.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //);
  }
}
