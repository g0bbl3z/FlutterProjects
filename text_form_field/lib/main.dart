//This is the first project since flutter upgraded to dart 2.0
//3-22-2018
//Other projects may need updating, but I believe they should still work even though they are outdated
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Text Form Fields Demo',
      theme: new ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: new InputBox(),
    );
  }
}

class InputBox extends StatefulWidget {
  @override
  InputBoxState createState() => InputBoxState();
}

class InputBoxState extends State<InputBox> {
  bool loggedIn = false;
  String _email, _username, _password;

  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: mainKey,
      appBar: AppBar(title: new Text("Text Form Fields Demo")), //AppBar
      body: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: loggedIn == false ? new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new TextFormField(
                autocorrect: false,
                decoration: new InputDecoration(labelText: "Enter email:"),
                onSaved: (str) => _email = str,
                validator: (str) =>
                !str.contains('@')
                    ? "Not a valid email!"
                    : null, //Could and Should make more complicated validators
              ),
              //Validators run when Validate() is called. If anything besides null is returned, then it does not validate
              new TextFormField(
                autocorrect: false,
                onSaved: (str) => _username = str,
                decoration: new InputDecoration(labelText: "Enter Username:"),
                validator: (str) =>
                str.length < 6
                    ? "Not a valid Username!"
                    : null,
              ),
              new TextFormField(
                autocorrect: false,
                onSaved: (str) => _password = str,
                decoration: new InputDecoration(labelText: "Enter Password:"),
                validator: (str) =>
                str.length < 8
                    ? "Not a valid password!"
                    : null,
                obscureText: true,
              ),
              new RaisedButton(
                child: new Text("Log In"),
                onPressed: onPressed, //Do not put () when you don't want the method to run when the app is opened
              ),
            ],
          ), //Column
        ) : new Center( //Form
          child: Column(
            children: <Widget>[
              new Text("Welcome $_username"),
              new RaisedButton(
                child: new Text("Logout"),
                onPressed: () {
                  setState(() {
                    loggedIn = false;
                  });
                },
              ),
            ],
          ), //Column
        ), // Center
      ), //Padding
    ); //Scaffold
  } //InputBoxState build()

  void onPressed() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        loggedIn = true;
      });
    }
    var snackBar = new SnackBar(
      duration: new Duration(milliseconds: 5000),
      content: new Text(
          'Username: $_username, Email: $_email, Password: $_password'
      ), //Text
    ); //SnackBar

    mainKey.currentState.showSnackBar(snackBar);
  }
}