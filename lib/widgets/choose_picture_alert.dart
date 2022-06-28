import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';

// ignore: must_be_immutable
class ChoosePictureAlertBox extends StatelessWidget {
  ChoosePictureAlertBox({
    Key? key,
    this.takePictureFromCamera,
    this.takePictureFromGallery,
    this.takeVideoFromCamera,
    this.takeVideoFromGallery,
    this.isVideoRequired,
  }) : super(key: key);

  final takePictureFromCamera;
  final takePictureFromGallery;
  final takeVideoFromCamera;
  final takeVideoFromGallery;

  bool? isVideoRequired = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: <Widget>[
      //height: 430.0,
      buildAlertBox(context)
    ]);
  }

  buildAlertBox(context) => SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => takePictureFromCamera(),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.appWhite,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(12.0),
                      topLeft: Radius.circular(12.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Take image from camera",
                      textAlign: TextAlign.center,
                      style: FontType.normal.style(
                        size: 15,
                        color: ColorConstants.iconsGrey,
                        appFontFamilyName: 'Poppins',
                        shadows: [
                          const Shadow(
                            blurRadius: 0.4,
                            color: Colors.black,
                            offset: Offset(0.2, 0.2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              space(h: 0.1),
              if (isVideoRequired ?? false)
                GestureDetector(
                  onTap: () => takeVideoFromCamera(),
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    color: ColorConstants.appWhite,
                    child: Center(
                      child: Text(
                        "Take video from camera",
                        textAlign: TextAlign.center,
                        style: FontType.normal.style(
                          size: 15,
                          color: ColorConstants.iconsGrey,
                          appFontFamilyName: 'Poppins',
                          shadows: [
                            const Shadow(
                              blurRadius: 0.4,
                              color: Colors.black,
                              offset: Offset(0.2, 0.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (isVideoRequired ?? false) space(h: 0.1),
              if (isVideoRequired ?? false)
                GestureDetector(
                  onTap: () => takeVideoFromGallery(),
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    color: ColorConstants.appWhite,
                    child: Center(
                      child: Text(
                        "Upload video from gallery",
                        textAlign: TextAlign.center,
                        style: FontType.normal.style(
                          size: 15,
                          color: ColorConstants.iconsGrey,
                          appFontFamilyName: 'Poppins',
                          shadows: [
                            const Shadow(
                              blurRadius: 0.4,
                              color: Colors.black,
                              offset: Offset(0.2, 0.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (isVideoRequired ?? false) space(h: 0.1),
              GestureDetector(
                onTap: () => takePictureFromGallery(),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstants.appWhite,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12.0),
                      bottomLeft: Radius.circular(12.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Upload image from gallery",
                      textAlign: TextAlign.center,
                      style: FontType.normal.style(
                        size: 15,
                        color: ColorConstants.iconsGrey,
                        appFontFamilyName: 'Poppins',
                        shadows: [
                          const Shadow(
                            blurRadius: 0.4,
                            color: Colors.black,
                            offset: Offset(0.2, 0.2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstants.appGrey,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: FontType.medium.style(
                          size: 18,
                          color: ColorConstants.appGreen,
                          appFontFamilyName: 'Poppins',
                          shadows: [
                            const Shadow(
                              blurRadius: 0.4,
                              color: Colors.black,
                              offset: Offset(0.2, 0.2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
