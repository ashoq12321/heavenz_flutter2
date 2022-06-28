import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({
    Key? key,
    required this.welcomeText,
    required this.subText,
    required this.buttonText,
    required this.logoAssetString,
    required this.onTapped,
  }) : super(key: key);

  final String welcomeText;
  final String subText;
  final String buttonText;
  final String logoAssetString;
  final VoidCallback onTapped;

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  var logoPositionTop;
  var logoPositionBottom;

  @override
  void initState() {
    _getThingsOnStartup().then((value) {
      setState(() {
        logoPositionTop = -20.0;
        logoPositionBottom = -30.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.appWhiteLight,
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.appPurple,
                          border: Border.all(color: ColorConstants.appGrey),
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 10.0)
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              space(h: 80),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 35),
                                child: Text(
                                  widget.welcomeText,
                                  textAlign: TextAlign.center,
                                  style: FontType.normal.style(
                                      size: 38,
                                      color: Colors.white,
                                      appFontFamilyName: 'Poppins'),
                                ),
                              ),
                              space(h: 30),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 17),
                                child: Text(
                                  widget.subText,
                                  textAlign: TextAlign.center,
                                  style: FontType.normal.style(
                                      size: 14,
                                      color: Colors.white.withOpacity(0.43),
                                      appFontFamilyName: 'Poppins'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: ColorConstants.appWhiteLight,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 51, horizontal: 32),
                            child: GestureDetector(
                              onTap: widget.onTapped,
                              child: Container(
                                height: 66.0,
                                decoration: BoxDecoration(
                                    color: ColorConstants.appPurple,
                                    borderRadius: BorderRadius.circular(35.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 10.0)
                                    ],
                                    border: Border.all(
                                        color: ColorConstants.appGrey,
                                        width: 1.0)),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.buttonText,
                                        style: FontType.normal.style(
                                            size: 23.0,
                                            color: Colors.white,
                                            appFontFamilyName: 'Poppins'),
                                      ),
                                      space(w: 18),
                                      Image.asset("images/ic_arrow_right.png",
                                          scale: 1),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              AnimatedPositioned(
                top: logoPositionTop ??
                    (MediaQuery.of(context).size.height / 2) - 90,
                left: logoPositionBottom ??
                    (MediaQuery.of(context).size.width / 2) - 90,
                duration: const Duration(milliseconds: 800),
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.87),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.87),
                    ),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(100.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2), blurRadius: 10.0)
                    ],
                  ),
                  child: Image.asset(widget.logoAssetString, scale: 1.3),
                ),
              ),
            ],
          ),
        ));
  }

  Future _getThingsOnStartup() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
