import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/constants.dart';
import 'package:insulin/cubit/cubit.dart';
import 'package:insulin/cubit/status.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class EditDosePage extends StatelessWidget {
  const EditDosePage({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    var dose;
    return BlocProvider(
      create: (context) =>
          AppCubit()..GetAllDoses(userID: cubit!.currentUser!.data!.id!),
      child: BlocConsumer<AppCubit, Status>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cub = AppCubit.get(context);
          var width = MediaQuery.of(context).size.width;
          var height = MediaQuery.of(context).size.height;
          SelectTime() async {
            cub.picked = await showTimePicker(
              context: context,
              initialTime: (cub.picked != null) ? cub.picked! : cub.time,
            );
          }

          return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                              'Time:  ', Colors.black, 26.0, FontWeight.bold),
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
                                    border: Border.all(
                                        color: Colors.blueAccent.shade700),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                              'Dose:  ', Colors.black, 26.0, FontWeight.bold),
                          SizedBox(
                            width: width * .45,
                            child: Form(
                              key: cub.formKey,
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
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                        condition: state is! LoadingUpdateDose,
                        builder: (context) => SizedBox(
                              width: 160,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blueAccent[700],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  onPressed: () async {
                                    if (cub.picked == null) {
                                      AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.ERROR,
                                          desc: 'Please Select Time',
                                          btnOkOnPress: () {})
                                        ..show();
                                    }
                                    var formdata = cub.formKey.currentState;
                                    if (formdata!.validate() &&
                                        cub.picked != null) {
                                      DateTime now = new DateTime.now();
                                      DateTime date = new DateTime(
                                          now.year,
                                          now.month,
                                          now.day,
                                          cub.picked!.hour,
                                          cub.picked!.minute);
                                      String d = date.toString();
                                      String result = d.replaceAll(' ', 'T');

                                      await cub.UpdateDose(
                                          time: result,
                                          dose: 15,
                                          index: index - 1);
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: MyText('Save', Colors.white, 25.0,
                                      FontWeight.bold)),
                            ),
                        fallback: (context) => CircularProgressIndicator())
                  ])));
        },
      ),
    );
  }
}
