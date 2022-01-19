import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/painting/image_provider.dart';
import 'package:testing/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'models/bills.dart';





class AddNewBill extends StatefulWidget {
  @override
  _AddNewBillState createState() => _AddNewBillState();
}

class _AddNewBillState extends State<AddNewBill> {
  var _billNameController = new TextEditingController();
  var _billAmountController = new TextEditingController();
  var _billMonthlyController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      color: Theme.of(context).primaryColor,
      home: Scaffold(
          body: new ListView(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              new ListTile(
                title: new TextField(
                  decoration: InputDecoration(
                    labelText: "Bill Name",
                    labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),

                  controller: _billNameController,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              new ListTile(
                title: new TextField(
                  decoration: InputDecoration(
                      labelText: "Total Bill Amount",
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      )
                  ),
                  controller: _billAmountController,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              new ListTile(
                title: new TextField(
                  decoration: InputDecoration(
                      labelText: "Monthly Bill Payment",
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      )
                  ),
                  controller: _billMonthlyController,
                ),
              ),
              SizedBox(
                height:250,
              ),
              new ListTile(
                title: new RaisedButton(
                  child: new Text("Save",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white),
                  ),
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: (){
                    final bill = Bill(_billNameController.text, _billAmountController.text, _billMonthlyController.text);
                    Navigator.of(context).pop(bill);
                  },
                ),
              ),
            ],
          ),
          appBar: AppBar(
            title: const Text('Add New Bill'),
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