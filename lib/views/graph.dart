import 'package:flutter/material.dart';
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
                              Text('kg')
                            ]),
                        Text('Total Progress')
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
