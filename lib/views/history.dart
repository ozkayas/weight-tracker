import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weight_tracker/viewmodels/controller.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final Controller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: Obx(() => Column(
            children: _controller.records
                .map((record) => Text(record.note ?? ""))
                .toList(),
          )),
    );
  }
}
