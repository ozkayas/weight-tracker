import 'package:flutter/material.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:intl/intl.dart';

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

    return ListTile(
      leading: date,
      title: Center(child: weight),
      subtitle: Center(child: subtitleNote),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {},
      ),
    );
  }
}
