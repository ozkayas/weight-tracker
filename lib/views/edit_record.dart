import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/common/constants.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/viewmodels/controller.dart';
import 'dart:io';
import 'package:weight_tracker/widgets/weight_picker_card.dart';

class EditRecordScreen extends StatefulWidget {
  const EditRecordScreen({Key? key, required this.record}) : super(key: key);
  final Record record;

  @override
  _EditRecordScreenState createState() => _EditRecordScreenState();
}

class _EditRecordScreenState extends State<EditRecordScreen> {
  //Inject controller
  final Controller _controller = Get.find();

  //State variables related to record to be edited
  TextEditingController _noteController = TextEditingController();
  late int _weight;
  late DateTime _selectedDate;
  //Local path of photo, if user takes one, to be saved in a record
  String? _photoUrl;

  @override
  void initState() {
    super.initState();
    _noteController.text = widget.record.note ?? '';
    _weight = widget.record.weight;
    _selectedDate = widget.record.dateTime;
    _photoUrl = widget.record.photoUrl ?? null;
  }

  //Callback function for WeighPickerCard
  void setWeight(int value) {
    _weight = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Record'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeightPickerCard(
                onChanged: setWeight,
                initialValue: _weight,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Constants.cornerRadii)),
                child: GestureDetector(
                  onTap: () async {
                    _selectedDate = await pickDate(context);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: Icon(FontAwesomeIcons.calendar, size: 40),
                        ),
                        Expanded(
                            child: Text(
                          DateFormat('EEE, MMM d').format(_selectedDate),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                          textAlign: TextAlign.center,
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Constants.cornerRadii)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Icon(FontAwesomeIcons.stickyNote, size: 40),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: TextFormField(
                            controller: _noteController,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Optional Note',
                              hintStyle: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black45),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black54),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints.tightForFinite(
                      width: double.infinity,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                Constants.cornerRadii - 4)),
                      ),
                      onPressed: () {
                        handleEdit();
                      },
                      child: Text('Edit Record'),
                    ),
                  ),
                ],
              ),
              Container(
                child: (_photoUrl == null)
                    ? Container()
                    : Expanded(
                        child: Container(
                          margin: EdgeInsets.all(12),
                          //child: Text('AAA'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: FileImage(File(_photoUrl!))
                                //image: FileImage(_imageFile!))),
                                ),
                          ),
                        ),
                      ),
              ),
            ],
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
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
              splashColor: Colors.black,
              textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.black),
                button: TextStyle(color: Colors.black),
              ),
              accentColor: Colors.black,
              colorScheme: ColorScheme.light(
                  primary: Colors.black,
                  primaryVariant: Colors.black,
                  secondaryVariant: Colors.black,
                  onSecondary: Colors.black,
                  onPrimary: Colors.white,
                  surface: Colors.black,
                  onSurface: Colors.black,
                  secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
            ),
            child: child ?? Text(""),
          );
        });
    if (newDate != null) {
      return newDate;
    } else {
      return _selectedDate;
    }
  }

  /// This alternative method can be used to save images to external path
  /// however requires some permissions
  void handleEdit() {
    Record newRecord = Record(
        dateTime: _selectedDate,
        weight: _weight,
        note: _noteController.text,
        photoUrl: _photoUrl);
    _controller.deleteRecord(widget.record);
    _controller.addRecord(newRecord);
    Get.back();
  }
}
