import 'package:insulin/sharedpreference/shared.dart';

class SharedData {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String? gender;
  int? age;
  String? phone;
  String? email;
  String? password;

  SharedData() {
    getData();
  }
  getData() async {
    email = await CachHelper.getData('email');
    id = await CachHelper.getData('id');

    firstName = await CachHelper.getData('first');
    lastName = await CachHelper.getData('last');
    image = await CachHelper.getData('image');
    gender = await CachHelper.getData('gender');
    age = await CachHelper.getData('age');
    phone = await CachHelper.getData('phone');

    password = await CachHelper.getData('password');
  }
}
