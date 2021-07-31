import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/viewmodels/controller.dart';
import 'dart:io';

import 'package:weight_tracker/widgets/weight_card.dart';
import 'package:weight_tracker/widgets/weight_picker_card.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({Key? key}) : super(key: key);

  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final Controller _controller = Get.find();
  TextEditingController _dateController = TextEditingController();
  //TextEditingController _weightController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  int _weight = 70;
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  String? photoUrl;

  void setWeight(int value){
    _weight=value;
  }

  @override
  Widget build(BuildContext context) {
    _dateController.text = DateFormat('EEE, MMM d').format(_selectedDate);

    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text('Add New Record'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              //WeightCard(),
              WeightPickerCard(setWeight: setWeight),
              Card(
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
                          child:Icon(FontAwesomeIcons.calendar, size: 40),
                        ),
                        Expanded(child: Text(DateFormat('EEE, MMM d').format(_selectedDate), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),textAlign: TextAlign.center,))
                      ],),
                  ),
                ),
              ),
                  /*          TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.date_range),
                  //labelText: 'Date',
                ),
                onTap: () async {
                  _selectedDate = await pickDate(context);
                  setState(() {});
                },
              ),*/
/*              TextFormField(
                controller: _weight,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.fitness_center_outlined,
                    ),
                    labelText: 'kg'
                    //labelText: 'Date',
                    ),

                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter weight';
                  }
                  return null;
                },
              ),*/
              TextFormField(
                controller: _noteController,
                maxLines: null,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.edit),
                  labelText: 'Optional Note',
                ),
              ),

              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        await captureSaveImage();
                      },
                      icon: Icon(Icons.camera_alt)),

                  ConstrainedBox(
                    constraints: BoxConstraints.tightForFinite(
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
                  ),
                ],
              ),
              (photoUrl == null)
                  ? Container()
                  : Expanded(
                      child: Container(
                        margin: EdgeInsets.all(12),
                        //child: Text('AAA'),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(File(photoUrl!))
                              //image: FileImage(_imageFile!))),
                              ),
                        ),
                      ),
                    ),
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
        //weight: double.parse(_weightController.text),
        weight: _weight.toDouble(),
        note: _noteController.text,
        photoUrl: photoUrl);
    _controller.addRecord(newRecord);
    Get.back();
  }

  Future<File?> captureSaveImage() async {
    final XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (pickedImage == null) return null;

    _imageFile = File(pickedImage.path);

    // getting a directory path for saving
    final Directory extDir = await getApplicationDocumentsDirectory();
    String dirPath = extDir.path;
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$dirPath/$imageName.png';
    print(filePath);

    // copy the file to a new path
    final File newImage = await _imageFile!.copy(filePath);
    setState(() {
      print('setstate called');
      _imageFile = newImage;
    });

    // save photoUrl to state variable
    photoUrl = filePath;
  }
}
