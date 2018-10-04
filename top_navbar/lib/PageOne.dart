import 'package:flutter/material.dart';

class First extends StatelessWidget {
//Shows off Column
  @override
  Widget build(BuildContext context){
      return new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: new Container(
                decoration: new BoxDecoration(
                  border: new Border.all(),
                  color: Colors.red,
                ),
                constraints: new BoxConstraints.expand(),
                child: new Center(
                  child: new RaisedButton(onPressed: () => print("Test"),child: new Text("Page One")),
                ),
              ),
            ),
            new Expanded(
              child: new Container(
                decoration: new BoxDecoration(
                  border: new Border.all(),
                  color: Colors.green,
                ),
                constraints: new BoxConstraints.expand(),
                child: new Center(
                  child: new Text("Page One"),
                ),
              ),
            ),
            new Expanded(
              child: new Container(
                decoration: new BoxDecoration(
                  border: new Border.all(),
                  color: Colors.blue,
                ),
                constraints: new BoxConstraints.expand(),
                child: new Center(
                  child: new Text("Page One"),
                ),
              ),
            ),
          ],
      );
  }
}