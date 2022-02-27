import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:insulin/chart/barseries.dart';

class ChartBar extends StatefulWidget {
  ChartBar(
      {Key? key, required this.data1, required this.data2, required this.data3})
      : super(key: key);
  final List<BarSeries> data1, data2, data3;
  @override
  State<ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series<BarSeries, String>> series = [
      charts.Series(
          id: 'sub',
          data: widget.data1,
          domainFn: (BarSeries bar, _) => bar.date!,
          measureFn: (BarSeries bar, _) => bar.number!,
          colorFn: (BarSeries bar, _) => bar.barColor!),
      charts.Series(
          id: 'sub',
          data: widget.data2,
          domainFn: (BarSeries bar, _) => bar.date!,
          measureFn: (BarSeries bar, _) => bar.number!,
          colorFn: (BarSeries bar, _) => bar.barColor!),
      charts.Series(
          id: 'sub',
          data: widget.data3,
          domainFn: (BarSeries bar, _) => bar.date!,
          measureFn: (BarSeries bar, _) => bar.number!,
          colorFn: (BarSeries bar, _) => bar.barColor!)
    ];
    return charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }
}
