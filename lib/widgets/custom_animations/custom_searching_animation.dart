import 'package:flutter/material.dart';
import 'package:heavenz/constants/color_constants.dart';

class SearchingAnimation extends StatefulWidget {
  const SearchingAnimation({
    Key? key,
  }) : super(key: key);

  @override
  _SearchingAnimationState createState() => _SearchingAnimationState();
}

class _SearchingAnimationState extends State<SearchingAnimation>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  late AnimationController animationController2;
  late Animation<double> animation2;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animationController.repeat();
    animationController2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    animation2 = CurvedAnimation(
      parent: animationController2,
      curve: Curves.elasticOut,
    );
    animationController2.repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    animationController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: RotationTransition(
          turns: animation,
          child: Container(
            height: 320.0,
            width: 320.0,
            child: Stack(
              //alignment: Alignment.topCenter,
              children: [
                Container(
                  height: 320.0,
                  width: 320.0,
                  child: Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    //height: double.infinity,
                    decoration: BoxDecoration(
                        color: ColorConstants.appGreen, shape: BoxShape.circle),
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                              color: ColorConstants.appWhite,
                              shape: BoxShape.circle),
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            margin: EdgeInsets.all(28.0),
                            decoration: BoxDecoration(
                                color: ColorConstants.appGreen,
                                shape: BoxShape.circle),
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(1.0),
                              decoration: BoxDecoration(
                                  color: ColorConstants.appWhite,
                                  shape: BoxShape.circle),
                              child: Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.all(1.0),
                                    decoration: BoxDecoration(
                                        color: ColorConstants.appWhite,
                                        shape: BoxShape.circle),
                                    child: Container(
                                      height: double.infinity,
                                      width: double.infinity,
                                      margin: EdgeInsets.all(28.0),
                                      decoration: BoxDecoration(
                                          color: ColorConstants.appGreen,
                                          shape: BoxShape.circle),
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.all(1.0),
                                        decoration: BoxDecoration(
                                            color: ColorConstants.appWhite,
                                            shape: BoxShape.circle),
                                        child: RotationTransition(
                                          turns: animation2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        "images/ic_map.png"),
                                                  ),
                                                  shape: BoxShape.circle),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.24,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.24,
                                              child: Container(
                                                margin: EdgeInsets.all(26.0),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                  image: AssetImage(
                                                    "images/icon_location_green.png",
                                                  ),
                                                  fit: BoxFit.contain,
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 8,
                                    bottom: 30,
                                    child: RotationTransition(
                                      turns: animation2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 24.0, // Image radius
                                          backgroundImage:
                                              AssetImage("images/dummy2.png"),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 74,
                                    child: RotationTransition(
                                      turns: animation2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 24.0, // Image radius
                                          backgroundImage:
                                              AssetImage("images/dummy3.png"),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 8,
                                    bottom: 30,
                                    child: RotationTransition(
                                      turns: animation2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 24.0, // Image radius
                                          backgroundImage:
                                              AssetImage("images/dummy4.png"),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          top: 50,
                          child: RotationTransition(
                            turns: animation2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 24.0, // Image radius
                                backgroundImage:
                                    AssetImage("images/dummy5.png"),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12,
                          top: 50,
                          child: RotationTransition(
                            turns: animation2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 24.0, // Image radius
                                backgroundImage:
                                    AssetImage("images/dummy6.png"),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 98,
                          child: RotationTransition(
                            turns: animation2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 24.0, // Image radius
                                backgroundImage:
                                    AssetImage("images/dummy7.png"),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 60,
                  child: RotationTransition(
                    turns: animation2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 24.0, // Image radius
                        backgroundImage: AssetImage("images/dummy8.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 60,
                  child: RotationTransition(
                    turns: animation2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 24.0, // Image radius
                        backgroundImage: AssetImage("images/dummy9.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 60,
                  child: RotationTransition(
                    turns: animation2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 18.0, // Image radius
                        backgroundImage: AssetImage("images/dummy10.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 60,
                  child: RotationTransition(
                    turns: animation2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 24.0, // Image radius
                        backgroundImage: AssetImage("images/dummy11.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 130,
                  child: RotationTransition(
                    turns: animation2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 24.0, // Image radius
                        backgroundImage: AssetImage("images/dummy12.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 130,
                  child: RotationTransition(
                    turns: animation2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 18.0, // Image radius
                        backgroundImage: AssetImage("images/dummy.png"),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
