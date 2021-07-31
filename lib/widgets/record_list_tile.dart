import 'package:flutter/material.dart';
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
      child: ListTile(
        leading: buildDate(),
        title: buildWeight(),
        trailing: buildRow(_controller),
      ),
    );
  }

  Widget buildRow(Controller _controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Icons.edit,
            color: Colors.grey.shade500,
          ),
          onPressed: () {
            Get.to(EditRecordScreen(record: record));
          },
        ),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.redAccent,
          ),
          onPressed: () {
            _controller.deleteRecord(record);
          },
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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
}
