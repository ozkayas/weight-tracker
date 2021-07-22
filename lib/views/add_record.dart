import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/viewmodels/controller.dart';
import 'dart:io';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({Key? key}) : super(key: key);

  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final Controller _controller = Get.find();
  TextEditingController _date = TextEditingController();
  TextEditingController _weight = TextEditingController();
  TextEditingController _note = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  String? photoUrl;

  @override
  Widget build(BuildContext context) {
    _date.text = DateFormat('EEE, MMM d').format(_selectedDate);

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
                    labelText: 'kg'
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
                controller: _note,
                maxLines: null,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.edit),
                  labelText: 'Optional Note',
                ),
              ),
              IconButton(
                  onPressed: () async {
                    await captureSaveImage();
                  },
                  icon: Icon(Icons.camera_alt)),
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
        note: _note.text,
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
