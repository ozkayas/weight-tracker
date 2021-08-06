import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/viewmodels/controller.dart';
import 'package:weight_tracker/widgets/records_graph.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({Key? key}) : super(key: key);

  @override
  _GraphScreenState createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  final Controller _controller = Get.find();

  String currentWeight() => _controller.records.last.weight.toStringAsFixed(1);

  String totalProgress() =>
      (_controller.records.last.weight - _controller.records.first.weight)
          .toStringAsFixed(1);

  Color totalProgressColor() {
    return (_controller.records.last.weight -
                _controller.records.first.weight) <
            0
        ? Colors.green
        : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      //backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text('Graph'),
        actions: [_buildFlutterSwitch()],
      ),
      body: _controller.records.isEmpty
          ? Center(
              child:
                  Text('Please Add Some Records', style: textTheme.bodyText1),
            )
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: RecordsGraph(records: _controller.records),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(currentWeight(),
                                  style: textTheme.bodyText1!.copyWith(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                width: 10,
                              ),
                              Text('kg',
                                  style: Theme.of(context).textTheme.bodyText1)
                            ]),
                        Text('Current Weight', style: textTheme.bodyText1)
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                totalProgress(),
                                style: TextStyle(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                    color: totalProgressColor()),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text('kg', style: textTheme.bodyText1)
                            ]),
                        Text('Total Progress', style: textTheme.bodyText1)
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Widget _buildFlutterSwitch() => FlutterSwitch(
        width: 100.0,
        height: 55.0,
        toggleSize: 45.0,
        value: true,
        borderRadius: 30.0,
        padding: 2.0,
        activeToggleColor: Color(0xFF6E40C9),
        inactiveToggleColor: Color(0xFF2F363D),
        activeSwitchBorder: Border.all(
          color: Color(0xFF3C1E70),
          width: 6.0,
        ),
        inactiveSwitchBorder: Border.all(
          color: Color(0xFFD1D5DA),
          width: 6.0,
        ),
        activeColor: Color(0xFF271052),
        inactiveColor: Colors.white,
        activeIcon: Icon(
          Icons.nightlight_round,
          color: Color(0xFFF8E3A1),
        ),
        inactiveIcon: Icon(
          Icons.wb_sunny,
          color: Color(0xFFFFDF5D),
        ),
        onToggle: (val) {
          print(val);
          /*     setState(() {
                          status7 = val;

                          if (val) {
                            _textColor = Colors.white;
                            _appBarColor = Color.fromRGBO(22, 27, 34, 1);
                            _scaffoldBgcolor = Color(0xFF0D1117);
                          } else {
                            _textColor = Colors.black;
                            _appBarColor = Color.fromRGBO(36, 41, 46, 1);
                            _scaffoldBgcolor = Colors.white;
                          }
                        }); */
        },
      );
}
