import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/viewmodels/controller.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({Key? key}) : super(key: key);

  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final Controller _controller = Get.find();
  TextEditingController _date = TextEditingController();
  TextEditingController _weight = TextEditingController();
  TextEditingController _note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Record'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Form(
            child: Column(
                children: [TextFormField(), TextFormField(), TextFormField()]),
          ),
        ),
      ),
    );
  }
}
