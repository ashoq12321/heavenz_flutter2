class UserImages {
  List<UserImageModel>? list;
  UserImages({this.list});

  @override
  String toString() {
    return 'UserImages(list: $list)';
  }

  factory UserImages.fromJson(Map<String, dynamic> json) => UserImages(
        list: (json['data'] as List<dynamic>?)
            ?.map((e) => UserImageModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class UserImageModel {
  late String file_name;
  late int image_index;
  late String image_url;

  UserImageModel({
    required this.file_name,
    required this.image_index,
    required this.image_url,
  });

  factory UserImageModel.fromJson(Map<String, dynamic> json) {
    return UserImageModel(
      file_name: json['file_name'],
      image_index: json['image_index'],
      image_url: json['image_url'],
    );
  }
}
