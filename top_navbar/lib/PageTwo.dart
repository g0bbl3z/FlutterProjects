import 'package:flutter/material.dart';

class Second extends StatelessWidget {
//Shows off Row
  @override
  Widget build(BuildContext context){
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new Container(
            decoration: new BoxDecoration(
              border: new Border.all(),
              color: Colors.red,
            ),
            child: new Center(
              child: new Icon(Icons.threesixty)
            ),
            constraints: new BoxConstraints.expand(),

          )

        ),
        new Expanded(
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.green,
                border: new Border.all(),
              ),
              child: new Center(
                  child: new Icon(Icons.threesixty)
              ),
              constraints: new BoxConstraints.expand(),
            )

        ),
        new Expanded(
            child: new Container(
              decoration: new BoxDecoration(
                color: Colors.blue,
                border: new Border.all(),
              ),
              child: new Center(
                  child: new Icon(Icons.threesixty)
              ),
              constraints: new BoxConstraints.expand(),
            )

        ),
      ],
    );
  }
}