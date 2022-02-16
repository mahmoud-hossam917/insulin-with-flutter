import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/cubit/status.dart';
import 'package:insulin/network/remote.dart';

class AppCubit extends Cubit<Status> {
  AppCubit() : super(intiState());

  static AppCubit get(context) => BlocProvider.of(context);
  int? indexPage = 0;
  String type = 'Gender';
  GlobalKey<FormState> formKey = GlobalKey();
  ChangePage(index) {
    indexPage = index;
    emit(ChangePageState());
  }

  SignUp(
      {required List Doses,
      required String firstname,
      required String lastname,
      required String email,
      required String password,
      required String phone,
      required int age,
      required bool gender,
      required String photo,
      required birthdate}) async {
    emit(SignLoadingState());
    await DioHelper.postData(
        url: 'http://smartinsulin-001-site1.itempurl.com/api/users',
        data: {
          'Doses': Doses,
          'firstname': firstname,
          'lastname': lastname,
          'email': email,
          'password': password,
          'phone': phone,
          'age': age,
          'gender': gender,
          'photo': photo,
          'birthdate': birthdate,
        }).then((value) {
      emit(SignSuccessState());
      print(value.data);
    }).catchError((onError) {
      emit(SignErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  changeGender(gender) {
    type = gender;
    emit(ChangeType());
  }

  login({required String email, required String password}) async {
    emit(loginLoadingState());
    await DioHelper.getData(
        url:
            'https://localhost:44307/api/users/checkpassword?email=a@a.com&password=123456',
        data: {'email': email, 'password': password}).then((value) {
      emit(loginSuccessState());
      print(value.data);
    }).catchError((onError) {
      emit(loginErrorState(onError));
      print(onError.toString());
    });
  }
}
