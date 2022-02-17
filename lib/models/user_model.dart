class HomeModel {
  bool? status;
  String? message;
  UserModel? data;
  HomeModel.fromjeson({required Map<String, dynamic> jeson}) {
    status = jeson['status'];
    message = jeson['msg'];
    data = (status == true) ? UserModel.fromjeson(jeson: jeson['user']) : null;
  }
}

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? image;
  String? gender;
  int? age;
  String? phone;
  UserModel.fromjeson({required Map<String, dynamic> jeson}) {
    id = jeson['id'];
    firstName = jeson['firstname'];
    lastName = jeson['lastname'];
    image = jeson['photo'];
    age = jeson['age'];
    gender = jeson['gender'];
    phone = jeson['phone'];
  }
}
