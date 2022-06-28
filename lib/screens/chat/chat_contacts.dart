import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/models/chat_contact.dart';
import 'package:heavenz/models/view_person.dart';
import 'package:heavenz/widgets/chat_contact_container.dart';
import 'package:heavenz/widgets/container_with_notification.dart';

class ChatContactsScreen extends StatefulWidget {
  const ChatContactsScreen({
    Key? key,
    required this.moveToHomeTab,
    required this.usersList,
    required this.chatContacts,
  }) : super(key: key);

  final moveToHomeTab;
  final List<ViewPerson> usersList;
  final List<ChatContact> chatContacts;

  @override
  _ChatContactsState createState() => _ChatContactsState();
}

class _ChatContactsState extends State<ChatContactsScreen> {
  late int clickedCategoryIndex;

  @override
  void initState() {
    super.initState();
    clickedCategoryIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.moveToHomeTab,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: ColorConstants.appWhite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ContainerWithNotification(
                      bgColor: clickedCategoryIndex == 0
                          ? ColorConstants.appGreen
                          : Colors.white,
                      fontColor: clickedCategoryIndex == 0
                          ? Colors.white
                          : Colors.black.withOpacity(0.54),
                      notificationbgColor: ColorConstants.notificationGreen,
                      notificationCounter: "1",
                      title: 'Room Mate',
                      width: 126,
                      height: 33,
                      boxShadow: true,
                      borderRadius: 17.0,
                      fontSize: 15.0,
                      notificationFontSize: 13.0,
                      notificationRadius: 9.0,
                      notificationWidth: 20.0,
                      onclicked: () {
                        updateCategoryIndex(0);
                      },
                    ),
                    ContainerWithNotification(
                      bgColor: clickedCategoryIndex == 1
                          ? ColorConstants.appGreen
                          : Colors.white,
                      fontColor: clickedCategoryIndex == 1
                          ? Colors.white
                          : Colors.black.withOpacity(0.54),
                      notificationbgColor: ColorConstants.notificationGreen,
                      notificationCounter: "3",
                      title: 'Work',
                      width: 96,
                      height: 33,
                      boxShadow: true,
                      borderRadius: 17.0,
                      fontSize: 15.0,
                      notificationFontSize: 13.0,
                      notificationRadius: 9.0,
                      notificationWidth: 20.0,
                      onclicked: () {
                        updateCategoryIndex(1);
                      },
                    ),
                    ContainerWithNotification(
                      bgColor: clickedCategoryIndex == 2
                          ? ColorConstants.appGreen
                          : Colors.white,
                      fontColor: clickedCategoryIndex == 2
                          ? Colors.white
                          : Colors.black.withOpacity(0.54),
                      notificationbgColor: ColorConstants.notificationGreen,
                      notificationCounter: "1",
                      title: 'Love',
                      width: 96,
                      height: 33,
                      borderRadius: 17.0,
                      fontSize: 15.0,
                      boxShadow: true,
                      notificationFontSize: 13.0,
                      notificationRadius: 9.0,
                      notificationWidth: 20.0,
                      onclicked: () {
                        updateCategoryIndex(2);
                      },
                    ),
                    ContainerWithNotification(
                      bgColor: clickedCategoryIndex == 3
                          ? ColorConstants.appGreen
                          : Colors.white,
                      fontColor: clickedCategoryIndex == 3
                          ? Colors.white
                          : Colors.black.withOpacity(0.54),
                      notificationbgColor: ColorConstants.notificationGreen,
                      notificationCounter: "2",
                      title: 'Marriage',
                      width: 106,
                      height: 33,
                      boxShadow: true,
                      borderRadius: 17.0,
                      fontSize: 15.0,
                      notificationFontSize: 13.0,
                      notificationRadius: 9.0,
                      notificationWidth: 20.0,
                      onclicked: () {
                        updateCategoryIndex(3);
                      },
                    ),
                    ContainerWithNotification(
                      bgColor: clickedCategoryIndex == 4
                          ? ColorConstants.appGreen
                          : Colors.white,
                      fontColor: clickedCategoryIndex == 4
                          ? Colors.white
                          : Colors.black.withOpacity(0.54),
                      notificationbgColor: ColorConstants.notificationGreen,
                      notificationCounter: "7",
                      title: 'Friend',
                      width: 96,
                      height: 33,
                      borderRadius: 17.0,
                      fontSize: 15.0,
                      boxShadow: true,
                      notificationFontSize: 13.0,
                      notificationRadius: 9.0,
                      notificationWidth: 20.0,
                      onclicked: () {
                        updateCategoryIndex(4);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.0),
                height: 120.0,
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      favouriteContacts(context, index),
                  itemCount: widget.usersList.length,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              space(h: 4.0),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (int i = 0; i < widget.chatContacts.length; i++)
                          ChatContactContainer(
                            chatContact: widget.chatContacts[i],
                          )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateCategoryIndex(index) {
    setState(() {
      clickedCategoryIndex = index;
    });
  }

  favouriteContacts(BuildContext context, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        children: [
          Container(
            height: 84,
            padding: EdgeInsets.all(2), // Border width
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(40), // Image radius
                child: Image.network(widget.usersList[index].imageString,
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Text(
            widget.usersList[index].name,
            textAlign: TextAlign.start,
            style: FontType.normal.style(
              size: 15.0,
              color: Colors.black.withOpacity(0.59),
              appFontFamilyName: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
