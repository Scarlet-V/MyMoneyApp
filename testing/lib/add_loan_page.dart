import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/painting/image_provider.dart';
import 'package:testing/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';




class AddNewLoan extends StatefulWidget {
  @override
  _AddNewLoanState createState() => _AddNewLoanState();
}

class _AddNewLoanState extends State<AddNewLoan> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      color: Theme.of(context).primaryColor,
      home: Scaffold(
          body: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text('Loan Name',
                  style: TextStyle(
                    fontSize: 30,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text('Loan Name'),
                ),

            ],
          ),
          appBar: AppBar(
            title: const Text('Add New Loan'),
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
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.account_circle_sharp,
                  color: Colors.white,
                ),
                onPressed: () {},

                // child: const Text('Launch screen'),
              ),
            ],
          )
      ),
    );
  }
}