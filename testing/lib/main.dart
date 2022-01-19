import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var _incomeAmountController = new TextEditingController();
  String income = '';
  //late var balance = 3500 - ${bill.monthlyPayment} - ${loan.monthlyPayment} - ${creditcard.monthlyPayment};


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
  void initState(){
    super.initState();
    _incomeAmountController = TextEditingController();
  }
  @override
  void dispose(){
    _incomeAmountController.dispose();
        super.dispose();
  }

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
      body: Container(
      padding: EdgeInsets.only(left: 16, top: 20, right: 16),
        child: Column(
          children:[
            Container(
              padding: EdgeInsets.only(  right: 16),
                child: Row(
                  children: [
                    Expanded(child: Text("Income: ",
                    style: TextStyle(fontSize: 30),
                    ),
                    ),
                    const SizedBox(width: 12),
                      Text('\u0024${income}',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.green
                      ),),
                  ],
                ),
            ),
            Container(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                  onPressed: () async {
                    final income = await openDialog();
                    if (income == null || income.isEmpty) return;
                    setState(() => this.income = income);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  label: const Text('Input your income', style: TextStyle(color: Colors.green),)
              ),
              ),),
            Container(
            //padding:
            //    if(bill = null){
             //       padding: EdgeInsets.only(bottom: 10)}
             //   else{
             //   padding: EdgeInsets.only(bottom: 0) },
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Bills',
                  style: TextStyle(
                      fontSize: 30,
                ),
          ),
        ),),
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
            // balance = income - ${bill.monthlyPayment} - ${loan.monthlyPayment} - ${creditcard.monthlyPayment}
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
                  label: const Text('Add new bill', style: TextStyle(color: Colors.green),)
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Credit Cards',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),),
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
                        label: const Text('Add new credit card', style: TextStyle(color: Colors.green))
                    ),
                  ),
            Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Align(
              alignment: Alignment.topLeft,
              child: Text('Loans',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),),

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
                  label: const Text('Add new loan', style: TextStyle(color: Colors.green))
              ),
            ),
            ],
          ),
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
  Future<String?> openDialog() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Your Income"),
        content: TextField(
          controller: _incomeAmountController,
          autofocus: true,
          decoration: InputDecoration(hintText: "Enter your income here",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),  ),
        ),
        actions: [
          TextButton(
            child: Text('SUBMIT',
              style: TextStyle(
                color: Colors.green,
              ),),
            onPressed: submit,
            ),

        ],
      ),
  );
  void submit(){
    Navigator.of(context).pop(_incomeAmountController.text);
  }
}

