import 'package:flutter/material.dart';
import 'package:flutter_screens_test/login_screen_1.dart';
import 'package:flutter_screens_test/login_screen_2.dart';
import 'package:flutter_screens_test/login_screen_3.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Login Screen 1',
//      theme: new ThemeData(
//          primarySwatch: Colors.green,
//          accentColor: Colors.amber[800],
//          backgroundColor: Colors.white70,
//          textTheme: TextTheme(
//              button: TextStyle(color: Colors.black),
//              body1: TextStyle(color: Colors.black),
//              display1: TextStyle(color: Colors.black),
//              display4: TextStyle(color: Colors.black),
//              headline: TextStyle(color: Colors.black)),
//    theme: new ThemeData(
//      primarySwatch: Colors.green,
//      accentColor: Colors.amber[800],
//      backgroundColor: Colors.black87,
//      textTheme: TextTheme(
//          button: TextStyle(color: Colors.white),
//          body1: TextStyle(color: Colors.white),
//          display1: TextStyle(color: Colors.white),
//          display4: TextStyle(color: Colors.white),
//          headline: TextStyle(color: Colors.white)),
//    ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new SingleChildScrollView(
//        child: LoginScreen1(
//          primaryColor: Theme.of(context).primaryColor,
//          backgroundColor: Theme.of(context).backgroundColor,
//          accentColor: Theme.of(context).accentColor,
//          foregroundColor: Theme.of(context).textTheme.display4.color,
//        ),
//        child: LoginScreen2(
//          gradientLeft: Theme.of(context).backgroundColor,
//          gradientRight: Theme.of(context).primaryColor,
//          highlightColor: Theme.of(context).accentColor,
//          foregroundColor: Theme.of(context).textTheme.display4.color,
//          logo: new AssetImage("assets/images/mountains.jpeg"),
//        ),
          child: LoginScreen3()
      ),
    );
  }
}
