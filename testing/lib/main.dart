import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/models/creditcard.dart';
import 'package:testing/profile_page.dart';
import 'package:testing/themes.dart';
import 'package:testing/add_loan_page.dart';
import 'package:testing/add_new_bill.dart';
import 'package:testing/add_new_creditcard.dart';
import 'models/load.dart';
import 'models/bills.dart';
import 'models/creditcard.dart';
import 'package:intl/intl.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

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
  final List<Bill> bills = [];
  final List<CreditCard> creditcards = [];
  var _incomeAmountController = new TextEditingController();
  double income = 0;
  int percentageToSave = 0;
  double amountToSave = 0;
  double amountToSpend = 0;

  void _calculateAndUpdate() {
    double loan = 0, bill = 0, creditCard = 0;
    loans.forEach((e) {
      loan += e.monthlyPayment;
    });
    bills.forEach((e) {
      bill += e.monthlyPayment;
    });
    creditcards.forEach((e) {
      creditCard += e.monthlyPayment;
    });
    double monthlyPay = loan + bill + creditCard;
    amountToSave = (income - monthlyPay) * percentageToSave * 0.01;
    amountToSpend = (income - monthlyPay) - amountToSave;
    setState(() {});
  }

  void addNewLoad(Loan loan) {
    loans.add(loan);
    _calculateAndUpdate();
  }

  void addNewBill(Bill bill) {
    bills.add(bill);
    _calculateAndUpdate();
  }

  void addNewCreditCard(CreditCard creditcard) {
    creditcards.add(creditcard);
    _calculateAndUpdate();
  }

  void loadPercentageToSave() async {
    final ssp = await StreamingSharedPreferences.instance;
    final ptsPref = ssp.getInt('percentage_to_save', defaultValue: 0);
    ptsPref.listen((value) {
      percentageToSave = value;
      _calculateAndUpdate();
    });
  }

  @override
  void initState() {
    super.initState();
    _incomeAmountController = TextEditingController();

    loadPercentageToSave();
  }

  @override
  void dispose() {
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
            children: [
              Container(
                padding: EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Income: ",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${NumberFormat.currency(locale: 'en_US', symbol: '\$').format(income)}',
                      style: TextStyle(fontSize: 30, color: Colors.green),
                    ),
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
                        final parsedIncome = double.tryParse(income);
                        if (parsedIncome != null) {
                          this.income = parsedIncome;
                          _calculateAndUpdate();
                        }
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      label: const Text(
                        'Input your income',
                        style: TextStyle(color: Colors.green),
                      )),
                ),
              ),
              Container(
                //padding:
                //    if(bill = null){
                //       padding: EdgeInsets.only(bottom: 10)}
                //   else{
                //   padding: EdgeInsets.only(bottom: 0) },
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Bills',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              for (final bill in bills)
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: bill.name),
                        TextSpan(text: ' : '),
                        TextSpan(text: "("),
                        TextSpan(
                            text: NumberFormat.currency(
                                    locale: 'en_US', symbol: '\$')
                                .format(bill.total),
                            style: TextStyle(color: Colors.red)),
                        TextSpan(text: ") "),
                        TextSpan(
                            text: NumberFormat.currency(
                                    locale: 'en_US', symbol: '\$')
                                .format(bill.monthlyPayment),
                            style: TextStyle(color: Colors.red))
                      ],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              // balance = income - ${bill.monthlyPayment} - ${loan.monthlyPayment} - ${creditcard.monthlyPayment}
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                    onPressed: () async {
                      dynamic bill =
                          await Navigator.pushNamed(context, '/third');
                      if (bill != null && bill is Bill) {
                        addNewBill(bill);
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    label: const Text(
                      'Add new bill',
                      style: TextStyle(color: Colors.green),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Credit Cards',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              for (final creditcard in creditcards)
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: creditcard.name),
                        TextSpan(text: ' : '),
                        TextSpan(text: "("),
                        TextSpan(
                            text: NumberFormat.currency(
                                    locale: 'en_US', symbol: '\$')
                                .format(creditcard.total),
                            style: TextStyle(color: Colors.red)),
                        TextSpan(text: ") "),
                        TextSpan(
                            text: NumberFormat.currency(
                                    locale: 'en_US', symbol: '\$')
                                .format(creditcard.monthlyPayment),
                            style: TextStyle(color: Colors.red))
                      ],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                    onPressed: () async {
                      dynamic creditcard =
                          await Navigator.pushNamed(context, '/fourth');
                      if (creditcard != null && creditcard is CreditCard) {
                        addNewCreditCard(creditcard);
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    label: const Text('Add new credit card',
                        style: TextStyle(color: Colors.green))),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Loans',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),

              for (final loan in loans)
                Align(
                  alignment: Alignment.topLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: loan.name),
                        TextSpan(text: ' : '),
                        TextSpan(text: "("),
                        TextSpan(
                            text: NumberFormat.currency(
                                    locale: 'en_US', symbol: '\$')
                                .format(loan.total),
                            style: TextStyle(color: Colors.red)),
                        TextSpan(text: ") "),
                        TextSpan(
                            text: NumberFormat.currency(
                                    locale: 'en_US', symbol: '\$')
                                .format(loan.monthlyPayment),
                            style: TextStyle(color: Colors.red))
                      ],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                    onPressed: () async {
                      dynamic loan =
                          await Navigator.pushNamed(context, '/fifth');
                      if (loan != null && loan is Loan) {
                        addNewLoad(loan);
                      }
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    label: const Text('Add new loan',
                        style: TextStyle(color: Colors.green))),
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
                    title: new Text("Available to spend: "),
                    subtitle: new Text(
                        NumberFormat.currency(locale: 'en_US', symbol: '\$')
                            .format(amountToSpend)),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    textColor: Colors.blue,
                    title: new Text("Amount to save: "),
                    subtitle: new Text(
                        NumberFormat.currency(locale: 'en_US', symbol: '\$')
                            .format(amountToSave)),
                  ),
                ),
              ],
            )),
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
            decoration: InputDecoration(
              hintText: "Enter your income here",
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'SUBMIT',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              onPressed: submit,
            ),
          ],
        ),
      );
  void submit() {
    Navigator.of(context).pop(_incomeAmountController.text);
  }
}
