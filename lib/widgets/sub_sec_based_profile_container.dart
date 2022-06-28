import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/models/view_person.dart';

class SubSectionBasedProfileContainer extends StatelessWidget {
  const SubSectionBasedProfileContainer({
    Key? key,
    this.onclicked,
    required this.name,
    required this.age,
    required this.onlineNow,
    required this.imageString,
  }) : super(key: key);
  final onclicked;
  final String name;
  final String age;
  final bool onlineNow;
  final String imageString;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclicked,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
        child: Container(
          height: 151.0,
          decoration: BoxDecoration(
            /*image: DecorationImage(
                      image: NetworkImage(imageString),
                      fit: BoxFit.fill,
                    ),*/
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(19.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3.0,
                offset: Offset(0.0, 2.4),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 151.0,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageString),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(19.0)),
                ),
              ),
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2.0),
                          child: Text(
                            name,
                            style: FontType.normal.style(
                              size: 25,
                              color: Colors.black,
                              appFontFamilyName: "Poppins",
                              shadows: [
                                Shadow(
                                  blurRadius: 0.4,
                                  color: Colors.black,
                                  offset: Offset(0.2, 0.2),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "${age} years",
                          style: FontType.normal.style(
                            size: 20,
                            color: Colors.black.withOpacity(0.55),
                            appFontFamilyName: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: onlineNow,
                    child: Positioned(
                      top: 6,
                      right: 18,
                      child: Text(
                        "Online Now",
                        style: FontType.normal.style(
                          size: 16,
                          color: ColorConstants.appGreen,
                          appFontFamilyName: "Poppins",
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 12,
                      right: 14,
                      child: Container(
                        height: 36,
                        width: 36,
                        child: Image.asset(
                          'images/ic_chat_single.png',
                        ),
                      )),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
