import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/constants.dart';
import 'package:insulin/cubit/status.dart';
import 'package:insulin/models/user_model.dart';
import 'package:insulin/network/remote.dart';
import 'package:insulin/pages/Home.dart';
import 'package:insulin/pages/Homepage.dart';
import 'package:insulin/pages/history.dart';
import 'package:insulin/pages/settings.dart';
import 'package:insulin/pages/statistcs.dart';
import 'package:insulin/sharedpreference/shared.dart';

class AppCubit extends Cubit<Status> {
  AppCubit() : super(intiState());

  static AppCubit get(context) => BlocProvider.of(context);
  int? indexPage = 0;
  List pages = [Homepage(), Statistics(), History(), Settings()];
  String type = 'Gender';
  GlobalKey<FormState> formKey = GlobalKey();
  List<Map<String, dynamic>>? dataTable = [
    {'time': '', 'dose': '', 'check': ''},
    {'time': '', 'dose': '', 'check': ''},
    {'time': '', 'dose': '', 'check': ''},
    {'time': '', 'dose': '', 'check': ''}
  ];
  HomeModel? currentUser;
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
            'http://smartinsulin-001-site1.itempurl.com/api/users/checkpassword',
        data: {'email': email, 'password': password}).then((value) {
      emit(loginSuccessState());
      currentUser = HomeModel.fromjeson(jeson: value.data);
      CachHelper.putData('email', email);
      CachHelper.putData('password', password);
      CachHelper.putData('first', currentUser!.data!.firstName);
      CachHelper.putData('last', currentUser!.data!.lastName);
      CachHelper.putData('id', currentUser!.data!.id);
      CachHelper.putData('phone', currentUser!.data!.phone);
      CachHelper.putData('age', currentUser!.data!.age);
      CachHelper.putData('image', currentUser!.data!.image);
      CachHelper.putData('gender', currentUser!.data!.gender);
    }).catchError((onError) {
      emit(loginErrorState(onError));
      print(onError.toString());
    });
  }

  addDose({required String time, required String dose}) {
    for (int i = 0; i < 3; i++) {
      if (dataTable?[i]['time'] == '') {
        dataTable![i]['time'] = time;
        dataTable![i]['dose'] = dose;
        emit(AddDose());
        return true;
      }
    }
    return false;
  }

  addDose2(
      {required String time, required String dose, required userID}) async {
    emit(LoadingDose());
    await DioHelper.postData(url: DOSE, data: {
      'amount': dose,
      'datetime': time,
      'userid': userID,
      'taken': false
    }).then((value) {
      emit(AddDose());
    }).catchError((onError) {
      emit(AddDoseError(onError.toString()));
    });
  }

  GetAllDoses({required int userID}) async {
    emit(LoadingDose());
    await DioHelper.getData(url: userDoses, data: {'userid': userID})
        .then((value) {
      print(value.data);
      emit(GetDosesSuccessfully());
    }).catchError((onError) {
      emit(GetDosesError(onError.toString()));
    });
  }

  editDose(
      {required String time,
      required String dose,
      required bool check,
      required int index}) {
    dataTable?[index]['time'] = time;
    dataTable?[index]['dose'] = dose;
    dataTable?[index]['check'] = check;
    emit(EditDose());
  }

  deleteDose({required int index}) {
    for (int i = index; i < 3; i++) {
      dataTable?[i]['time'] = dataTable?[i + 1]['time'];
      dataTable?[i]['dose'] = dataTable?[i + 1]['dose'];
      dataTable?[i]['check'] = dataTable?[i + 1]['check'];
    }
    emit(DeleteDose());
  }
}
