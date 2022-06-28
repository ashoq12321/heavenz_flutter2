class SigninModel {
  String? email;
  String? password;

  SigninModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;

    return data;
  }

  factory SigninModel.fromJson(Map<String, dynamic> json) {
    return SigninModel(
      email: json['email'],
      password: json['password'],
    );
  }
}
