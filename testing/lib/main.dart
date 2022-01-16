import 'package:flutter/material.dart';
import 'package:testing/profile_page.dart';
import 'package:testing/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(
    MaterialApp(
      title: 'MyMoney',
      // Start the app with the "/" named route. In this case, the app starts
      // on the FirstScreen widget.
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => EditProfilePage(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
              child: Text('Loans',
                  style: TextStyle(
                      fontSize: 30,
                      //fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                ),
          ),
        ),
            Align(
              alignment: Alignment.topLeft,
            child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                      Icons.add,
                    color: Colors.white,
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
            )
            ),
        );
  }
}

Widget buildInsertButton() => RaisedButton(
    child: Text('Add new loan',
    style: TextStyle(fontSize: 20)
    ),
    onPressed: (){}
);
