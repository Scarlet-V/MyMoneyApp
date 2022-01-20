import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/creditcard.dart';




class AddNewCreditCard extends StatefulWidget {
  @override
  _AddNewCreditCardState createState() => _AddNewCreditCardState();
}

class _AddNewCreditCardState extends State<AddNewCreditCard> {
  var _creditcardNameController = new TextEditingController();
  var _creditcardAmountController = new TextEditingController();
  var _creditcardMonthlyController = new TextEditingController();

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
                    labelText: "Credit Card Name",
                    labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),

                  controller: _creditcardNameController,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              new ListTile(
                title: new TextField(
                  decoration: InputDecoration(
                      labelText: "Total Credit Card Debt Amount",
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      )
                  ),
                  controller: _creditcardAmountController,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              new ListTile(
                title: new TextField(
                  decoration: InputDecoration(
                      labelText: "Monthly Credit Card Payment",
                      labelStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      )
                  ),
                  controller: _creditcardMonthlyController,
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

                final totalParsed = double.tryParse(_creditcardAmountController.text);
                final monthlyParsed = double.tryParse(_creditcardMonthlyController.text);
                if(totalParsed != null && monthlyParsed != null){
                final creditcard =
                CreditCard(_creditcardNameController.text, totalParsed, monthlyParsed);
                Navigator.of(context).pop(creditcard);
                  };
                  },
                ),
              ),
            ],
          ),
          appBar: AppBar(
            title: const Text('Add New Credit Card Bill'),
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