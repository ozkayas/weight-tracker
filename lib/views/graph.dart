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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Graph'),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: RecordsGraph(),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    _controller.records.last.weight.toStringAsFixed(1),
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('kg')
                ]),
                Text('Current Weight')
              ],
            ),
          )
        ],
      ),
    );
  }
}
