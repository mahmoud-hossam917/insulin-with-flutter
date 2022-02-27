import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insulin/chart/barseries.dart';
import 'package:insulin/chart/chart.dart';
import 'package:insulin/constants.dart';
import 'package:insulin/cubit/cubit.dart';
import 'package:insulin/cubit/status.dart';
import 'package:pie_chart/pie_chart.dart';

class Statistics extends StatelessWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List data = [
      {'color': Colors.green[400], 'text': 'insulin'},
      {'color': Colors.blueAccent, 'text': 'Glucose'},
      {'color': Colors.brown, 'text': 'Heath'}
    ];
    List<BarSeries> dataSeries = [
      BarSeries(
          date: 'Nov 19',
          number: 3,
          barColor: charts.ColorUtil.fromDartColor(Colors.green.shade400)),
      BarSeries(
          date: 'DEC 19',
          number: 3,
          barColor: charts.ColorUtil.fromDartColor(Colors.green.shade400)),
      BarSeries(
          date: 'JAN 19',
          number: 3,
          barColor: charts.ColorUtil.fromDartColor(Colors.green.shade400)),
    ];
    List<BarSeries> dataSeries2 = [
      BarSeries(
          date: 'Nov 19',
          number: 5,
          barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent)),
      BarSeries(
          date: 'DEC 19',
          number: 5,
          barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent)),
      BarSeries(
          date: 'JAN 19',
          number: 5,
          barColor: charts.ColorUtil.fromDartColor(Colors.blueAccent)),
    ];
    List<BarSeries> dataSeries3 = [
      BarSeries(
          date: 'Nov 19',
          number: 6,
          barColor: charts.ColorUtil.fromDartColor(Colors.brown)),
      BarSeries(
          date: 'DEC 19',
          number: 6,
          barColor: charts.ColorUtil.fromDartColor(Colors.brown)),
      BarSeries(
          date: 'JAN 19',
          number: 6,
          barColor: charts.ColorUtil.fromDartColor(Colors.brown)),
    ];
    List colors = [Colors.green.shade400, Colors.blueAccent];
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, Status>(
        listener: (context, state) {},
        builder: (context, state) {
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      3,
                      (index) => circleContainer(
                          data[index]['color'], data[index]['text'])),
                ),
                Container(
                  height: 250,
                  child: Expanded(
                      child: ChartBar(
                    data1: dataSeries,
                    data2: dataSeries2,
                    data3: dataSeries3,
                  )),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                    children: List.generate(
                        2,
                        (index) => Details(
                            context, colors[index], 'Glucose Level Progress')))
              ],
            ),
          ));
        },
      ),
    );
  }

  Widget circleContainer(color, text) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        SizedBox(
          width: 2,
        ),
        MyText(text, Colors.black, 15.0, FontWeight.bold),
      ],
    );
  }

  Widget pieChart(context, color) {
    return PieChart(
      dataMap: {'mahmoud': 85, 'ahmed': 15},
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 5.8,
      colorList: [color, Colors.white],
      initialAngleInDegree: 267,
      chartType: ChartType.ring,
      ringStrokeWidth: 4,
      centerText: "35%",
      legendOptions: LegendOptions(
        showLegends: false,
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: false,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }

  Widget Details(context, color, text) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  blurRadius: 3.0,
                  color: Colors.grey.shade200,
                  spreadRadius: 3.0)
            ]),
        child: Center(
          child: ListTile(
            leading: Container(
                height: 50, width: 50, child: pieChart(context, color)),
            title: MyText(text, Colors.black, 15.0, FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
