import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weight_tracker/models/record.dart';
import 'package:weight_tracker/viewmodels/controller.dart';
import 'dart:io';
import 'package:weight_tracker/widgets/weight_picker_card.dart';
import 'package:gallery_saver/gallery_saver.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({Key? key}) : super(key: key);

  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  final Controller _controller = Get.find();
  //TextEditingController _dateController = TextEditingController();
  //TextEditingController _weightController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  int _weight = 70;
  DateTime _selectedDate = DateTime.now();
  //final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  //Local path of photo, if user takes one, to be saved in a record
  String? photoUrl;

  //Callback function for WeighPickerCard
  void setWeight(int value) {
    _weight = value;
  }

  @override
  Widget build(BuildContext context) {
    //_dateController.text = DateFormat('EEE, MMM d').format(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Record'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeightPickerCard(onChanged: setWeight),
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
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
                  IconButton(
                      onPressed: () async {
                        await captureSaveImageToExternalStorage();
                        //await captureSaveImage();
                        //await captureSaveImageToGallery();
                      },
                      icon: Icon(
                        Icons.camera_alt,
                        size: 40,
                      )),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightForFinite(
                      width: double.infinity,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        handleSave();

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

  void handleSave() {
    Record newRecord = Record(
        dateTime: _selectedDate,
        weight: _weight.toDouble(),
        note: _noteController.text,
        photoUrl: photoUrl);
    _controller.addRecord(newRecord);
    Get.back();
  }

  Future<File?> captureSaveImage() async {
    final XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 200);
    print(pickedImage!.name);
    print(pickedImage.path);

    if (pickedImage == null) return null;

    _imageFile = File(pickedImage.path);
    // check if exists
    print('image from camera exists ? : ${_imageFile!.existsSync()}');

    // getting a directory path for saving
    final Directory extDir = await getApplicationDocumentsDirectory();
    String dirPath = extDir.path;
    print('application directory to save images: ${extDir.path}');


    // set image name from DateTime
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    final String filePath = '$dirPath/$imageName.jpg';
    print(filePath);

    // copy the file to a new path
    final File newImage = await _imageFile!.copy(filePath);
    setState(() {
      print('setstate called');
      _imageFile = newImage;
    });
    print('image copy on $filePath ? : ${newImage.existsSync()}');

    // save photoUrl to state variable
    photoUrl = filePath;
    print('File(photoUrl!).existsSync() : ${File(photoUrl!).existsSync()}');

  }

  Future<File?> captureSaveImageToExternalStorage() async {
    final XFile? pickedImage = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 200);
    //print(pickedImage!.name);
    //print(pickedImage.path);

    if (pickedImage == null) return null;

    //_imageFile = File(pickedImage.path);
    // check if exists
    //print('image from camera exists ? : ${_imageFile!.existsSync()}');

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    //String imageName = 'test';
    File newImageFile;
    try {
      final directory = await getExternalStorageDirectory();
      if (directory != null)
        _imageFile = await File(pickedImage.path).copy('${directory.path}/$imageName.jpg');

    } catch (e) {
      return null;
    }


    setState(() {

    });
    //print('image copy on $filePath ? : ${newImage.existsSync()}');

    // save photoUrl to state variable
    photoUrl = _imageFile!.path;
    print('File(photoUrl!).existsSync() : ${File(photoUrl!).existsSync()}');
    print(photoUrl);

  }

}
