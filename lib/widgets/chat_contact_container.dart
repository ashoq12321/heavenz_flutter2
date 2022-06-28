import 'package:flutter/material.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/models/chat_contact.dart';
import 'package:heavenz/widgets/notification_counter.dart';

class ChatContactContainer extends StatelessWidget {
  const ChatContactContainer({
    Key? key,
    required this.chatContact,
  }) : super(key: key);

  final ChatContact chatContact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Container(
          height: 98.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                blurRadius: 6.0,
                offset: Offset(0, 3),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(40), // Image radius
                      child: Image.network(
                          chatContact.image_string == ""
                              ? "http://192.168.43.177:3000/files/ic_user.png"
                              : chatContact.image_string!,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 42.0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "${chatContact.first_name} ${chatContact.last_name ?? ""}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                                style: FontType.normal.style(
                                  size: 15.0,
                                  color: Colors.black,
                                  appFontFamilyName: "Poppins",
                                  shadows: [
                                    Shadow(
                                      blurRadius: 0.4,
                                      color: Colors.grey,
                                      offset: Offset(0.2, 0.2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                chatContact.last_message == ""
                                    ? "Hey Start your Conversation"
                                    : chatContact.last_message!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: FontType.normal.style(
                                  size: 15.0,
                                  color: Colors.black.withOpacity(0.52),
                                  appFontFamilyName: "Poppins",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 60.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Visibility(
                          visible: chatContact.online ?? false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 6.0,
                                height: 6.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF06960B),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              space(w: 4.0),
                              Text(
                                "Online",
                                style: FontType.normal.style(
                                  size: 11.0,
                                  color: Color(0xFF06960B),
                                  appFontFamilyName: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(6.0),
                            child: Container(
                              height: 36,
                              width: 36,
                              child: Image.asset(
                                'images/ic_chat_single.png',
                              ),
                            ),
                          ),
                          Visibility(
                            visible: chatContact.unread_msgs_count != "0"
                                ? true
                                : false,
                            child: NotificationCounter(
                              rightPosition: 2,
                              counter: chatContact.unread_msgs_count!,
                              topPosition: 0,
                              bgColor: Color(0xFFD12121),
                              fontSize: 14,
                              width: 20.0,
                              radius: 10.0,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
