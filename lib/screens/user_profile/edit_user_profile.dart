import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:heavenz/api/api_service.dart';
import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:heavenz/constants/color_constants.dart';
import 'package:heavenz/models/user.dart';
import 'package:heavenz/widgets/app_button.dart';
import 'package:heavenz/widgets/custom_dob_field.dart';
import 'package:heavenz/widgets/custom_dropdown/DropListModel.dart';
import 'package:heavenz/widgets/custom_dropdown/custom_drop_list.dart';
import 'package:heavenz/widgets/custom_text_field.dart';
import 'package:heavenz/widgets/custom_toggle_switch.dart';
import 'package:intl/intl.dart';

class EditUserProfile extends StatefulWidget {
  const EditUserProfile(
      {Key? key,
      required this.onBackPressed,
      required this.moveToInitialUserProfileScreen,
      required this.fetchCurrentLoggedInUserDetail})
      : super(key: key);

  final onBackPressed;
  final moveToInitialUserProfileScreen;
  final fetchCurrentLoggedInUserDetail;

  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  FocusScopeNode? node;
  bool emailVisibility = false;
  bool mobileNumberVisibility = false;
  bool mobileVisibilitySwitchDisabled = true;

  DropListModel genderDropListModel = DropListModel([
    OptionItem(id: "1", title: "Male"),
    OptionItem(id: "2", title: "Female"),
  ]);
  OptionItem genderOptionItemSelected = OptionItem(id: "-1", title: "Gender");

  DropListModel professionDropListModel = DropListModel([
    OptionItem(id: "1", title: "Student"),
    OptionItem(id: "2", title: "Salaried"),
    OptionItem(id: "3", title: "Self Employed"),
    OptionItem(id: "4", title: "Business"),
  ]);
  OptionItem professionOptionItemSelected =
      OptionItem(id: "-1", title: "Profession");

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final pwdController = TextEditingController();
  final confirmPwdController = TextEditingController();
  final locationController = TextEditingController();
  final dobController = TextEditingController();
  final aboutController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  DateTime? dob = null;

  setEmailVisibily(bool value) {
    setState(() {
      emailVisibility = value;
    });
  }

  setMobileNumberVisibily(bool value) {
    setState(() {
      mobileNumberVisibility = value;
    });
  }

