import 'package:flutter/material.dart';
import 'package:weight_tracker/models/record.dart';

class RecordListTile extends StatelessWidget {
  const RecordListTile({Key? key, required this.record}) : super(key: key);
  final Record record;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(record.dateTime.toIso8601String()),
      title: Text(record.weight.toStringAsFixed(1)),
      trailing: record.note == null ? null : Icon(Icons.note),
    );
  }
}
