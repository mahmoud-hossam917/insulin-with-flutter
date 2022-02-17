import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/constants.dart';
import 'package:insulin/cubit/cubit.dart';
import 'package:insulin/cubit/status.dart';
import 'package:insulin/pages/Home.dart';
import 'package:insulin/pages/signup.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, Status>(
          listener: (context, state) {},
          builder: (context, state) {
            cubit = AppCubit.get(context);
            var email, password;
            return ModalProgressHUD(
              inAsyncCall: state is loginLoadingState,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: height * .4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                        color: Colors.blue.shade800,
                                        width: 3))),
                          ],
                        ),
                      ),
                      Form(
                          key: cubit?.formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val != null && val.length == 0 ||
                                        val == null)
                                      return 'Please Enter email';
                                  },
                                  onSaved: (val) {
                                    email = val;
                                  },
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Colors.black),
                                    suffixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: TextFormField(
                                  validator: (val) {
                                    if (val != null && val.length < 6 ||
                                        val == null)
                                      return 'password must be than 5 digits';
                                  },
                                  onSaved: (val) {
                                    password = val;
                                  },
                                  obscureText: true,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: Colors.black),
                                    suffixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                  ),
                                ),
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forget Your Password ?',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 160,
                                    child: Image.asset(
                                      'images/login.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                  SizedBox(width: 60),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 90),
                                    child: SizedBox(
                                      width: 120,
                                      height: 45,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.blueAccent.shade700,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        onPressed: () async {
                                          var formdata =
                                              cubit?.formKey.currentState;
                                          if (formdata != null &&
                                              formdata.validate()) {
                                            formdata.save();
                                            await cubit?.login(
                                                email: email,
                                                password: password);

                                            if (cubit?.currentUser?.status ==
                                                true) {
                                              formdata.reset();
                                              cubit?.type = 'Gender';
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Home()));
                                            } else {
                                              AwesomeDialog(
                                                  context: context,
                                                  desc: cubit
                                                      ?.currentUser?.message,
                                                  dialogType: DialogType.ERROR,
                                                  btnOkOnPress: () {})
                                                ..show();
                                            }
                                          }
                                        },
                                        child: Text(
                                          'Login',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary:
                                                  Colors.blueAccent.shade700,
                                              shape: CircleBorder()),
                                          onPressed: () {},
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                            size: 40,
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: 100,
                                      height: 35,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.blueAccent.shade700,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Signup()));
                                        },
                                        child: Text(
                                          'Signup',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))
                    ],
                  ),
                )),
              ),
            );
          }),
    );
  }
}
