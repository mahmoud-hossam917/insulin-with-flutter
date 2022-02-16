import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            AppCubit cubit = AppCubit.get(context);
            TableRow BuildRow(List<String> cells, isheader) {
              return TableRow(
                  children: cells.map((cell) {
                final style = TextStyle(
                    fontWeight: (isheader) ? FontWeight.bold : null,
                    fontSize: 13);

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                      child: Text(
                    cell,
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
                              'Hi,Amer Ashraf ! ',
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: width * .45,
                            child: TextFormField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                labelText: 'Enter Your Dose',
                                labelStyle: TextStyle(color: Colors.grey[600]),
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
                              decoration: InputDecoration(
                                labelText: 'Enter Time of Dose',
                                labelStyle: TextStyle(color: Colors.grey[600]),
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
                            onPressed: () {},
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
                                children: [
                                  BuildRow(
                                      ['Time', 'Dose', 'Check Mark'], true),
                                  BuildRow(
                                      ['Time', 'Dose', 'Check Mark'], false),
                                  BuildRow(
                                      ['Time', 'Dose', 'Check Mark'], false),
                                  BuildRow(
                                      ['Time', 'Dose', 'Check Mark'], false),
                                ],
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
                    currentIndex: cubit.indexPage!,
                    onTap: (index) {
                      cubit.ChangePage(index);
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
