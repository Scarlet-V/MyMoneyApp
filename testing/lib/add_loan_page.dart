import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/painting/image_provider.dart';
import 'package:testing/main.dart';
import 'package:testing/models/load.dart';
import 'package:testing/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/add_new_bill.dart';




class AddNewLoan extends StatefulWidget {
  @override
  _AddNewLoanState createState() => _AddNewLoanState();
}

class _AddNewLoanState extends State<AddNewLoan> {
  var _loanNameController = new TextEditingController();
  var _loanAmountController = new TextEditingController();
  var _loanMonthlyController = new TextEditingController();

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
                        labelText: "Loan Name",
                        labelStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),
                    ),

                  controller: _loanNameController,
                          ),
                          ),
              SizedBox(
                height: 30,
              ),
              new ListTile(
                title: new TextField(
                  decoration: InputDecoration(
                      labelText: "Total Loan Amount",
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      )
                  ),
                  controller: _loanAmountController,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              new ListTile(
                title: new TextField(
                  decoration: InputDecoration(
                    labelText: "Monthly Loan Payments",
                      labelStyle: TextStyle(
                        fontSize: 20,
                          fontWeight: FontWeight.w500,
                        color: Colors.black
                      )
                  ),
                  controller: _loanMonthlyController,
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
                final loan = Loan(_loanNameController.text, _loanAmountController.text, _loanMonthlyController.text);
               /* var route = new MaterialPageRoute(
                    builder: (BuildContext context) => new HomePage(value: , totalloanamount: , loanmonthlypayment: ),
                      //billname: _billNameController.text, totalbillamount: _billAmountController.text, billmonthlypayment: _billMonthlyController.text,),
                );*/
                Navigator.of(context).pop(loan);
                },
          ),
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

  Widget _loanInformationForm(){
    return Column(
      children: [
        Text("New Loan",
            style: Theme.of(context).textTheme.headline4),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, left:30.0, right: 30.0),
          child: TextField(
            decoration: InputDecoration(
              helperText: 'Loan Name',
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: _loanNameController,
          ),
        ),
        ElevatedButton(
            onPressed: (){
              setState(() {
               // _answer = _getAnswer();
              }
              );
            },
            child: Text("Save"),
    ),
        //_questionAndAnswer()
      ],
    );
  }
}