class SignupModel {
  String? first_name;
  String? last_name;
  String? email;
  String? password;
  String? dob;
  String? gender;
  String? email_visibility;
  String? mobile_visibility;

  SignupModel({
    this.first_name,
    this.last_name,
    this.email,
    this.password,
    this.dob,
    this.gender,
    this.email_visibility,
    this.mobile_visibility,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['email'] = email;
    data['password'] = password;
    data['dob'] = dob;
    data['gender'] = gender;
    data['email_visibility'] = email_visibility;
    data['mobile_visibility'] = mobile_visibility;

    return data;
  }

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      first_name: json['first_name'],
      last_name: json['last_name'],
      email: json['email'],
      password: json['password'],
      dob: json['dob'],
      gender: json['gender'],
      email_visibility: json['email_visibility'],
      mobile_visibility: json['mobile_visibility'],
    );
  }
}
