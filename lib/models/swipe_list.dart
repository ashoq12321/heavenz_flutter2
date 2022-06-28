import 'package:heavenz/models/view_person.dart';

class SwipeList {
  List<ViewPerson>? list;
  int offset;
  bool find_more;
  SwipeList({this.list, required this.offset, required this.find_more});

  @override
  String toString() {
    return 'SwipeList(data: $list)';
  }

  factory SwipeList.fromJson(Map<String, dynamic> json) => SwipeList(
        list: (json['data'] as List<dynamic>?)
            ?.map((e) => ViewPerson.fromJson(e as Map<String, dynamic>))
            .toList(),
        offset: json['offset'] as int,
        find_more: json['find_more'],
      );
}
