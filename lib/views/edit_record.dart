import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/viewmodels/controller.dart';

class EditRecordScreen extends StatefulWidget {
  const EditRecordScreen({Key? key, required this.record}) : super(key: key);
  final Record record;

  @override
  _EditRecordScreenState createState() => _EditRecordScreenState();
}

class _EditRecordScreenState extends State<EditRecordScreen> {
  final Controller _controller = Get.find();
  TextEditingController _date = TextEditingController();
  TextEditingController _weight = TextEditingController();
  TextEditingController _note = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Record record = widget.record;
    _date.text = DateFormat('EEE, MMM d').format(record.dateTime);
    _weight.text = record.weight.toStringAsFixed(1);
    _note.text = record.note ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Record'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _date,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.date_range),
                  //labelText: 'Date',
                ),
                onTap: () async {
                  _selectedDate = await pickDate(context);
                  setState(() {});
                },
              ),
              TextFormField(
                controller: _weight,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.fitness_center_outlined,
                  ),

                  //labelText: 'Date',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),

                ///Todo; should allow decimal input or use a picker
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter weight';
                  }
                  return null;
                },
              ),
              TextFormField(
                /// Todo; will be multiple lines
                controller: _note,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.edit),
                  labelText: 'Optional Note',
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: double.infinity,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      handleSave();
                    }
                  },
                  child: Text('Save Record'),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  Future<DateTime> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: initialDate.subtract(Duration(days: 365)),
      lastDate: initialDate.add(
        Duration(days: 30),
      ),
    );
    if (newDate != null) {
      return newDate;
    } else {
      return _selectedDate;
    }
  }

  void handleSave() {
    Record newRecord = Record(
        dateTime: _selectedDate,
        weight: double.parse(_weight.text),
        note: _note.text);
    _controller.addRecord(newRecord);
    Get.back();
  }
}
