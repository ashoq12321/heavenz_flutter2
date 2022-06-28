import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:heavenz/api/api_service.dart';
import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:heavenz/models/chat_contact.dart';
import 'package:heavenz/models/swipe_list.dart';
import 'package:heavenz/models/view_person.dart';
import 'package:heavenz/screens/chat/chat_contacts.dart';
import 'package:heavenz/screens/home/demo_screen.dart';

import 'package:heavenz/screens/home/home_initial.dart';
import 'package:heavenz/screens/home/sub_sec_based_profiles_list.dart';
import 'package:heavenz/screens/home/swipe_screen.dart';
import 'package:heavenz/screens/home/view_profile.dart';
import 'package:heavenz/screens/user_profile/user_profile.dart';
import 'package:heavenz/screens/utils/secure_storage.dart';
import 'package:heavenz/widgets/app_header.dart';
import 'package:heavenz/widgets/bottom_nav_bar.dart';
import 'package:heavenz/widgets/side_nav_bar.dart';

enum HomeScreen {
  HOME_INITIAL,
  SWIPE_SCREEN,
  VIEW_PROFILE_SCREEN,
  SUB_SEC_BASED_PROFILES_LIST,
  DEMO_SCREEN,
}

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreeenState createState() => _LandingScreeenState();
}

class _LandingScreeenState extends State<LandingScreen> {
  int _tabIndex = 0;

  late HomeScreen currentHomeScreen;

  late HomeScreen previousHomeScreen;

  late ViewPerson currentViewPerson;

  late int clickedCategoryIndex;

  late int clickedSubSectionIndex;

  late List<String> currentImagesList;

  final SecureStorage secureStorage = SecureStorage();

  String profileName = "User Name";

  String profilePicture = APIService.base_url + "/files/ic_user.png";

  int profilePercentage = 0;

  bool showBottomNavButtonText = true;

  List<ViewPerson> swipePeople = [];

  bool findMoreSwipePeople = true;

  int swipeScreenOffset = 0;

