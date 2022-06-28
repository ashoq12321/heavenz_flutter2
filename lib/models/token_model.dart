class TokenModel {
  bool? success;
  String? accessToken;
  String? refreshToken;

  TokenModel({
    this.success,
    this.accessToken,
    this.refreshToken,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;

    return data;
  }

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      success: json['success'],
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}
