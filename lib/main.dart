import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/views/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

/// TODO; Add local storage with getx package
/// Todo; Add Dark Theme
/// Todo; Find & Add A Cool Graph package
/// Todo; maybe; add photo feature for a Record
