import 'package:spisymobile_test/app/config/function_utils.dart';

class UserModel {
  UserModel({
    required this.uuid,
    required this.name,
    required this.birthDate,
    this.age = 0,
    required this.gender,
    required this.address,
  });
  String uuid;
  String name;
  DateTime birthDate;
  int age;
  String address;

  //* true for male
  bool gender;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final bd = DateTime.parse(json['birth_date']);
    final age = calcAge(bd);
    return UserModel(
      uuid: json['id'],
      name: json['name'],
      gender: json['gender'] == 1 ? true : false,
      address: json['address'],
      age: age,
      birthDate: bd,
    );
  }

  factory UserModel.init() => UserModel(
        uuid: '',
        address: '',
        birthDate: DateTime.now(),
        gender: true,
        name: '',
        age: 0,
      );

  toJson() => {
        'id': uuid,
        'name': name,
        'gender': gender,
        // 'birth_date': dateFormater(birthDate),
        'birth_date': birthDate.toString(),
        'age': age,
        'address': address,
      };
}
