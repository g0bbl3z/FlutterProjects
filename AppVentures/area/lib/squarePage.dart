import 'package:flutter/material.dart';
import 'trianglePage.dart';
import 'circlePage.dart';

class squarePage extends StatefulWidget {
  squarePage({Key key, this.title}) : super(key: key);
  final String title;
  static final String routeName = "square";
  @override
  squarePageState createState() => squarePageState();
}

class squarePageState extends State<squarePage> {
  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  String area = "";

  void clear() {
    setState(() {
      area = "";
      controller.text = "";
    });
  }

  void calculate() {
    try {
      double side = double.tryParse(controller.text);
      setState(() {
        area = (side*side).toStringAsFixed(2);
      });
    }
    catch(Exception) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Square Area")),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 32.0),
            child: Center(
              child: GestureDetector(
                child: Image.asset('assets/square.png', scale: .65),
                  onTap: clear,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child:
                      Text("Side length:", style: TextStyle(fontSize: 20.0))),
              Flexible(
                child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: 250.0,
                    margin: EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(controller: controller)),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: RaisedButton(
                    child: Text("Calculate!"),
                    padding: EdgeInsets.all(40.0),
                    onPressed: calculate,
                  ),
                ),
                Expanded(
                    child: Column(
                      children: <Widget>[
                        Text("Area of Square: ", style: TextStyle(fontSize: 20.0)),
                        Text(area, style: TextStyle(fontSize: 20.0), textScaleFactor: 2.0, overflow: TextOverflow.fade,),
                      ],
                  ),
                ),

              ],
            ),
          ),
          Container(margin: EdgeInsets.symmetric(vertical: 16.0), child: Center(child: Text("Select a Different Shape!", style: TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic), textScaleFactor: 2.0,))),
          Container(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                child: GestureDetector(
                  child: Image.asset('assets/circle.png', scale: .6),
                    onTap: () {Navigator.popAndPushNamed(context, circlePage.routeName);},
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                child: GestureDetector(
                  child: Image.asset('assets/triangle.png', scale: .6),
                    onTap: () {Navigator.popAndPushNamed(context, trianglePage.routeName);},
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
