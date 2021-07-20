import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/viewmodels/controller.dart';
import 'package:get/get.dart';

class RecordsGraph extends StatelessWidget {
  final Controller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var records = _controller.records.value;
    var data = records
        .map((record) => FlSpot(
            record.dateTime.millisecondsSinceEpoch.toDouble(), record.weight))
        .toList();

    String titleFromDouble(double double) {
      int milliSeconds = double.toInt();
      var dateTime = DateTime.fromMillisecondsSinceEpoch(milliSeconds);
      String axisLabel = DateFormat('EEE, MMM d').format(dateTime);
      return axisLabel;
    }

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
                      spots: data,
                      /* spots: [
                FlSpot(0, 1),
                FlSpot(1, 1),
                FlSpot(5, 3),
                FlSpot(3, 4),
                FlSpot(3, 5),
                FlSpot(4, 4)
              ],*/
                      isCurved: false,
                      barWidth: 2,
                      colors: [
                        Colors.orange,
                      ],
                      /* belowBarData: BarAreaData(
                show: true,
                colors: [Colors.lightBlue.withOpacity(0.5)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              aboveBarData: BarAreaData(
                show: true,
                colors: [Colors.lightGreen.withOpacity(0.5)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              dotData: FlDotData(
                show: false,
              ),*/
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: SideTitles(
                        showTitles: false,
                        rotateAngle: 45.0,
                        interval: null,
                        getTitles: titleFromDouble),
                  )
                  //minY: 0,
                  //maxY: 10,
                  ),
              // read about it in the LineChartData section

              swapAnimationDuration: Duration(milliseconds: 150), // Optional
              swapAnimationCurve: Curves.linear, // Optional
            ),
          );
  }
}
