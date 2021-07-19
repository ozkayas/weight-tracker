import 'package:get/get.dart';
import 'package:weight_tracker/models/record.dart';

class Controller extends GetxController {
  var records = <Record>[
    Record(dateTime: DateTime.now(), weight: 10.0, note: 'AAA'),
    Record(dateTime: DateTime.now(), weight: 20.0, note: 'BBB'),
    Record(dateTime: DateTime.now(), weight: 30.0, note: 'CCC'),
  ].obs;

  void addRecord(Record record) {
    records.add(record);
  }

  void deleteRecord(Record record) {
    records.remove(record);
  }
}
