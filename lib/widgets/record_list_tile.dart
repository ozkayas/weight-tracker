import 'package:flutter/material.dart';
import 'package:weight_tracker/common/constants.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:weight_tracker/viewmodels/controller.dart';
import 'package:weight_tracker/views/edit_record.dart';

class RecordListTile extends StatelessWidget {
  const RecordListTile({Key? key, required this.record}) : super(key: key);
  final Record record;


  @override
  Widget build(BuildContext context) {
    final Controller _controller = Get.find();

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.cornerRadii)),
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 8, right: 0, bottom: 0),
        child: ListTile(
          leading: buildDate(),
          title: buildWeight(),
          trailing: buildIcons(_controller),
        ),
      ),
    );
  }

  Widget buildIcons(Controller _controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 30,
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.edit,
              color: Colors.grey.shade500,
            ),
            onPressed: () {
              Get.to(() => EditRecordScreen(record: record));
            },
          ),


        ),
        SizedBox(
          width: 30,
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
            onPressed: () {
              Get.defaultDialog(
                title: 'Delete Record',
                titleStyle: TextStyle(fontWeight: FontWeight.bold),
                middleText: 'Are you sure?',
                textConfirm: 'Yes',
                buttonColor: Colors.white,
                onConfirm: () {
                  _controller.deleteRecord(record);
                  Get.back();
                },
                textCancel: 'No',
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildDate() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(DateFormat('EEE, MMM d').format(record.dateTime)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.note,
                size: 16,
                color: record.note == ''
                    ? Colors.transparent
                    : Colors.grey.shade400,
              ),
              Icon(
                Icons.photo_rounded,
                size: 16,
                color: record.photoUrl == null
                    ? Colors.transparent
                    : Colors.grey.shade400,
              ),
            ],
          )
        ],
      );

  Widget buildWeight() => Center(
        child: Text(
          record.weight.toStringAsFixed(1),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
}
