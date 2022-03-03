import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/constants.dart';
import 'package:insulin/cubit/cubit.dart';
import 'package:insulin/cubit/status.dart';
import 'package:insulin/pages/Homepage.dart';

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

            return Scaffold(
              backgroundColor: Colors.white,
              body: cub.pages[cub.indexPage!],
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
                    currentIndex: cub.indexPage!,
                    onTap: (index) {
                      cub.ChangePage(index);
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
