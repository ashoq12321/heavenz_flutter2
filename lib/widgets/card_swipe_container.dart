import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';

class CardSwipeContainer extends StatelessWidget {
  const CardSwipeContainer({
    Key? key,
    required this.dobAndAge,
    required this.address,
    this.reportText,
    required this.name,
    required this.sex,
    required this.imageString,
    required this.titleBackground,
    required this.onlineNowBgColor,
    required this.onlineNowDotColor,
    required this.onlineTextDotColor,
  }) : super(key: key);

  final String name;
  final String sex;
  final String dobAndAge;
  final String address;
  final String? reportText;
  final String imageString;
  final bool titleBackground;
  final Color onlineNowBgColor;
  final Color onlineNowDotColor;
  final Color onlineTextDotColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(22.0)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75))
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(imageString),
                      fit: BoxFit.fill,
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(22.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 4.0,
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 24,
                  child: Container(
                    color: onlineNowBgColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            width: 14.0,
                            height: 14.0,
                            decoration: new BoxDecoration(
                              color: onlineNowDotColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          space(w: 8.0),
                          Text(
                            "Online Now",
                            style: FontType.normal.style(
                              size: 15.0,
                              color: onlineTextDotColor,
                              appFontFamilyName: 'Poppins',
                            ),
                          ),
                          space(w: 8.0),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 24,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: titleBackground
                            ? LinearGradient(colors: [
                                ColorConstants.appPurple2.withOpacity(0.83),
                                Colors.white.withOpacity(0.83),
                              ])
                            : LinearGradient(colors: [
                                Colors.transparent,
                                Colors.transparent,
                              ])),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          if (titleBackground)
                            space(w: 30.0)
                          else
                            space(w: 12.0),
                          Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth: 250.0,
                                ),
                                child: Text(
                                  "$name",
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: FontType.normal.style(
                                    size: 24.0,
                                    color: Colors.white,
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
                              Text(
                                " , $sex",
                                style: FontType.normal.style(
                                  size: 24.0,
                                  color: Colors.white,
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
                            ],
                          ),
                          if (titleBackground) space(w: 60)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          space(h: 13.0),
          Row(
            children: [
              space(w: 20.0),
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
                  dobAndAge,
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
              space(w: 20.0),
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
                  address,
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
          if (reportText != null) space(h: 17.0),
          if (reportText != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 18,
                  width: 18,
                  alignment: Alignment.center, // This is needed
                  child: Image.asset(
                    "images/ic_warning.png",
                    fit: BoxFit.contain,
                  ),
                ),
                space(w: 8.0),
                Text(
                  reportText!,
                  style: FontType.normal.style(
                    size: 20.0,
                    color: Colors.black,
                    appFontFamilyName: 'Poppins',
                    shadows: [
                      Shadow(
                        blurRadius: 0.4,
                        color: Colors.black,
                        offset: Offset(0.2, 0.2),
                      ),
                    ],
                  ),
                ),
                space(w: 20.0),
              ],
            ),
          if (reportText != null) space(h: 12.0) else space(h: 24.0),
        ],
      ),
    );
    //);
  }
}