  @override
  void initState() {
    fetchUserDeatils();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    pwdController.dispose();
    confirmPwdController.dispose();
    dobController.dispose();
    locationController.dispose();
    aboutController.dispose();
    emailController.dispose();
    mobileController.dispose();
    //genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    node = FocusScope.of(context);
    return WillPopScope(
      onWillPop: widget.onBackPressed,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: CustomTextField(
                            hint: "First Name",
                            showValidCheck: true,
                            maxlines: 1,
                            isLast: false,
                            // suffixIcon: "images/ic_menu.png",
                            onEditingComplete: () => node?.nextFocus(),
                            onSaved: (value) {
                              debugPrint("first name $value");
                              //profile.surname = value;
                            },
                            textEditingController: firstNameController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: CustomTextField(
                            hint: "Last Name",
                            showValidCheck: true,
                            maxlines: 1,
                            isLast: false,
                            // suffixIcon: "images/ic_menu.png",
                            onEditingComplete: () => node?.nextFocus(),
                            onSaved: (value) {
                              debugPrint("last name $value");
                              //profile.surname = value;
                            },
                            textEditingController: lastNameController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: CustomTextField(
                                    hint: "Email",
                                    enabled: false,
                                    keyboardType: TextInputType.emailAddress,
                                    showValidCheck: true,
                                    maxlines: 1,
                                    isLast: false,
                                    onEditingComplete: () => node?.nextFocus(),
                                    onSaved: (value) {
                                      debugPrint("Email $value");
                                    },
                                    textEditingController: emailController,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: CustomToggleSwitch(
                                  bgColor: ColorConstants.appGreen,
                                  scaleSize: 1.0,
                                  switchValue: emailVisibility,
                                  onChanged: setEmailVisibily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: CustomTextField(
                            hint: "Password",
                            showValidCheck: true,
                            maxlines: 1,
                            isLast: false,
                            isPassword: true,
                            // suffixIcon: "images/ic_menu.png",
                            onEditingComplete: () => node?.nextFocus(),
                            onSaved: (value) {
                              debugPrint("password $value");
                              //profile.surname = value;
                            },
                            textEditingController: pwdController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: CustomTextField(
                            hint: "Confirm Password",
                            showValidCheck: true,
                            isPassword: true,
                            maxlines: 1,
                            isLast: false,
                            // suffixIcon: "images/ic_menu.png",
                            onEditingComplete: () => node?.nextFocus(),
                            onSaved: (value) {
                              debugPrint("name $value");
                              //profile.surname = value;
                            },
                            textEditingController: confirmPwdController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: CustomTextField(
                            hint: "Location",
                            maxlines: 1,
                            showValidCheck: true,
                            suffixIcon: "images/icon_location_green.png",
                            onEditingComplete: () => node?.nextFocus(),
                            onSaved: (value) {
                              debugPrint("location $value");
                              //profile.surname = value;
                            },
                            textEditingController: locationController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: CustomDropList(
                                    dropListModel: genderDropListModel,
                                    itemSelected: genderOptionItemSelected,
                                    onOptionSelected: (OptionItem optionItem) {
                                      genderOptionItemSelected = optionItem;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  node?.unfocus();
                                  print("object");
                                  pickDateOfBirth(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.48,
                                    child: CustomDOBField(
                                      suffixIcon: "images/ic_dropdown.png",
                                      dobText: dobController.text == ""
                                          ? "DOB"
                                          : dobController.text,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: CustomTextField(
                            hint: "About Me",
                            maxlines: 20,
                            keyboardType: TextInputType.multiline,
                            containerHeight: 117.0,
                            showValidCheck: true,
                            onEditingComplete: () => node?.nextFocus(),
                            onSaved: (value) {
                              debugPrint("About Me $value");
                            },
                            textEditingController: aboutController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: CustomDropList(
                            dropListModel: professionDropListModel,
                            itemSelected: professionOptionItemSelected,
                            onOptionSelected: (OptionItem optionItem) {
                              professionOptionItemSelected = optionItem;
                              setState(() {});
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: CustomTextField(
                                    hint: "Mobile No",
                                    showValidCheck: true,
                                    keyboardType: TextInputType.phone,
                                    maxlines: 1,
                                    isLast: false,
                                    onEditingComplete: () {
                                      node?.unfocus();
                                      setState(() {
                                        mobileVisibilitySwitchDisabled = false;
                                      });
                                    },
                                    onSaved: (value) {
                                      debugPrint("Mobile No $value");
                                    },
                                    textEditingController: mobileController,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: AbsorbPointer(
                                  absorbing: mobileVisibilitySwitchDisabled,
                                  child: CustomToggleSwitch(
                                    bgColor: ColorConstants.appGreen,
                                    scaleSize: 1.0,
                                    switchValue: mobileNumberVisibility,
                                    onChanged: setMobileNumberVisibily,
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                //constraints: BoxConstraints(maxWidth: 314.0),
                child: AppButton(
                  bgColor: ColorConstants.appGreen,
                  borderRadius: 8.0,
                  fontFamily: 'Poppins',
                  fontSize: 20.0,
                  onPressed: () {
                    EasyLoading.show(
                        status: 'Please wait',
                        maskType: EasyLoadingMaskType.black);
                    node?.unfocus();
                    if (validateEditProfileForm(context)) {
                      print(
                          "firstNameController : ${firstNameController.text} \nlastNameController : ${lastNameController.text} \npwdController : ${pwdController.text} \nconfirmPwdController : ${confirmPwdController.text} \ndob : ${dob} \nlocationController : ${locationController.text} \naboutController : ${aboutController.text}\nemailController : ${emailController.text}\nmobileController : ${mobileController.text} \ngenderOptionItemSelected : ${genderOptionItemSelected.title} \nprofessionOptionItemSelected : ${professionOptionItemSelected.title}");
                      print("saveeee");

                      updateUserDetails(context);
                    } else {
                      EasyLoading.dismiss();
                    }
                  },
                  title: 'SAVE',
                  textColor: Colors.white,
                  height: 52,
                  //borderColor: ColorConstants.appGrey,
                ),
              ),
            ],
          ),
        ),

        //
      ),
    );
  }

  pickDateOfBirth(BuildContext context) async {
    if (dob == null) {
      dob = DateTime(
          DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
    }

    if (dob != null) {
      final DateTime? pickedDateOfBirth = await showDatePicker(
        context: context,
        initialDate: dob!,
        firstDate: DateTime(1900, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(
            DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
      );
      if (pickedDateOfBirth == null)
        dobController.text = DateFormat('MMM dd, yyyy').format(dob!);
      else
        dobController.text =
            DateFormat('MMM dd, yyyy').format(pickedDateOfBirth);

      if (pickedDateOfBirth != null) dob = pickedDateOfBirth;
    }
    setState(() {});
  }

  bool validateEditProfileForm(BuildContext context) {
    if (firstNameController.text == "") {
      showInSnackBar("First Name should not be empty", context);
      return false;
    } else if (firstNameController.text.length > 20) {
      showInSnackBar("First Name is too long", context);
      return false;
    } else if (lastNameController.text == "") {
      showInSnackBar("Last Name should not be empty", context);
      return false;
    } else if (lastNameController.text.length > 20) {
      showInSnackBar("Last Name is too long", context);
      return false;
    } else if (pwdController.text == "") {
      showInSnackBar("Please enter password", context);
      return false;
    } else if (pwdController.text.length < 8) {
      showInSnackBar("Password should be atleast 8 characters", context);
      return false;
    } else if (pwdController.text.length > 40) {
      showInSnackBar("Password should not exceed 40 characters", context);
      return false;
    } else if (pwdController.text.contains(' ')) {
      showInSnackBar("Password should not contain space", context);
      return false;
    } else if (confirmPwdController.text == "") {
      showInSnackBar("Please confirm password", context);
      return false;
    } else if (confirmPwdController.text.length < 8) {
      showInSnackBar(
          "Confirm password should be atleast 8 characters", context);
      return false;
    } else if (confirmPwdController.text.length > 40) {
      showInSnackBar(
          "Confirm password should not exceed 40 characters", context);
      return false;
    } else if (confirmPwdController.text.contains(' ')) {
      showInSnackBar("Confirm password should not contain space", context);
      return false;
    } else if (pwdController.text != confirmPwdController.text) {
      showInSnackBar("Passwords should not be diffrent", context);
      return false;
    } else if (genderOptionItemSelected.title == "Gender") {
      showInSnackBar("Pick your Gender", context);
      return false;
    } else if (dob == null) {
      showInSnackBar("Pick your date of birth", context);
      return false;
    } else if (!isMobileNumberValid(mobileController.text)) {
      showInSnackBar("Please enter valid mobile number", context);
      return false;
    } /*else if (emailController.text == "") {
      showInSnackBar("Email should not be empty", context);
      return false;
    } else if (emailController.text.length > 40 ||
        !emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      showInSnackBar("Email should be vaild", context);
      return false;
    }*/
    /*else if (professionOptionItemSelected.title == "Profession") {
      showInSnackBar("Pick your Profession", context);
      return false;
    }*/
    return true;
  }

  void updateUserDetails(BuildContext context) {
    APIService apiservice = APIService();
    User user = User(
      first_name: firstNameController.text,
      last_name: lastNameController.text,
      email: emailController.text,
      password: pwdController.text,
      dob: dob.toString(),
      gender: genderOptionItemSelected.title,
      profession: professionOptionItemSelected.title == "Profession"
          ? ""
          : professionOptionItemSelected.title,
      about_me: aboutController.text,
      mobile: mobileController.text,
      email_visibility: emailVisibility.toString(),
      mobile_visibility: mobileNumberVisibility.toString(),
      created_at: "",
      updated_at: "",
    );

    apiservice
        .updateUser(user, context, true)
        .then((value) => {
              if (value != null && value)
                {
                  EasyLoading.dismiss(),
                  widget.fetchCurrentLoggedInUserDetail(),
                  widget.moveToInitialUserProfileScreen(),
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

  void fetchUserDeatils() {
    EasyLoading.show(
        status: 'Please wait', maskType: EasyLoadingMaskType.black);
    APIService apiservice = APIService();

    apiservice
        .getUserDetails(context, false, true)
        .then((user) => {
              if (user != null)
                {
                  print("user : " + user.first_name.toString()),
                  firstNameController.text = user.first_name.toString(),
                  lastNameController.text = user.last_name.toString(),
                  emailController.text = user.email.toString(),
                  pwdController.text = user.password.toString(),
                  confirmPwdController.text = user.password.toString(),
                  print("\nuser.dob.toString() : ${user.dob.toString()}"),
                  dob = DateTime.parse(user.dob.toString()),
                  dobController.text = DateFormat('MMM dd, yyyy').format(dob!),
                  aboutController.text =
                      (user.about_me == null || user.about_me == "")
                          ? ""
                          : user.about_me.toString(),
                  mobileController.text =
                      (user.mobile == null || user.mobile == "")
                          ? ""
                          : user.mobile.toString(),
                  for (int i = 0;
                      i < genderDropListModel.listOptionItems.length;
                      i++)
                    {
                      print("genderDropListModel.listOptionItems[i].title : " +
                          genderDropListModel.listOptionItems[i].title),
                      print(
                          "user.gender.toString() : " + user.gender.toString()),
                      if (genderDropListModel.listOptionItems[i].title
                              .toString() ==
                          user.gender.toString())
                        {
                          genderOptionItemSelected =
                              genderDropListModel.listOptionItems[i],
                          print("genderOptionItemSelectedd : " +
                              genderOptionItemSelected.title)
                        }
                    },
                  for (int i = 0;
                      i < professionDropListModel.listOptionItems.length;
                      i++)
                    {
                      if (professionDropListModel.listOptionItems[i].title
                              .toString() ==
                          user.profession.toString())
                        {
                          professionOptionItemSelected =
                              professionDropListModel.listOptionItems[i],
                        }
                    },
                  if (user.mobile.toString() != null &&
                      user.mobile.toString() != "")
                    mobileVisibilitySwitchDisabled = false,
                  emailVisibility = toBoolean(user.email_visibility.toString()),
                  mobileNumberVisibility =
                      toBoolean(user.mobile_visibility.toString()),
                  setState(() {}),
                  EasyLoading.dismiss(),
                }
              else
                {
                  print("user : " + user.toString()),
                  EasyLoading.dismiss(),
                  throw Exception(),
                }
            })
        .catchError((error, stackTrace) {
      EasyLoading.dismiss();
      //showInSnackBar("Something went wrong", context);
    });
  }
}
