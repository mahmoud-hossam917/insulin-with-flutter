import 'package:flutter/material.dart';
import 'package:insulin/constants.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TableRow> history = [];
    for (int i = 0; i < 30; i++) {
      history.add(TableRow(children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text('mm'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text('mm'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text('mm'),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Center(
            child: Text('mmm'),
          ),
        ),
        (i != 0)
            ? Padding(
                padding: EdgeInsets.all(2),
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ),
              )
            : Container()
      ]));
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
                          border:
                              Border.all(color: Colors.blueAccent, width: 2)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [MyText('History', Colors.black, 25.0, FontWeight.bold)],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Expanded(
              child: Table(
                  border:
                      TableBorder.all(borderRadius: BorderRadius.circular(20)),
                  children: history),
            ),
          )
        ],
      ),
    ));
  }
}
