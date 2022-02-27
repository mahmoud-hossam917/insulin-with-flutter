import 'package:charts_flutter/flutter.dart' as charts;

class BarSeries {
  String? date;
  int? number;
  charts.Color? barColor;
  BarSeries({required this.date, required this.number, required this.barColor});
}
