import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/constants.dart';
import 'package:insulin/cubit/cubit.dart';
import 'package:insulin/cubit/status.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, Status>(
          listener: (context, state) {},
          builder: (context, state) {
            AppCubit cub = AppCubit.get(context);
            var time, dose;
            TableRow BuildRow(List cells, isheader) {
              return TableRow(
                  children: cells.map((cell) {
                final style = TextStyle(
                    fontWeight: (isheader) ? FontWeight.bold : null,
                    fontSize: 13);

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: (cell != null)
                      ? Center(
                          child: Text(
                          cell,
                          style: style,
                        ))
                      : Center(
                          child: Text(
                          '',
                          style: style,
                        )),
                );
              }).toList());
            }

            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.refresh,
                              size: 30,
                              color: Colors.grey[600],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '3.Novamber.2021',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Hi,${cubit?.currentUser?.data?.firstName} ${cubit?.currentUser?.data?.lastName} ! ',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueAccent.shade700,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(40)),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: cub.formKey,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: width * .45,
                              child: TextFormField(
                                validator: (val) {
                                  if (val == null ||
                                      val != null && val.length == 0)
                                    return 'required';
                                },
                                onSaved: (val) {
                                  dose = val;
                                },
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  labelText: 'Enter Your Dose',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[600]),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent.shade700)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent.shade700)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent.shade700)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * .45,
                              child: TextFormField(
                                cursorColor: Colors.black,
                                validator: (val) {
                                  if (val == null ||
                                      val != null && val.length == 0)
                                    return 'required';
                                },
                                onSaved: (val) {
                                  time = val;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Enter Time of Dose',
                                  labelStyle:
                                      TextStyle(color: Colors.grey[600]),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent.shade700)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent.shade700)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                          color: Colors.blueAccent.shade700)),
                                ),
                              ),
                            )
                          ]),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                          width: 140,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent.shade700,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () async {
                              var formdata = cub.formKey.currentState;
                              if (formdata != null && formdata.validate()) {
                                formdata.save();

                                bool response =
                                    cubit?.addDose(time: time, dose: dose);
                                print('${response}-------------');
                                if (response == false) {
                                  AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.WARNING,
                                      desc: 'Table is full',
                                      btnOkOnPress: () {})
                                    ..show();
                                }
                              }
                            },
                            child: Text(
                              'Submit',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Table(
                                border: TableBorder.all(
                                    borderRadius: BorderRadius.circular(20)),
                                children: List.generate(
                                    4,
                                    (index) => BuildRow([
                                          (index == 0)
                                              ? 'Time'
                                              : cubit?.dataTable?[index - 1]
                                                  ['time'],
                                          (index == 0)
                                              ? 'Dose'
                                              : cubit?.dataTable?[index - 1]
                                                  ['time'],
                                          (index == 0)
                                              ? 'Check Mark'
                                              : cubit?.dataTable?[index - 1]
                                                  ['check'],
                                        ], (index == 0) ? true : false)),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 40, top: 30),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  shape: CircleBorder()),
                                              onPressed: () {},
                                              child: Text(''),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Edit',
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 5),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                  shape: CircleBorder()),
                                              onPressed: () {},
                                              child: Text(''),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 40,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  shape: CircleBorder()),
                                              onPressed: () {},
                                              child: Text(''),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Edit',
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 5),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                  shape: CircleBorder()),
                                              onPressed: () {},
                                              child: Text(''),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  shape: CircleBorder()),
                                              onPressed: () {},
                                              child: Text(''),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Edit',
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      ),
                                      SizedBox(width: 5),
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                  shape: CircleBorder()),
                                              onPressed: () {},
                                              child: Text(''),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            'Delete',
                                            style: TextStyle(fontSize: 10),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: BottomNavigationBar(
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.blueAccent.shade700,
                    selectedItemColor: Colors.white,
                    currentIndex: cubit!.indexPage!,
                    onTap: (index) {
                      cubit?.ChangePage(index);
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                          size: 30,
                        ),
                        label: 'home',
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.leaderboard,
                            color: Colors.white,
                            size: 30,
                          ),
                          label: 'Statisitics'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.auto_stories,
                            color: Colors.white,
                            size: 30,
                          ),
                          label: 'history'),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                            size: 30,
                          ),
                          label: 'Settings')
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
