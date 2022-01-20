import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/models/load.dart';
import 'package:testing/themes.dart';

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
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.space): ActivateIntent(),
      },
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
                        color: Colors.black),
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
                          color: Colors.black)),
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
                          color: Colors.black)),
                  controller: _loanMonthlyController,
                ),
              ),
              SizedBox(
                height: 250,
              ),
              new ListTile(
                title: new RaisedButton(
                  child: new Text(
                    "Save",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  ),
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {
                    final totalParsed =
                        double.tryParse(_loanAmountController.text);
                    final monthlyParsed =
                        double.tryParse(_loanMonthlyController.text);
                    if (totalParsed != null && monthlyParsed != null) {
                      final loan = Loan(
                          _loanNameController.text, totalParsed, monthlyParsed);
                      Navigator.of(context).pop(loan);
                    }
                    ;
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
          )),
    );
  }
}
