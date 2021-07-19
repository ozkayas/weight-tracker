import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weight_tracker/models/record.dart';

class Controller extends GetxController {
  final box = GetStorage();

  var records = <Record>[
    /* Record(dateTime: DateTime.now(), weight: 10.0, note: 'AAA'),
    Record(dateTime: DateTime.now(), weight: 20.0, note: 'BBB'),
    Record(dateTime: DateTime.now(), weight: 30.0, note: 'CCC'),*/
  ].obs;

  @override
  void onInit() {
    // TODO: implement onInit
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
    //setRecordsToStorage();
  }

  void deleteRecord(Record record) {
    records.remove(record);
  }
}
