import 'package:heavenz/api/api_service.dart';
import 'package:intl/intl.dart';

class ViewPerson {
  late int? id;
  late String name;
  late String sex;
  late String dob;
  late String age;
  late String address;
  late String? about_me;
  late String imageString;

  ViewPerson(
      {this.id,
      required this.name,
      required this.sex,
      required this.dob,
      required this.age,
      required this.address,
      this.about_me,
      required this.imageString});

  @override
  String toString() {
    return '[id: $id, name: $name, sex: $sex, dob: $dob, age: $age, address: $address, imageString: $imageString, about_me: $about_me]';
  }

  factory ViewPerson.fromJson(Map<String, dynamic> json) {
    return ViewPerson(
      id: json['id'],
      name: json['first_name'] + " " + json['last_name'],
      sex: json['gender'],
      dob: DateFormat('MM/dd/yyyy')
          .format(DateTime.parse(json['dob']))
          .toString(),
      age: json['age'].toString(),
      address: "Chennai, Tamil nadu, India",
      about_me: json['about_me'],
      imageString: APIService.base_url + "/files/" + json['profile_pic'],
    );
  }
}
