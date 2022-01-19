import 'dart:core';
import 'package:flutter/material.dart';
import 'package:testing/models/creditcard.dart';
import 'package:testing/profile_page.dart';
import 'package:testing/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/add_loan_page.dart';
import 'package:testing/add_new_bill.dart';
import 'package:testing/add_new_creditcard.dart';
import 'models/load.dart';
import 'models/bills.dart';
import 'models/creditcard.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'MyMoney',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => EditProfilePage(),
        '/third': (context) => AddNewBill(),
        '/fourth': (context) => AddNewCreditCard(),
        '/fifth': (context) => AddNewLoan(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  HomePage({Key? key}) : super(key: key);


}
class _HomePageState extends State<HomePage> {

  final List<Loan> loans = [];
  final List<Bill>  bills= [];
  final List<CreditCard> creditcards=[];

  void addNewLoad(Loan loan){
    setState(() {
      loans.add(loan);
    });
  }
  void addNewBill(Bill bill){
    setState(() {
      bills.add(bill);
    });
  }
  void addNewCreditCard(CreditCard creditcard){
    setState(() {
      creditcards.add(creditcard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      color: Theme.of(context).primaryColor,
      home: Scaffold(
        body: Column(
          children:[
            Align(
              alignment: Alignment.topLeft,
              child: Text('Bills',
                  style: TextStyle(
                      fontSize: 30,
                    decoration: TextDecoration.underline,
                ),
          ),
        ),
            for (final bill in bills)
              Align(
                alignment: Alignment.topLeft,
                child:
                new Text("${bill.name}: (\u0024${bill.total}) \u0024${bill.monthlyPayment}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton.icon(
                  onPressed: () async {
                    dynamic bill = await Navigator.pushNamed(context, '/third');
                    if(bill != null && bill is Bill){
                      addNewBill(bill);
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  label: const Text('Add new bill')
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Credit Cards',
                style: TextStyle(
                  fontSize: 30,
                  //fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            for (final creditcard in creditcards)
              Align(
                alignment: Alignment.topLeft,
                child:
                new Text("${creditcard.name}: (\u0024${creditcard.total}) \u0024${creditcard.monthlyPayment}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Align(
              alignment: Alignment.topLeft,
              child: TextButton.icon(
                  onPressed: () async {
                    dynamic creditcard = await Navigator.pushNamed(context, '/fourth');
                    if(creditcard != null && creditcard is CreditCard){
                      addNewCreditCard(creditcard);
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  label: const Text('Add new credit card')
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text('Loans',
                style: TextStyle(
                  fontSize: 30,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),

            for (final loan in loans)
              Align(
              alignment: Alignment.topLeft,
              child:
              new Text("${loan.name}: (\u0024${loan.total}) \u0024${loan.monthlyPayment}",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
              ),
            ),
            ),



            Align(
              alignment: Alignment.topLeft,
              child: TextButton.icon(
                  onPressed: () async {
                    dynamic loan = await Navigator.pushNamed(context, '/fifth');
                    if(loan != null && loan is Loan){
                      addNewLoad(loan);
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  label: const Text('Add new loan')
              ),
            ),
            ],
          ),
        appBar: AppBar(
          title: const Text('My Money'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.account_circle_sharp,
                color: Colors.white,
              ),
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.pushNamed(context, '/second');
              },

              // child: const Text('Launch screen'),
            ),
      ],
            ),
          bottomNavigationBar: new Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    textColor: Colors.green,
                    title: new Text("Balance: "),
                    subtitle: new Text("\$230"),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    textColor: Colors.blue,
                    title: new Text("Saving: "),
                    subtitle: new Text("\$130"),
                  ),
                ),
              ],
            )
          ),
            ),
        );
  }
}

Widget buildInsertButton() => ElevatedButton(
    child: Text('Add new loan',
    style: TextStyle(fontSize: 20)
    ),
    onPressed: (){}
);
