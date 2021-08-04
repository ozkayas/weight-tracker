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
          .map((record) => FlSpot(numberOfDay(record.dateTime).toDouble(),
              record.weight.toDouble()))
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

    String calculateBottomTitlesMiddle(double double) {
      if (double.toInt() == 15) {
        return 'JAN';
      } else if (double.toInt() == 45) {
        return "FEB";
      } else if (double.toInt() == 75) {
        return "MAR";
      } else if (double.toInt() == 105) {
        return "APR";
      } else if (double.toInt() == 135) {
        return "MAY";
      } else if (double.toInt() == 165) {
        return "JUN";
      } else if (double.toInt() == 195) {
        return "JUL";
      } else if (double.toInt() == 225) {
        return "AUG";
      } else if (double.toInt() == 255) {
        return "SEP";
      } else if (double.toInt() == 285) {
        return "OCT";
      } else if (double.toInt() == 315) {
        return "NOV";
      } else if (double.toInt() == 345) {
        return "DEC";
      } else {
        return "";
      }
    }

    //Graph Axis data
    var _minY = records
            .reduce((a, b) => a.weight < b.weight ? a : b)
            .weight
            .toDouble() -
        5;
    var _maxY = records
            .reduce((a, b) => a.weight > b.weight ? a : b)
            .weight
            .toDouble() +
        5;
    var _minX = (numberOfDay(records.first.dateTime) - 5).toDouble();
    var _maxX = (numberOfDay(records.last.dateTime) + 5).toDouble();

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
                    isCurved: false,
                    barWidth: 2,
                    colors: [
                      Colors.black54,
                    ],
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(interval: 3, showTitles: true),
                  bottomTitles: SideTitles(
                      showTitles: true,
                      rotateAngle: 45.0,
                      interval: 10,
                      getTitles: calculateBottomTitlesMiddle),
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
