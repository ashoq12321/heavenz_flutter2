import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:heavenz/api/api_service.dart';
import 'package:heavenz/constants/app_font.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/models/user_images.dart';
import 'package:heavenz/models/user_settings.dart';

import 'package:heavenz/screens/user_profile/edit_user_profile.dart';
import 'package:heavenz/screens/user_profile/user_prof_settings.dart';
import 'package:heavenz/widgets/app_button.dart';
import 'package:heavenz/widgets/choose_picture_alert.dart';
import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderables/reorderables.dart';

enum UserProfileScreenType { USER_PROFILE, EDIT_USER_PROFILE, SETTINGS }
enum GENDER { MALE, FEMALE, BOTH }

class UserProfile extends StatefulWidget {
  const UserProfile(
      {Key? key,
      required this.moveToHomeTab,
      required this.fetchCurrentLoggedInUserDetail})
      : super(key: key);

  final moveToHomeTab;
  final fetchCurrentLoggedInUserDetail;

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late UserProfileScreenType currentUserProfileScreen;
  List<UserSettingModel> userSettingsList = [];
  late Color addImageIconBgColor;

  List<String> imageFiles = []; // paths of the image files

  int imagesLimit = 8;
  //bool videoUploaded = false;
  int clickedImageUploadButton = -1;

  PickedFile? videoFile = null;

  //bool reOrderEnabled = true;

  @override
  void initState() {
    currentUserProfileScreen = UserProfileScreenType.USER_PROFILE;
    userSettingsList = getUserSettingsList();
    addImageIconBgColor = ColorConstants.appGreen;

    setEmptyImages();

    fetchUserImages();

    super.initState();
  }

