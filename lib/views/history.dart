import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/viewmodels/controller.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/widgets/record_list_tile.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final Controller _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    List<Record> records = _controller.records;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text('History'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.changeThemeMode(ThemeMode.light);
                },
                icon: Icon(
                  FontAwesomeIcons.sun,
                  color: Colors.yellow,
                  size: 18,
                )),
            IconButton(
                onPressed: () {
                  Get.changeThemeMode(ThemeMode.dark);
                },
                icon: Icon(
                  FontAwesomeIcons.moon,
                  size: 18,
                ))
          ],
        ),
        body: records.isEmpty
            ? Center(
                child: Container(
                    child: Text("Please Add Some Records",
                        style: textTheme.bodyText1)))
            : ListView(
                physics: BouncingScrollPhysics(),
                children: records
                    .map((record) => RecordListTile(record: record))
                    .toList(),
              ),
      ),
    );
  }
}
