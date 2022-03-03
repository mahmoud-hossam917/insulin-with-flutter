import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/constants.dart';
import 'package:insulin/cubit/cubit.dart';
import 'package:insulin/cubit/status.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AppCubit()..GetAllDoses(userID: cubit!.currentUser!.data!.id!),
      child: BlocConsumer<AppCubit, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cub = AppCubit.get(context);

          Process(int index) {
            return Center(
                child: IconButton(
                    onPressed: () async {
                      await cub.DeleteDose(
                          id: cub.Doeses!.Doses[index - 1].doseID!);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 25,
                    )));
          }

          check(bool state) {
            return Center(
              child: Icon(
                (state) ? Icons.done : Icons.close,
                size: 30,
                color: (state) ? Colors.green : Colors.red,
              ),
            );
          }

          cell(text, size) {
            return Padding(
              padding: EdgeInsets.all(5),
              child: Center(
                  child: MyText(text, Colors.black, size, FontWeight.bold)),
            );
          }

          TableRow BuildRow(int index) {
            if (index == 0) {
              return TableRow(children: [
                cell('Time', 16.0),
                cell('Dose', 16.0),
                cell('Check Mark', 16.0),
                Container()
              ]);
            }
            return TableRow(children: [
              cell(cub.Doeses!.Doses[index - 1].doseDate, 13.0),
              cell(cub.Doeses!.Doses[index - 1].doseAmount.toString(), 13.0),
              check(cub.Doeses!.Doses[index - 1].isTaken!),
              Process(index)
            ]);
          }

          return SafeArea(
              child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 30,
                      ),
                      Row(
                        children: [
                          MyText('Hi,${cubit!.currentUser!.data!.firstName}',
                              Colors.black, 15.0, FontWeight.bold),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.blueAccent, width: 2)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText('History', Colors.black, 25.0, FontWeight.bold)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Expanded(
                    child: (state is LoadingDose || state is LoadingDeleteDose)
                        ? Container()
                        : Table(
                            border: TableBorder.all(
                                borderRadius: BorderRadius.circular(20)),
                            children: List.generate(
                                cub.Doeses!.Doses.length + 1,
                                (index) => BuildRow(index))),
                  ),
                )
              ],
            ),
          ));
        },
      ),
    );
  }
}
