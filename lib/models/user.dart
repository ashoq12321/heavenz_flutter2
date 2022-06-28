class User {
  String? first_name;
  String? last_name;
  String? profile_pic_url;
  int? profile_percentage;
  String? email;
  String? password;
  String? dob;
  String? gender;
  String? profession;
  String? about_me;
  String? mobile;
  String? email_visibility;
  String? mobile_visibility;
  String? created_at;
  String? updated_at;

  User({
    this.first_name,
    this.last_name,
    this.profile_pic_url,
    this.profile_percentage,
    this.email,
    this.password,
    this.dob,
    this.gender,
    this.profession,
    this.about_me,
    this.mobile,
    this.email_visibility,
    this.mobile_visibility,
    this.created_at,
    this.updated_at,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['profile_pic_url'] = profile_pic_url ?? "";
    data['profile_percentage'] = profile_percentage ?? "";
    data['email'] = email;
    data['password'] = password;
    data['dob'] = dob;
    data['gender'] = gender;
    data['profession'] = profession;
    data['about_me'] = about_me;
    data['mobile'] = mobile;
    data['email_visibility'] = email_visibility;
    data['mobile_visibility'] = mobile_visibility;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;

    return data;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      first_name: json['first_name'],
      last_name: json['last_name'],
      profile_pic_url: json['profile_pic_url'],
      profile_percentage: json['profile_percentage'],
      email: json['email'],
      password: json['password'],
      dob: json['dob'],
      gender: json['gender'],
      profession: json['profession'],
      about_me: json['about_me'],
      mobile: json['mobile'],
      email_visibility: json['email_visibility'],
      mobile_visibility: json['mobile_visibility'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}
