import 'package:flutter/material.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/widgets/side_nav_bar.dart';
import 'package:heavenz/widgets/notification_counter.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    Key? key,
    required this.notificationCounter,
  }) : super(key: key);

  final String notificationCounter;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 101,
        color: const Color(0xFFEDF0F0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 17.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
                child: GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Image(
                    image: AssetImage("images/ic_menu.png"),
                    width: 32,
                    height: 32,
                  ),
                ),
              ),
              const Expanded(
                child: Image(
                  image: AssetImage("images/ic_logo_horizontal.png"),
                  width: 124,
                  height: 32,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Stack(
                  children: [
                    Icon(
                      Icons.notifications,
                      color: ColorConstants.appGreenDark,
                      size: 32,
                    ),
                    NotificationCounter(
                      rightPosition: 4,
                      counter: notificationCounter,
                      topPosition: 0,
                      bgColor: ColorConstants.notificationRed,
                      fontSize: 8,
                      width: 14,
                      radius: 6,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
