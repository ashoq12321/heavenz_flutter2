import 'package:heavenz/common_functions.dart/common_functions.dart';
import 'package:heavenz/screens/user_profile/user_profile.dart';

class UserSettings {
  List<UserSettingModel>? list;
  UserSettings({this.list});

  @override
  String toString() {
    return 'UserSettings(data: $list)';
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        list: (json['data'] as List<dynamic>?)
            ?.map((e) => UserSettingModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  /*Map<String, dynamic> toJson() => {
        'data': 
      };*/

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = list?.map((e) => e.toJson()).toList();
    return data;
  }
}

class UserSettingModel {
  late String categoryName;
  late GENDER gender;
  late String ageStart;
  late String ageEnd;
  late String distance;
  late bool showProfile;
  late bool onlineVisibility;
  late bool lastSeen;

  UserSettingModel({
    required this.categoryName,
    required this.gender,
    required this.ageStart,
    required this.ageEnd,
    required this.distance,
    required this.showProfile,
    required this.onlineVisibility,
    required this.lastSeen,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = categoryName;
    data['gender'] = getGenderAsString(gender);
    data['age_start'] = ageStart;
    //int.parse(ageStart);
    data['age_end'] = ageEnd; //int.parse(ageEnd);
    data['distance'] = distance; //int.parse(distance);
    data['show_profile'] = showProfile.toString();
    //showProfile;
    data['online_visibility'] = onlineVisibility.toString();
    // onlineVisibility;
    data['last_seen'] = lastSeen.toString();
    //lastSeen;
    //print("data : " + data.toString());
    return data;
  }

  factory UserSettingModel.fromJson(Map<String, dynamic> json) {
    return UserSettingModel(
      categoryName: json['category_name'],
      gender: getGenderAsEnum(json['gender'].toString()),
      ageStart: json['age_start'].toString(),
      ageEnd: json['age_end'].toString(),
      distance: json['distance'].toString(),
      showProfile: toBoolean(json['show_profile'].toString()),
      onlineVisibility: toBoolean(json['online_visibility'].toString()),
      lastSeen: toBoolean(json['last_seen'].toString()),
    );
  }
}
