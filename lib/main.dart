import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/constants.dart';
import 'package:insulin/cubit/cubit.dart';
import 'package:insulin/cubit/status.dart';
import 'package:insulin/models/user_model.dart';
import 'package:insulin/network/remote.dart';
import 'package:insulin/pages/Home.dart';
import 'package:insulin/pages/Homepage.dart';
import 'package:insulin/pages/login.dart';
import 'package:insulin/pages/signup.dart';
import 'package:insulin/pages/welcomepage.dart';
import 'package:insulin/sharedpreference/shared.dart';
import 'package:insulin/sharedpreference/sharedData.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CachHelper.inti();
  SharedData data = await SharedData();
  runApp(MyApp(
    data: data,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.data}) : super(key: key);
  final SharedData data;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          cubit = AppCubit.get(context);
          if (data.email != null && data.email != '') {
            cubit!.currentUser = HomeModel.fromjeson(jeson: {
              'status': true,
              'msg': '',
              'user': {
                'id': data.id,
                'firstname': data.firstName,
                'lastname': data.lastName,
                'age': data.age,
                'photo': data.image,
                'gender': data.gender,
                'phone': data.phone
              }
            });
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: (data.email != null && data.email!.length > 0)
                ? Home()
                : Welcome(),
            routes: {
              'home': (context) => Home(),
              'homepage': (context) => Homepage(),
              'login': (context) => Login(),
              'welcome': (context) => Welcome(),
              'signup': (context) => Signup(),
            },
          );
        },
      ),
    );
  }
}
