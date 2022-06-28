import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'dart:math' as math;

class DemoScreen extends StatefulWidget {
  DemoScreen({
    Key? key,
    this.moveToHomeScreen,
  });

  final moveToHomeScreen;

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(3.0, 0.0),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    ),
  );
  late List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;

  SlideRegion? region;

  List<String> demotexts = ["aaaaaa", "bbbbb", "ccccc"];

  late int current_index;

  @override
  void initState() {
    for (int i = 0; i < 3; i++) {
      _swipeItems.add(
        SwipeItem(
          content: demotexts[i],
          likeAction: () {
            print("liked");
            current_index++;
          },
          nopeAction: () {
            print("disliked");
            current_index++;
          },
          superlikeAction: () {
            current_index++;
          },
          onSlideUpdate: (SlideRegion? slideRegion) async {
            print(slideRegion);
            setState(() {
              region = slideRegion;
            });
          },
        ),
      );
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    current_index = 0;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //showDemo();
    //Future.delayed(Duration.zero, () => showAlert(context));
    return WillPopScope(
      onWillPop: widget.moveToHomeScreen,
      child: SafeArea(
        child: Column(
          children: [
            space(h: 8.0),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: SwipeCards(
                      matchEngine: _matchEngine!,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/demo_screen.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        );
                      },
                      onStackFinished: widget.moveToHomeScreen,
                      upSwipeAllowed: true,
                    ),
                  ),
                  Align(
                    alignment: current_index == 0
                        ? Alignment.centerLeft
                        : current_index == 1
                            ? Alignment.centerRight
                            : Alignment.bottomCenter,
                    child: RotatedBox(
                      quarterTurns: current_index == 0
                          ? 0
                          : current_index == 1
                              ? 2
                              : 3,
                      child: SlideTransition(
                        position: _offsetAnimation,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_right_alt_sharp,
                            size: 150,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 34.0),
                      child: Container(
                        height: 200,
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          current_index == 0
                              ? "Interested"
                              : current_index == 1
                                  ? "Not Interested"
                                  : "View Profile\n(Quick view )",
                          style: FontType.bold.style(
                            size: 30,
                            color: region == SlideRegion.inLikeRegion
                                ? ColorConstants.notificationGreen
                                : region == SlideRegion.inNopeRegion
                                    ? ColorConstants.appRed
                                    : Colors.white,
                            appFontFamilyName: 'Poppins',
                            shadows: [
                              Shadow(
                                blurRadius: 0.5,
                                color: ColorConstants.appPurpleDark,
                                offset: Offset(0.3, 0.3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
