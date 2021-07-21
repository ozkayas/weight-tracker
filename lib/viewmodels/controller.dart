import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weight_tracker/models/record.dart';

class Controller extends GetxController {
  final box = GetStorage();

  var records = <Record>[
    /* Record(dateTime: DateTime(2020, 1, 1), weight: 10.0, note: 'AAA'),
    Record(dateTime: DateTime(2020, 1, 15), weight: 20.0, note: 'BBB'),
    Record(dateTime: DateTime(2020, 1, 30), weight: 30.0, note: 'CCC'),
    Record(dateTime: DateTime(2020, 2, 1), weight: 34.0, note: 'CCC'),
    Record(dateTime: DateTime(2020, 2, 12), weight: 25.0, note: 'CCC'),*/
  ].obs;

  @override
  void onInit() {
    List? resultFromStorage = box.read<List>('records');
    if (resultFromStorage != null) {
      records = resultFromStorage
          .map((record) => Record.fromJson(record))
          .toList()
          .obs;
    }

    ever(records, (_) => {box.write('records', records.toList())});
    super.onInit();
  }

  void addRecord(Record record) {
    records.add(record);
    records.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }

  void deleteRecord(Record record) {
    records.remove(record);
    records.sort((a, b) => a.dateTime.compareTo(b.dateTime));
  }
}
