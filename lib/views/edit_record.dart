import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/models/record.dart';
import 'dart:io';
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
  late DateTime _selectedDate;
  var _imageFile;
  String? _photoUrl;
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
    final Record record = widget.record;
    _selectedDate = record.dateTime;
    _date.text = DateFormat('EEE, MMM d').format(record.dateTime);
    _weight.text = record.weight.toStringAsFixed(1);
    _note.text = record.note ?? "";
    _photoUrl = record.photoUrl;
    _imageFile= FileImage(File(_photoUrl!));
  }





  @override
  void dispose() {
    _date.dispose();
    _weight.dispose();
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('widget.record.photoUrl: ${widget.record.photoUrl}');
    print('_photoUrl $_photoUrl');

    return Scaffold(
      appBar: AppBar(

        title: Text('Edit Record'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            TextFormField(
              controller: _date,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range),
                //labelText: 'Date',
              ),
              onTap: () async {
                _selectedDate = await pickDate(context);
                print(_selectedDate.toIso8601String());
                setState(() {
                  _date.text = DateFormat('EEE, MMM d').format(_selectedDate);
                });
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
            Container(
              child:
                (_photoUrl == null)
                    ? Container()
                    : Expanded(
                        child: Container(
                          margin: EdgeInsets.all(12),
                          //child: Text('AAA'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.fill,

                                image: _imageFile
                                //image: FileImage(_imageFile!))),
                                ),
                          ),
                        ),
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
                    handleEdit();
                  }
                },
                child: Text('Save Record'),
              ),
            )
          ]),
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

  void handleEdit() {
    Record newRecord = Record(
        dateTime: _selectedDate,
        weight: double.parse(_weight.text),
        note: _note.text,
        photoUrl: _photoUrl
    );
    _controller.deleteRecord(widget.record);
    _controller.addRecord(newRecord);
    Get.back();
  }
}