  void _onReorderImages(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex == 0 || newIndex == 0) {
        if (videoFile == null) {
          print("oldIndex $oldIndex newIndex $newIndex");
          String row = imageFiles.removeAt(oldIndex);
          imageFiles.insert(newIndex, row);
          moveEmptyImagesAtTheEnd();
        } else if ((videoFile != null) && oldIndex != 0 && newIndex == 0) {
          newIndex = 1;
          print("oldIndex $oldIndex newIndex $newIndex");
          String row = imageFiles.removeAt(oldIndex);
          imageFiles.insert(newIndex, row);
          moveEmptyImagesAtTheEnd();
        }
      } else {
        print("oldIndex $oldIndex newIndex $newIndex");
        String row = imageFiles.removeAt(oldIndex);
        imageFiles.insert(newIndex, row);
        moveEmptyImagesAtTheEnd();
      }
    });
  }

  /*void _onReorderImagesStarted(int oldIndex) {
    if (imageFiles.asMap().containsKey(oldIndex) &&
        imageFiles[oldIndex].isNotEmpty) {
      setState(() {
        reOrderEnabled = true;
      });
    } else {
      setState(() {
        reOrderEnabled = false;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  getBody() {
    if (currentUserProfileScreen == UserProfileScreenType.USER_PROFILE)
      return getInitialUserProfileScreen();
    else if (currentUserProfileScreen ==
        UserProfileScreenType.EDIT_USER_PROFILE)
      return EditUserProfile(
        onBackPressed: moveToInitialUserProfileScreenForBackPressed,
        moveToInitialUserProfileScreen: moveToInitialUserProfileScreen,
        fetchCurrentLoggedInUserDetail: widget.fetchCurrentLoggedInUserDetail,
      );
    else if (currentUserProfileScreen == UserProfileScreenType.SETTINGS)
      return UserProfileSettings(
        onBackPressed: moveToInitialUserProfileScreenForBackPressed,
        moveToInitialUserProfileScreen: moveToInitialUserProfileScreen,
        userSettingsList: userSettingsList,
        updateList: updateUserSettingsList,
      );
  }

  Future<bool> moveToInitialUserProfileScreenForBackPressed() async {
    setState(() {
      currentUserProfileScreen = UserProfileScreenType.USER_PROFILE;
    });
    return false;
  }

  moveToInitialUserProfileScreen() {
    setState(() {
      currentUserProfileScreen = UserProfileScreenType.USER_PROFILE;
    });
  }

  moveToEditProfileScreen() {
    setState(() {
      currentUserProfileScreen = UserProfileScreenType.EDIT_USER_PROFILE;
    });
  }

  moveToUserProfileSettingsScreen() {
    setState(() {
      currentUserProfileScreen = UserProfileScreenType.SETTINGS;
    });
  }

  Widget getInitialUserProfileScreen() {
    return WillPopScope(
      onWillPop: widget.moveToHomeTab,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: SingleChildScrollView(
                  child: Container(
                    color: ColorConstants.appWhite,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                children: [
                                  space(h: 20.0),
                                  Container(
                                    height: 142,
                                    width: 142,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: (availableImagesCount() == 0)
                                            ? AssetImage(
                                                "images/ic_user_dark.png")
                                            : (videoFile != null)
                                                ? availableImagesCount() > 1
                                                    ? FileImage(
                                                        File(imageFiles[1]))
                                                    : AssetImage(
                                                            "images/ic_user_dark.png")
                                                        as ImageProvider
                                                : FileImage(
                                                    File(imageFiles[0])),
                                        /*NetworkImage(
                                              "https://photos.modelmayhem.com/avatars/4/3/4/7/2/8/2/5e26c3548f672_m.jpg"),*/
                                        fit: BoxFit.fill,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.6),
                                          blurRadius: 0.1,
                                          offset: Offset(-1.0, 1.9),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 6,
                              child: Image(
                                image: AssetImage("images/ic_star.png"),
                                height: 40.0,
                                width: 40.0,
                              ),
                            ),
                          ],
                        ),
                        space(h: 20.0),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 120.0,
                                  constraints: BoxConstraints(minWidth: 80.0),
                                  decoration: BoxDecoration(
                                    //color: Colors.blue,
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                        ),
                                        iconSize: 40,
                                        color: Colors.red,
                                        onPressed: () {},
                                      ),
                                      Flexible(
                                        child: Text(
                                          "100",
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
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 120.0,
                                  constraints: BoxConstraints(minWidth: 80.0),
                                  decoration: BoxDecoration(
                                    //color: Colors.blue,
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.mode_edit_outlined,
                                        ),
                                        iconSize: 40,
                                        color: ColorConstants.iconsGrey,
                                        onPressed: moveToEditProfileScreen,
                                      ),
                                      Flexible(
                                        child: Text(
                                          "Edit Profile",
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
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 120.0,
                                  constraints: BoxConstraints(minWidth: 80.0),
                                  decoration: BoxDecoration(
                                    //color: Colors.blue,
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.settings_sharp,
                                        ),
                                        iconSize: 40,
                                        color: ColorConstants.iconsGrey,
                                        onPressed:
                                            moveToUserProfileSettingsScreen,
                                      ),
                                      Flexible(
                                        child: Text(
                                          "Settings",
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
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 120.0,
                                  constraints: BoxConstraints(minWidth: 80.0),
                                  decoration: BoxDecoration(
                                    //color: Colors.blue,
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                        ),
                                        iconSize: 40,
                                        color: ColorConstants.iconsGrey,
                                        onPressed: () {},
                                      ),
                                      Flexible(
                                        child: Text(
                                          "Delete Account",
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
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          child: ReorderableWrap(
                            alignment: WrapAlignment.center,
                            onReorder: _onReorderImages,
                            //enableReorder: reOrderEnabled,
                            //onReorderStarted: _onReorderImagesStarted,
                            children: [
                              for (int i = 0; i < imagesLimit; i++)
                                if (imageFiles[i] != "")
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 13.0, horizontal: 6.0),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: 84.0,
                                              width: 84.0,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                image: DecorationImage(
                                                  image: FileImage(
                                                      File(imageFiles[i])),
                                                  fit: BoxFit.fill,
                                                ),
                                                color: Colors.black
                                                    .withOpacity(0.04),
                                              ),
                                            ),
                                            if ((videoFile != null) && i == 0)
                                              Container(
                                                height: 36.0,
                                                width: 48.0,
                                                decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.55),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                6.0))),
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons
                                                      .play_circle_outline_sharp,
                                                  size: 30,
                                                  color: ColorConstants
                                                      .appGreenDark,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: 1,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () => removeImageFile(i),
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "images/ic_cancel.png"),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                else
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        clickedImageUploadButton = i;
                                        addImageIconBgColor =
                                            ColorConstants.appGreenLight;
                                        getThingsDelayed(100).then((value) {
                                          setState(() {
                                            addImageIconBgColor =
                                                ColorConstants.appGreen;

                                            if (availableImagesCount() <
                                                imagesLimit) {
                                              showModalBottomSheet<dynamic>(
                                                isScrollControlled: true,
                                                context: context,
                                                backgroundColor:
                                                    Colors.transparent,
                                                builder: (context) =>
                                                    ChoosePictureAlertBox(
                                                  takePictureFromCamera:
                                                      takePictureFromCamera,
                                                  takePictureFromGallery:
                                                      takePictureFromGallery,
                                                  takeVideoFromCamera:
                                                      takeVideoFromCamera,
                                                  takeVideoFromGallery:
                                                      takeVideoFromGallery,
                                                  isVideoRequired:
                                                      !(videoFile != null),
                                                ),
                                              );
                                            } else {
                                              showInSnackBar(
                                                  "Maximum allowed images : 8",
                                                  context);
                                            }
                                          });
                                        });
                                      });
                                    },
                                    child: SizedBox(
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 13.0,
                                                horizontal: 6.0),
                                            child: Container(
                                              height: 84.0,
                                              width: 84.0,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1.0,
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                color: Colors.black
                                                    .withOpacity(0.04),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 1,
                                            right: 0,
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    (clickedImageUploadButton ==
                                                            i)
                                                        ? addImageIconBgColor
                                                        : ColorConstants
                                                            .appGreen,
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                size: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        ),
                        space(h: 40.0),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                constraints: BoxConstraints(maxWidth: 314.0),
                child: AppButton(
                  bgColor: ColorConstants.appPurpleDark,
                  borderRadius: 29.0,
                  fontFamily: 'Poppins',
                  fontSize: 20.0,
                  onPressed: () => uploadImageFiles(context),
                  title: 'Update Profile',
                  textColor: Colors.white,
                  height: 52,
                  //borderColor: ColorConstants.appGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getUserSettingsList() {
    List<UserSettingModel> list = [];

    UserSettingModel settingsModel = UserSettingModel(
        categoryName: "ROOM MATE",
        gender: GENDER.BOTH,
        ageStart: "18",
        ageEnd: "90",
        distance: "100",
        showProfile: true,
        onlineVisibility: true,
        lastSeen: true);
    list.add(settingsModel);
    settingsModel = UserSettingModel(
        categoryName: "WORK",
        gender: GENDER.BOTH,
        ageStart: "18",
        ageEnd: "90",
        distance: "100",
        showProfile: true,
        onlineVisibility: true,
        lastSeen: true);
    list.add(settingsModel);
    settingsModel = UserSettingModel(
        categoryName: "LOVE",
        gender: GENDER.BOTH,
        ageStart: "18",
        ageEnd: "90",
        distance: "100",
        showProfile: true,
        onlineVisibility: true,
        lastSeen: true);
    list.add(settingsModel);
    settingsModel = UserSettingModel(
        categoryName: "MARRIAGE",
        gender: GENDER.BOTH,
        ageStart: "18",
        ageEnd: "90",
        distance: "100",
        showProfile: true,
        onlineVisibility: true,
        lastSeen: true);
    list.add(settingsModel);
    settingsModel = UserSettingModel(
        categoryName: "FRIEND",
        gender: GENDER.BOTH,
        ageStart: "18",
        ageEnd: "90",
        distance: "100",
        showProfile: true,
        onlineVisibility: true,
        lastSeen: true);
    list.add(settingsModel);
    return list;
  }

  updateUserSettingsList(List<UserSettingModel> list) {
    setState(() {
      userSettingsList = list;
    });
  }

  takePictureFromCamera() {
    imageSelector(context, "image_camera");
    Navigator.pop(context);
  }

  takePictureFromGallery() {
    imageSelector(context, "image_gallery");
    Navigator.pop(context);
  }

  takeVideoFromCamera() {
    if (videoFile == null) imageSelector(context, "video_camera");
    Navigator.pop(context);
  }

  takeVideoFromGallery() {
    if (videoFile == null) imageSelector(context, "video_gallery");
    Navigator.pop(context);
  }

  Future imageSelector(BuildContext context, String pickerType) async {
    List<PickedFile> tempImageFiles = [];

    switch (pickerType) {
      case "image_gallery":

        /// GALLERY IMAGE PICKER
        tempImageFiles = (await ImagePicker().getMultiImage(imageQuality: 90))!;

        break;

      case "image_camera":

        /// CAMERA CAPTURE CODE
        tempImageFiles.add((await ImagePicker()
            .getImage(source: ImageSource.camera, imageQuality: 90))!);

        break;
      case "video_camera":

        /// CAMERA CAPTURE CODE
        videoFile = (await ImagePicker().getVideo(
            source: ImageSource.camera, maxDuration: Duration(seconds: 10)))!;

        break;

      case "video_gallery":

        /// CAMERA CAPTURE CODE
        videoFile = (await ImagePicker().getVideo(
            source: ImageSource.gallery, maxDuration: Duration(seconds: 10)))!;

        break;
    }

    if (videoFile == null) {
      for (int i = 0; i < tempImageFiles.length; i++) {
        if (availableImagesCount() < imagesLimit) {
          debugPrint("You selected  image : " + tempImageFiles[i].path);
          setState(() {
            debugPrint("SELECTED IMAGE PICK   ${tempImageFiles[i]}");

            imageFiles.insert(availableImagesCount(), tempImageFiles[i].path);
            print("imageFilessss2[i] : $i = ${imageFiles[i]}");
          });
        } else {
          debugPrint("images limit is $imagesLimit");
          break;
        }
      }
    } else {
      File videoThumbnail = await generateThumbnailFile(videoFile!.path);
      setState(() {
        //if (imageFiles[0]) {
        //imageFiles.add(videoThumbnail.path);
        //} else {
        print("\nvideoFile.path : " + videoFile!.path);
        imageFiles.insert(0, videoThumbnail.path);
        //}
        //videoUploaded = true;
      });
    }
    //print("imageFiles length ${availableImagesCount()}");
  }

  removeImageFile(int i) {
    setState(() {
      imageFiles.removeAt(i);

      //imageFiles.insert(i, "");
      imageFiles.add("");
      if (i == 0 && (videoFile != null)) videoFile = null;
    });
  }

  void setEmptyImages() {
    for (int i = 0; i < imagesLimit; i++) {
      imageFiles.add("");
    }
  }

  availableImagesCount() {
    int count = 0;
    for (int i = 0; i < imageFiles.length; i++) {
      if (imageFiles[i] != "") count++;
    }
    print("count : $count");
    return count;
  }

  void moveEmptyImagesAtTheEnd() {
    List<String> imageFilesTemp = imageFiles;
    imageFilesTemp.removeWhere((item) => item == "");
    int startIndex = availableImagesCount();
    print("startIndex $startIndex , imagesLimit $imagesLimit");
    for (int i = startIndex; i < imagesLimit; i++) {
      imageFilesTemp.add("");
    }
    setState(() {
      imageFiles = imageFilesTemp;
    });
  }

  uploadImageFiles(BuildContext context) {
    EasyLoading.show(
        status: 'Please wait', maskType: EasyLoadingMaskType.black);

    APIService apiservice = APIService();

    List<String> files = [];

    bool videoUploaded = false;

    for (int i = 0; i < availableImagesCount(); i++) {
      print("\nimageFile $i : " + imageFiles[i]);

      if (i == 0 && (videoFile != null)) {
        files.add(videoFile!.path);
        videoUploaded = true;
      } else {
        files.add(imageFiles[i]);
      }
    }

    apiservice
        .uploadImageFiles(videoUploaded, files, context, true)
        .then((value) => {
              if (value != null && value)
                {
                  EasyLoading.dismiss(),
                  widget.fetchCurrentLoggedInUserDetail(),
                  showInSnackBar("Files saved successfully", context),
                }
              else
                {
                  EasyLoading.dismiss(),
                  throw Exception(),
                }
            })
        .catchError((error, stackTrace) {
      print("error : $error");
      print("stackTrace : $stackTrace");
      EasyLoading.dismiss();
      //showInSnackBar("Something went wrong", context);
    });
  }

  void fetchUserImages() {
    EasyLoading.show(
        status: 'Please wait', maskType: EasyLoadingMaskType.black);
    APIService apiservice = APIService();

    apiservice
        .getUserImages(context, true)
        .then((userImages) => {
              if (userImages != null &&
                  userImages.list != null &&
                  userImages.list!.length > 0)
                {
                  print("list : ${userImages.list.toString()}"),
                  print("imagesLimit : ${imagesLimit}"),
                  setImageFiles(userImages.list),
                }
              else
                {
                  EasyLoading.dismiss(),
                  throw Exception(),
                }
            })
        .catchError((error, stackTrace) {
      EasyLoading.dismiss();
      //showInSnackBar("Something went wrong", context);
    });
  }

  setImageFiles(List<UserImageModel>? list) async {
    int count = 0;
    APIService apiService = APIService();
    for (UserImageModel item in list!) {
      String path = await filePathFromImageUrl(item.image_url, item.file_name);

      String extension = item.file_name.substring(item.file_name.length - 4);

      if (count == 0 && extension == ".mp4") {
        File videoThumbnail = await generateThumbnailFile(path);
        imageFiles.insert(count++, videoThumbnail.path);
        videoFile = PickedFile(path);
      } else {
        imageFiles.insert(count++, path);
      }
    }
    setState(() {
      print("image files : " + imageFiles.toString());
    });
    EasyLoading.dismiss();
  }
}
