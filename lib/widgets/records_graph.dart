import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weight_tracker/models/record.dart';

class RecordsGraph extends StatelessWidget {
  final List<Record> records;
  RecordsGraph({required this.records});

  @override
  Widget build(BuildContext context) {
    int numberOfDay(DateTime datetime) {
      return datetime
              .difference(DateTime(records.first.dateTime.year, 1, 1))
              .inDays +
          1;
    }

    List<FlSpot> data() {
      var firstDayOfYear = DateTime(records.first.dateTime.year, 1, 1);
      print(numberOfDay(records.first.dateTime));
      return records
          .map((record) =>
              FlSpot(numberOfDay(record.dateTime).toDouble(), record.weight))
          .toList();
    }

    String calculateBottomTitles(double double) {
      if (double.toInt() < 30) {
        return 'JAN';
      } else if (double.toInt() < 59) {
        return "FEB";
      } else if (double.toInt() < 90) {
        return "MAR";
      } else if (double.toInt() < 120) {
        return "APR";
      } else if (double.toInt() < 151) {
        return "MAY";
      } else if (double.toInt() < 181) {
        return "JUN";
      } else if (double.toInt() < 212) {
        return "JUL";
      } else if (double.toInt() < 242) {
        return "AUG";
      } else if (double.toInt() < 273) {
        return "SEP";
      } else if (double.toInt() < 303) {
        return "OCT";
      } else if (double.toInt() < 334) {
        return "NOV";
      } else {
        return "DEC";
      }
    }

    //Graph Axis data
    var _minY =
        records.reduce((a, b) => a.weight < b.weight ? a : b).weight - 5;
    var _maxY =
        records.reduce((a, b) => a.weight > b.weight ? a : b).weight + 5;
    var _minX = (numberOfDay(records.first.dateTime) - 1).toDouble();
    var _maxX = (numberOfDay(records.last.dateTime) + 1).toDouble();

    return records.isEmpty
        ? Container(
            child: Text('Please Add Some Records'),
          )
        : AspectRatio(
            aspectRatio: 16 / 9,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(enabled: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: data(),
                    isCurved: true,
                    barWidth: 2,
                    colors: [
                      Colors.orange,
                    ],
                  ),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: SideTitles(
                      showTitles: true,
                      rotateAngle: 45.0,
                      interval: 10,
                      getTitles: calculateBottomTitles),
                ),
                minX: _minX,
                maxX: _maxX,
                minY: _minY,
                maxY: _maxY,
              ),
              // read about it in the LineChartData section

              swapAnimationDuration: Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          );
  }
}
