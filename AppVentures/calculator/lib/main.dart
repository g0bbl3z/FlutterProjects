import 'package:flutter/material.dart';

//TODO: Still need to understand Layouts better

void main() => runApp(new CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new calcHomePage(),
    );
  }
}

class calcHomePage extends StatefulWidget {
  @override
  _calcHomePageState createState() => new _calcHomePageState();
}

class _calcHomePageState extends State<calcHomePage> {

  String num1 = null;
  String num2 = null;
  String operator = "";
  String disp = "";

  setNum(String n) {
    print("Test " + n);
    if (operator.isEmpty) { //if still working on num1
      if (num1 == null) {
        num1 = n;
      }
      else {
        num1 += n;
      }
      disp = num1;
    }
    else {
      if (num2 == null) {
        num2 = n;
      }
      else {
        num2 += n;
      }
      disp = num1 + operator + num2;
    }
    setState(() {});
  }

  setOperator(String oper) {
    if(num2 == null ) {
      operator = oper;
      disp = num1 + " " + oper + " ";
      setState(() {});
    }
    else {
      calculate();
      disp = num1;
    }
    setState(() {});
  }

  calculate() {
    if(num1 == null) {
      return;
    }
    switch(operator) {
      case "*" : num1 = (double.tryParse(num1) * double.tryParse(num2)).toString();
        break;
      case "/" : num1 = (double.tryParse(num1) / double.tryParse(num2)).toString();
        break;
      case "+" : num1 = (double.tryParse(num1) + double.tryParse(num2)).toString();
        break;
      case "-" : num1 = (double.tryParse(num1) - double.tryParse(num2)).toString();
       break;
    }
    num2 = null;
    disp = num1;
    setState(() {});
  }

  clear() {
    num1 = null;
    num2 = null;
    operator = "";
    disp = "";
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calculator")),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(child: Text(disp)),
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                numButton("7"),
                numButton("8"),
                numButton("9"),
                opButton("*"),
              ],
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                numButton("4"),
                numButton("5"),
                numButton("6"),
                opButton("/"),
              ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              numButton("1"),
              numButton("2"),
              numButton("3"),
              opButton("+"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              numButton("0"),
              Spacer(),
              numButton("."),
              opButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Spacer(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(2.0),
                  height: buttonSize,
                  child: RaisedButton(onPressed: calculate, child: Text("=")),
                )
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                    margin: EdgeInsets.all(2.0),
                    height: buttonSize/2.0,
                    child: RaisedButton(onPressed: clear, child: Text("Clear")),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }

  double buttonSize = 80.0;

  Widget numButton(String number) {
    return Flexible(
      fit: FlexFit.loose,
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(2.0),
        height: buttonSize,
        child: RaisedButton(
          child: Text(number),
          onPressed: () => setNum(number),
        ),
      ),
    );
  }

  Widget opButton(String oper) {
    return Flexible(
      fit: FlexFit.loose,
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(2.0),
        height: buttonSize,
        child: RaisedButton(
          child: Text(oper),
          onPressed: () => setOperator(oper),
        ),
      )
    );
  }

}