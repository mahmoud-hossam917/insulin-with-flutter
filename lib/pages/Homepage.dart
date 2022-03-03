import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/constants.dart';
import 'package:insulin/cubit/cubit.dart';
import 'package:insulin/cubit/status.dart';
import 'package:insulin/pages/editdose.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var time, dose;
    return BlocProvider(
      create: (context) =>
          AppCubit()..GetAllDoses(userID: cubit!.currentUser!.data!.id!),
      child: BlocConsumer<AppCubit, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cub = AppCubit.get(context);

          SelectTime() async {
            cub.picked = await showTimePicker(
              context: context,
              initialTime: (cub.picked != null) ? cub.picked! : cub.time,
            );
          }

          Process(int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditDosePage(
                                index: index,
                              )));
                    },
                    child: Column(
                      children: [
                        Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green)),
                        MyText('Edit', Colors.black, 10.0, FontWeight.bold)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      await cub.DeleteDose(
                          id: cub.Doeses!.Doses[index - 1].doseID!);
                    },
                    child: Column(
                      children: [
                        Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red)),
                        MyText('Delete', Colors.black, 10.0, FontWeight.bold)
                      ],
                    ),
                  ),
                )
              ],
            );
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
                                  color: Colors.blueAccent.shade700, width: 2),
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
                        child: Form(
                          key: cub.formKey,
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val != null && val.length == 0)
                                return 'required';
                            },
                            onSaved: (val) {
                              dose = val;
                            },
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
                      ),
                      SizedBox(
                        width: width * .45,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * .36,
                              child: InkWell(
                                onTap: () async {
                                  await SelectTime();
                                  cub.selectTime();
                                },
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      (cub != null)
                                          ? (cub.picked != null)
                                              ? '${cub.picked!.hour}:${cub.picked!.minute}'
                                              : "00:00:00"
                                          : "00:00:00",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: () async {
                                  await SelectTime();
                                  cub.selectTime();
                                },
                                child: Icon(
                                  Icons.timer,
                                  color: Colors.blueAccent[700],
                                ))
                          ],
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
                        onPressed: () async {
                          var formdata = cub.formKey.currentState;
                          if (formdata != null && formdata.validate()) {
                            formdata.save();
                            DateTime now = new DateTime.now();
                            DateTime date = new DateTime(now.year, now.month,
                                now.day, cub.picked!.hour, cub.picked!.minute);
                            String d = date.toString();
                            String result = d.replaceAll(' ', 'T');
                            await cub.addDose(
                                time: result,
                                dose: dose,
                                userID: cubit!.currentUser!.data!.id);
                            await cub.GetAllDoses(
                                userID: cubit!.currentUser!.data!.id!);
                            cub.picked = null;

                            formdata.reset();
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
                    child: (state is LoadingDose || state is LoadingDeleteDose)
                        ? Container()
                        : Table(
                            border: TableBorder.all(
                                borderRadius: BorderRadius.circular(20)),
                            children: List.generate(
                                cub.Doeses!.Doses.length + 1,
                                (index) => BuildRow(index)),
                          ))
              ],
            ),
          ));
        },
      ),
    );
  }
}
