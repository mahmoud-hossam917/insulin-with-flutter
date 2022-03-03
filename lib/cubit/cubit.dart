import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/constants.dart';
import 'package:insulin/cubit/status.dart';
import 'package:insulin/models/dosemodel.dart';
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
  DoseModel? Doeses;
  HomeModel? currentUser;
  TimeOfDay time = TimeOfDay.now();
  TimeOfDay? picked;
  ChangePage(index) {
    indexPage = index;
    emit(ChangePageState());
  }

  selectTime() {
    emit(GetTime());
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

  addDose({required String time, required String dose, required userID}) async {
    emit(LoadingDose());
    await DioHelper.postData(url: DOSE, data: {
      'amount': dose,
      'datetime': time,
      'userid': userID,
      'taken': false
    }).then((value) {
      print(value.data);
      emit(AddDose());
      print(value.data);
    }).catchError((onError) {
      emit(AddDoseError(onError.toString()));
    });
  }

  GetAllDoses({required int userID}) async {
    emit(LoadingDose());
    await DioHelper.getData(url: userDoses, data: {'userid': userID})
        .then((value) {
      print(value.data);
      Doeses = DoseModel.fromjeson(value.data);
      emit(GetDosesSuccessfully());
    }).catchError((onError) {
      emit(GetDosesError(onError.toString()));
    });
  }

  DeleteDose({required int id}) async {
    emit(LoadingDeleteDose());
    await DioHelper.deleteData(url: DeleteDOSE, data: {'id': id}).then((value) {
      for (int i = 0; i < Doeses!.Doses.length; i++) {
        if (Doeses!.Doses[i].doseID == id) {
          Doeses!.Doses.remove(Doeses!.Doses[i]);
        }
      }
      emit(SuccessDeleteDose());
    }).catchError((onError) {
      emit(ErrorDeleteDose(onError.toString()));
    });
  }

  UpdateDose(
      {required String time, required int dose, required int index}) async {
    print(Doeses!.Doses[index].doseID);
    emit(LoadingUpdateDose());
    await DioHelper.postData(url: UpdateDOSE, data: {
      'id': Doeses!.Doses[index].doseID,
      'amount': dose,
      'datetime': time,
      'taken': Doeses!.Doses[index].isTaken,
      'userid': Doeses!.Doses[index].userID
    }).then((value) {
      emit(SuccessUpdateDose());
    }).catchError((onError) {
      emit(ErrorUpdateDose(onError.toString()));
    });
  }
}
