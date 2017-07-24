import 'package:flutter/material.dart';

class Third extends StatelessWidget {
  //shows off Stack
  //Stacks usually don't fill up a whole screen. They are more generally used for designing things like Cards  (photo with title on top and stuff)
  //TODO: Look into CustomMultiChildLayout
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Positioned.fill(
          child: new Container(
            child: new Text(
                "Page Three"
            ),
            color: Colors.red,
          ),
        ),
        new Positioned(
          bottom: 10.0,
          child: new Container(
            child: new Text(
              "Page Three"
            ),
            color: Colors.blue,
            padding: new EdgeInsets.all(30.0),
          ),
        ),
        new Positioned(
            child: new Container(
              child: new Text(
                  "Page Three"
              ),
              color: Colors.green,
              padding: new EdgeInsets.all(40.0),
            ),
          top: 20.0
        ),
        new Positioned(
          child: new Container(
            child: new Text(
                "Page Three"
            ),
            color: Colors.yellow,
            padding: new EdgeInsets.all(40.0),
          ),
          right: 0.0,
          bottom: 0.0,
        ),

      ],
    );
  }
}