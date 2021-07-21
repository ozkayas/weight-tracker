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
    ///Todo; bu sinif icinden controllera ulasmak dogru mu? Burasi widget.
    final Controller _controller = Get.find();

    return Card(
      child: ListTile(
        leading: buildDate(),
        title: buildWeight(),
        //subtitle: Center(child: subtitleNote),
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

  Widget buildDate() => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(DateFormat('EEE, MMM d').format(record.dateTime)),
          Icon(
            Icons.note,
            size: 16,
            color:
                record.note == '' ? Colors.transparent : Colors.grey.shade400,
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
