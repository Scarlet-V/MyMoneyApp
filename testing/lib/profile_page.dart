import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/painting/image_provider.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:testing/themes.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  File? _image;
  String _myPaycheck = '';
  String _myActualPaycheck = '';
  final formKey = new GlobalKey<FormState>();
  String? _selectedValue;
  List<String> listofValue = [
    'Bi-Monthly',
    'Monthly',
    'Weekly',
    'Daily',
    'Yearly'
  ];
  final _percentageToSaveController = new TextEditingController();

  int percentageToSave = 0;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this._image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _myPaycheck = '';
    _myActualPaycheck = '';
    loadPercentageToSave();
  }

  void loadPercentageToSave() async {
    final ssp = await StreamingSharedPreferences.instance;
    final percentageToSavePref =
        ssp.getInt('percentage_to_save', defaultValue: 0);
    percentageToSave = percentageToSavePref.getValue();
    _percentageToSaveController.text = percentageToSave.toString();
  }

  void savePercentageToSave() async {
    final newPercentage = int.tryParse(_percentageToSaveController.text);
    final ssp = await StreamingSharedPreferences.instance;
    if (newPercentage != null) {
      ssp.setInt('percentage_to_save', newPercentage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        color: Theme.of(context).primaryColor,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            elevation: 1,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: _image == null
                                  ? NetworkImage(
                                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png')
                                  : FileImage(_image!) as ImageProvider,
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.green,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () => pickImage(),
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  buildTextField("Full Name"),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: TextField(
                      onChanged: (String value) {
                        final temp = int.tryParse(value);
                        if (temp != null) {
                          percentageToSave = temp;
                        }
                      },
                      controller: _percentageToSaveController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 3),
                        labelText: "Percent Of Income To Save",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                        labelStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  // buildTextField(Percent Of Income To Sav"e"),
                  //buildTextField("Paycheck"),
                  Container(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Column(
                      children: <Widget>[
                        DropdownButtonFormField(
                          value: _selectedValue,
                          decoration: InputDecoration(
                              labelText: "Income",
                              hintText: 'Choose your paycheck type'),
                          items: listofValue.map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(
                                val,
                              ),
                            );
                          }).toList(),
                          isExpanded: true,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                        child: Text("CANCEL",
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                            )),
                      ),
                      RaisedButton(
                        onPressed: () {
                          savePercentageToSave();
                        }, // _saveForm,
                        //add to where it will save user information
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    child: Text(_myActualPaycheck),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildTextField(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
