import 'package:flutter/material.dart';

class squarePage extends StatefulWidget {
  squarePage({Key key, this.title}) : super(key: key);
  final String title;
  static final String routeName = "square";
  @override
  squarePageState createState() => squarePageState();
}

class squarePageState extends State<squarePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Square Area")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Center(
                child: GestureDetector(
                  child: Image.asset('assets/square.png', scale: .65),
//                  onTap: clear,
                ),
            ),
            ),

          ],
        ),
    );
  }
}