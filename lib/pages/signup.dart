import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/cubit/cubit.dart';
import 'package:insulin/cubit/status.dart';
import 'package:insulin/pages/login.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          String? value = 'Male';
          AppCubit cubit = AppCubit.get(context);
          var firstName, lastName, email, password, age;
          return ModalProgressHUD(
            inAsyncCall: state is SignLoadingState,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: height * .4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 240,
                            child: Image.asset(
                              'images/login.png',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          Container(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add,
                                    size: 50,
                                    color: Colors.grey,
                                  )),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: Colors.blue.shade800, width: 3))),
                          Container(),
                          Container(),
                          Container()
                        ],
                      ),
                    ),
                    Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            Container(
                              width: width,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: width * .45,
                                      child: TextFormField(
                                        validator: (val) {
                                          if (val != null && val.length == 0 ||
                                              val == null)
                                            return 'Please Enter First Name';
                                        },
                                        onSaved: (val) {
                                          firstName = val;
                                        },
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          labelText: 'First Name',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * .45,
                                      child: TextFormField(
                                        validator: (val) {
                                          if (val != null && val.length == 0 ||
                                              val == null)
                                            return 'Please Enter Last Name';
                                        },
                                        onSaved: (val) {
                                          lastName = val;
                                        },
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          labelText: 'Last Name',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    )
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: TextFormField(
                                validator: (val) {
                                  if (val != null && val.length == 0 ||
                                      val == null) return 'Please Enter email';
                                },
                                onSaved: (val) {
                                  email = val;
                                },
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: TextStyle(color: Colors.black),
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                              height: 10,
                            ),
                            Container(
                              width: width,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: width * .45,
                                      child: TextFormField(
                                        validator: (val) {
                                          if (val != null && val.length == 0 ||
                                              val == null)
                                            return 'Please Enter Age';
                                          else {
                                            try {
                                              int.parse(val);
                                            } on FormatException {
                                              return 'Age must be digits';
                                            }
                                          }
                                        },
                                        onSaved: (val) {
                                          age = int.parse(val!);
                                        },
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          labelText: 'Age',
                                          labelStyle:
                                              TextStyle(color: Colors.black),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: width * .45,
                                        height: 60,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text('${cubit.type}'),
                                                ),
                                                DropdownButton(
                                                  isExpanded: false,
                                                  underline:
                                                      DropdownButtonHideUnderline(
                                                          child: Container()),
                                                  items: ['Male', 'Female']
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            child: Text('$e'),
                                                            value: e,
                                                          ))
                                                      .toList(),
                                                  onChanged: (val) {
                                                    cubit.changeGender(val);
                                                  },
                                                ),
                                              ],
                                            )))
                                  ]),
                            ),
                          ],
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Text('Already Have an account ?',
                            style: TextStyle(color: Colors.black))),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: SizedBox(
                        width: 100,
                        height: 35,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent.shade700,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () async {
                            if (cubit.type == 'Gender') {
                              AwesomeDialog(
                                  context: context,
                                  desc: 'Please Select Gender',
                                  dialogType: DialogType.ERROR,
                                  btnOkOnPress: () {})
                                ..show();
                            } else {
                              var formdata = cubit.formKey.currentState;
                              if (formdata != null && formdata.validate()) {
                                formdata.save();
                                await cubit.SignUp(
                                    Doses: [],
                                    firstname: firstName,
                                    lastname: lastName,
                                    email: email,
                                    password: password,
                                    phone: '01121554454',
                                    age: age,
                                    gender:
                                        (cubit.type == 'Male') ? true : false,
                                    photo: ' ',
                                    birthdate: null);
                              }
                              AwesomeDialog(
                                  context: context,
                                  desc: 'Signup Done Successfuly.',
                                  dialogType: DialogType.SUCCES,
                                  btnOkOnPress: () {
                                    formdata?.reset();
                                    cubit.type = 'Gender';
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  })
                                ..show();
                            }
                          },
                          child: Text(
                            'Signup',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
        },
      ),
    );
  }
}
