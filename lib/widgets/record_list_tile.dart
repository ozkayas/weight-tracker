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
    var date = Text(DateFormat('EEE, MMM d').format(record.dateTime));
    var weight = Text(
      record.weight.toStringAsFixed(1),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
    var subtitleNote = Text(record.note ?? '');

    ///Todo; bu sinif icinden controllera ulasmak dogru mu? Burasi widget.
    final Controller _controller = Get.find();

    return Card(
      child: ListTile(
        leading: date,
        title: Center(child: weight),
        subtitle: Center(child: subtitleNote),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: Colors.greenAccent,
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
        ),
      ),
    );
  }
}
