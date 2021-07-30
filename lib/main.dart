import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weight_tracker/views/home_page.dart';

void main() async {
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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

/// Todo; Add Dark Theme
/// Todo; Find & Add A Cool Graph package
/// Todo; Add photo feature for a Record, https://programmingwithswift.com/how-to-save-a-file-locally-with-flutter/
/// Todo; toast to undo feature
/// Todo; Local Notification if no record added for a week!
