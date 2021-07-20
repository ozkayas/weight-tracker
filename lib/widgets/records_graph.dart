import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RecordsGraph extends StatelessWidget {
  const RecordsGraph({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(enabled: true),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 1),
              FlSpot(1, 1),
              FlSpot(2, 3),
              FlSpot(3, 4),
              FlSpot(3, 5),
              FlSpot(4, 4)
            ],
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
        minY: 0,
        maxY: 10,
      ),
      // read about it in the LineChartData section

      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }
}