  @override
  void initState() {
    super.initState();
    checkToken();
    //Get.deleteAll();

    setState(() {
      //Get.reset();
      clickedCategoryIndex = 0;
      clickedSubSectionIndex = 0;
      currentHomeScreen = HomeScreen.HOME_INITIAL;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppHeader(
            notificationCounter: '2',
          )),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: getBody(),
      ),
      drawer: SideNavBar(
        imageString: profilePicture,
        name: profileName,
        percentage: profilePercentage,
        moveToProfileScreen: onTabTapped,
      ),
      //drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      bottomNavigationBar: BottomNavBar(
        onTabTapped: onTabTapped,
        currentIndex: _tabIndex,
        showText: showBottomNavButtonText,
        makeTextDelayed: makeBottomNavButtonTextDelayed,
      ),
    );
  }

  getBody() {
    if (_tabIndex == 0)
      return getHomeScreen();
    else if (_tabIndex == 2)
      return ChatContactsScreen(
        moveToHomeTab: moveToHomeTab,
        usersList: getUsersList(),
        chatContacts: getChatContacts(),
      );
    else if (_tabIndex == 3)
      return UserProfile(
        moveToHomeTab: moveToHomeTab,
        fetchCurrentLoggedInUserDetail: fetchCurrentLoggedInUserDetail,
      );
  }

  void makeBottomNavButtonTextDelayed() {
    setState(() {
      showBottomNavButtonText = false;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        showBottomNavButtonText = true;
      });
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _tabIndex = index;
      makeBottomNavButtonTextDelayed();
    });
  }

  Future<bool> moveToHomeTab() async {
    setState(() {
      _tabIndex = 0;
      makeBottomNavButtonTextDelayed();
    });
    return false;
  }

  Future<bool> moveToSwipeScreenForBackPressed() async {
    setState(() {
      previousHomeScreen = currentHomeScreen;
      currentHomeScreen = HomeScreen.SWIPE_SCREEN;
    });
    return false;
  }

  Future<bool> moveToSubSecBasedProfilesListScreenForBackPressed() async {
    setState(() {
      previousHomeScreen = currentHomeScreen;
      currentHomeScreen = HomeScreen.SUB_SEC_BASED_PROFILES_LIST;
    });
    return false;
  }

  Future<bool> moveToHomeInitialScreen() async {
    setState(() {
      swipePeople = [];
      findMoreSwipePeople = true;
      swipeScreenOffset = 0;
      previousHomeScreen = currentHomeScreen;
      currentHomeScreen = HomeScreen.HOME_INITIAL;
    });
    return false;
  }

  updateSubSectionIndex(index) {
    setState(() {
      clickedSubSectionIndex = index;
    });
  }

  updateSwipeScreenFields(swipePeople2, offset, findMoreProfiles) {
    setState(() {
      swipePeople = swipePeople2;
      swipeScreenOffset = offset;
      findMoreSwipePeople = findMoreProfiles;
      print("swipePeopleeeee : $swipePeople");
    });
  }

  moveToSwipeScreen(index) {
    setState(() {
      clickedCategoryIndex = index;
      previousHomeScreen = currentHomeScreen;
      currentHomeScreen = HomeScreen.SWIPE_SCREEN;
      print("clickedCategoryIndex : ${clickedCategoryIndex.toString()}");
    });
  }

  moveToSubSecBasedProfilesListScreen() {
    setState(() {
      previousHomeScreen = currentHomeScreen;
      currentHomeScreen = HomeScreen.SUB_SEC_BASED_PROFILES_LIST;
    });
  }

  moveToViewProfileScreen(swipePerson, images) {
    setState(() {
      previousHomeScreen = currentHomeScreen;
      currentViewPerson = swipePerson;
      currentImagesList = images;
      print("currentSwipePerson " + currentViewPerson.name);
      currentHomeScreen = HomeScreen.VIEW_PROFILE_SCREEN;
    });
  }

  moveToDemoScreen() {
    setState(() {
      previousHomeScreen = currentHomeScreen;
      currentHomeScreen = HomeScreen.DEMO_SCREEN;
    });
  }

  getHomeScreen() {
    if (currentHomeScreen == HomeScreen.HOME_INITIAL)
      return HomeInitial(
        moveToSwipeScreen: moveToSwipeScreen,
        moveToSubSecBasedProfilesListScreen:
            moveToSubSecBasedProfilesListScreen,
        updateCategoryAndSubSectionIndex: updateCategoryAndSubSectionIndex,
      );
    else if (currentHomeScreen == HomeScreen.SWIPE_SCREEN)
      return SwipeScreen(
        onBackPressed: moveToHomeInitialScreen,
        categoryIndex: clickedCategoryIndex,
        moveToViewProfileScreen: moveToViewProfileScreen,
        swipePeople: swipePeople,
        updateSwipeScreenFields: updateSwipeScreenFields,
        findMoreSwipePeople: findMoreSwipePeople,
        swipeScreenOffset: swipeScreenOffset,
      );
    else if (currentHomeScreen == HomeScreen.SUB_SEC_BASED_PROFILES_LIST)
      return SubSectionBasedProfilesList(
        onBackPressed: moveToHomeInitialScreen,
        moveToViewProfileScreen: moveToViewProfileScreen,
        usersList: getUsersList(),
        categoryIndex: clickedCategoryIndex,
        subSectionIndex: clickedSubSectionIndex,
        updateSubSectionIndex: updateSubSectionIndex,
      );
    else if (currentHomeScreen == HomeScreen.VIEW_PROFILE_SCREEN)
      return ViewProfile(
        onBackPressed: getBackPressedFromViewProfile(),
        swipePerson: currentViewPerson, images: currentImagesList,

        //swipePeople: getSwipePeopleList(),
      );
    else if (currentHomeScreen == HomeScreen.DEMO_SCREEN)
      return DemoScreen(
        moveToHomeScreen: moveToHomeInitialScreen,
      );
  }

  getBackPressedFromViewProfile() {
    if (previousHomeScreen == HomeScreen.SWIPE_SCREEN)
      return moveToSwipeScreenForBackPressed;
    else if (previousHomeScreen == HomeScreen.SUB_SEC_BASED_PROFILES_LIST)
      return moveToSubSecBasedProfilesListScreenForBackPressed;
  }

  List<ViewPerson> getUsersList() {
    List<ViewPerson> usersList = [];

    usersList.add(
      ViewPerson(
        name: "Riya",
        sex: "female",
        age: "18",
        address: "Kanchipuram, Tamil nadu, India",
        dob: '01/05/2005',
        imageString: 'https://data.whicdn.com/images/318718656/original.jpg',
      ),
    );
    usersList.add(
      ViewPerson(
        name: "Priya",
        sex: "female",
        age: "23",
        address: "Chennai, Tamil nadu, India",
        dob: '01/05/1998',
        imageString:
            'https://files.oyebesmartest.com/uploads/preview/indian-girl-model-photography-photoshoot-hd--(8)wywjkvmzrd.jpg',
      ),
    );
    usersList.add(
      ViewPerson(
        name: "Sreya",
        sex: "female",
        age: "20",
        address: "Banglore, Karnataka, India",
        dob: '01/05/1999',
        imageString:
            'https://castyou-website.sgp1.digitaloceanspaces.com/2019/03/Aaira.jpg',
      ),
    );
    usersList.add(
      ViewPerson(
        name: "Riya",
        sex: "female",
        age: "18",
        address: "Kanchipuram, Tamil nadu, India",
        dob: '01/05/2005',
        imageString:
            'https://i.pinimg.com/originals/2b/93/fb/2b93fbacb0a85a9e59650bce7bc8f384.jpg',
      ),
    );
    usersList.add(
      ViewPerson(
        name: "Riya",
        sex: "female",
        age: "18",
        address: "Kanchipuram, Tamil nadu, India",
        dob: '01/05/2005',
        imageString:
            'https://images.pexels.com/photos/1832959/pexels-photo-1832959.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      ),
    );
    usersList.add(
      ViewPerson(
        name: "Priya",
        sex: "female",
        age: "23",
        address: "Chennai, Tamil nadu, India",
        dob: '01/05/1998',
        imageString:
            'https://i.pinimg.com/736x/53/6b/0a/536b0a0208bdc315c0a7360116a82322.jpg',
      ),
    );
    usersList.add(
      ViewPerson(
        name: "Sreya",
        sex: "female",
        age: "20",
        address: "Banglore, Karnataka, India",
        dob: '01/05/1999',
        imageString:
            'https://1.bp.blogspot.com/-rVWZPkvLkV4/XZ_CY6kDT7I/AAAAAAAAAP0/pTWOIv2oYP4pdbvva1m8jjUTNPZ1-tbcACLcBGAsYHQ/s1600/Girl_1570751057381.png',
      ),
    );
    usersList.add(
      ViewPerson(
        name: "Riya",
        sex: "female",
        age: "18",
        address: "Kanchipuram, Tamil nadu, India",
        dob: '01/05/2005',
        imageString:
            'https://media.istockphoto.com/photos/beautiful-woman-picture-id927570754?k=20&m=927570754&s=612x612&w=0&h=pfkJ2JME5btI6S5mk26iOYxUEJBc2kf3u03wbtsUvek=',
      ),
    );

    return usersList;
  }

  getChatContacts() {
    List<ChatContact> chatContacts2 = [];
    ChatContact chatContact = ChatContact();
    chatContact.first_name = "Shraya";
    chatContact.last_name = "goshal";
    chatContact.image_string =
        "https://i.pinimg.com/originals/de/64/80/de64801f0275c1ab2ea5a9e2bb3ce7bc.jpg";
    chatContact.last_message = "Hi";
    chatContact.online = true;
    chatContact.unread_msgs_count = "2";
    chatContacts2.add(chatContact);

    chatContact = ChatContact();
    chatContact.first_name = "Bala";
    chatContact.last_name = "Murugan";
    chatContact.image_string =
        "https://pbs.twimg.com/media/E9udtUmWEAIo7o5.png";
    chatContact.last_message = "";
    chatContact.online = true;
    chatContact.unread_msgs_count = "0";
    chatContacts2.add(chatContact);

    chatContact = ChatContact();
    chatContact.first_name = "Muthu";
    chatContact.last_name = "M";
    chatContact.image_string =
        "https://minimaltoolkit.com/images/randomdata/male/38.jpg";
    chatContact.last_message = "";
    chatContact.online = false;
    chatContact.unread_msgs_count = "3";
    chatContacts2.add(chatContact);

    chatContact = ChatContact();
    chatContact.first_name = "Shraya";
    chatContact.last_name = "goshal";
    chatContact.image_string = "";
    chatContact.last_message = "Hi";
    chatContact.online = true;
    chatContact.unread_msgs_count = "2";
    chatContacts2.add(chatContact);

    chatContact = ChatContact();
    chatContact.first_name = "Bala";
    chatContact.last_name = "Murugan";
    chatContact.image_string =
        "https://pbs.twimg.com/media/E9udtUmWEAIo7o5.png";
    chatContact.last_message = "";
    chatContact.online = true;
    chatContact.unread_msgs_count = "1";
    chatContacts2.add(chatContact);

    chatContact = ChatContact();
    chatContact.first_name = "Muthu";
    chatContact.last_name = "M";
    chatContact.image_string =
        "https://minimaltoolkit.com/images/randomdata/male/38.jpg";
    chatContact.last_message = "";
    chatContact.online = false;
    chatContact.unread_msgs_count = "3";
    chatContacts2.add(chatContact);

    chatContact = ChatContact();
    chatContact.first_name = "Shraya";
    chatContact.last_name = "goshal";
    chatContact.image_string =
        "https://i.pinimg.com/originals/de/64/80/de64801f0275c1ab2ea5a9e2bb3ce7bc.jpg";
    chatContact.last_message = "Hi";
    chatContact.online = true;
    chatContact.unread_msgs_count = "2";
    chatContacts2.add(chatContact);

    chatContact = ChatContact();
    chatContact.first_name = "Bala";
    chatContact.last_name = "Murugan";
    chatContact.image_string =
        "https://pbs.twimg.com/media/E9udtUmWEAIo7o5.png";
    chatContact.last_message = "";
    chatContact.online = true;
    chatContact.unread_msgs_count = "1";
    chatContacts2.add(chatContact);

    chatContact = ChatContact();
    chatContact.first_name = "Muthu";
    chatContact.last_name = "M";
    chatContact.image_string =
        "https://minimaltoolkit.com/images/randomdata/male/38.jpg";
    chatContact.last_message = "";
    chatContact.online = false;
    chatContact.unread_msgs_count = "3";
    chatContacts2.add(chatContact);

    return chatContacts2;
  }

  updateCategoryAndSubSectionIndex(cat, sub_sec) {
    setState(() {
      clickedCategoryIndex = cat;
      clickedSubSectionIndex = sub_sec;
      print("clickedCategoryIndex ${clickedCategoryIndex}");
      print("clickedSubSectionIndex ${clickedSubSectionIndex}");
    });
  }

  checkToken() async {
    var token_str = (await secureStorage.readSecureData("accessToken"));
    print(token_str);

    if (token_str == null) {
      moveToSignInScreen();
    } else {
      fetchCurrentLoggedInUserDetail();
    }
  }

  void fetchCurrentLoggedInUserDetail() {
    EasyLoading.show(
        status: 'Please wait', maskType: EasyLoadingMaskType.black);
    APIService apiservice = APIService();

    apiservice
        .getUserDetails(context, true, true)
        .then((user) => {
              if (user != null)
                {
                  setState(() {
                    if (user.first_name != null &&
                        user.first_name != "" &&
                        user.last_name != null &&
                        user.last_name != "")
                      profileName = user.first_name! + " " + user.last_name!;
                    if (user.profile_pic_url != null &&
                        user.profile_pic_url != "")
                      profilePicture = user.profile_pic_url!;
                    if (user.profile_percentage != null)
                      profilePercentage = user.profile_percentage!;

                    moveToDemoScreen();
                  }),
                  EasyLoading.dismiss(),
                }
              else
                {
                  print("user : " + user.toString()),
                  EasyLoading.dismiss(),
                  //throw Exception(),
                  secureStorage.deleteSecureData("accessToken"),
                  secureStorage.deleteSecureData("refreshToken"),
                  moveToSignInScreen(),
                }
            })
        .catchError((error, stackTrace) {
      EasyLoading.dismiss();
      secureStorage.deleteSecureData("accessToken");
      secureStorage.deleteSecureData("refreshToken");
      moveToSignInScreen();
      //showInSnackBar("Something went wrong", context);
    });
  }
}
