import 'package:flutter/material.dart';
import 'squarePage.dart';
import 'circlePage.dart';

class trianglePage extends StatefulWidget {
  trianglePage({Key key, this.title}) : super(key: key);
  final String title;
  static final String routeName = "triangle";
  @override
  trianglePageState createState() => trianglePageState();
}

class trianglePageState extends State<trianglePage> {
  TextEditingController baseController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    baseController.dispose();
    heightController.dispose();
  }

  String area = "";

  void clear() {
    setState(() {
      area = "";
      baseController.text = "";
      heightController.text = "";
    });
  }

  void calculate() {
    try {
      double base = double.tryParse(baseController.text);
      double height = double.tryParse(heightController.text);
      setState(() {
        area = ((base*height)/2.0).toStringAsFixed(2);
      });
    }
    catch(Exception) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Triangle Area")),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8.0, bottom: 32.0),
            child: Center(
              child: GestureDetector(
                child: Image.asset('assets/triangle.png', scale: .65),
                  onTap: clear,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child:
                      Text("Base length:", style: TextStyle(fontSize: 20.0))),
              Flexible(
                child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: 250.0,
                    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                    child: TextField(controller: baseController)),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child:
                  Text("Height length:", style: TextStyle(fontSize: 20.0))),
              Flexible(
                child: Container(
                    decoration: BoxDecoration(border: Border.all()),
                    width: 250.0,
                    margin: EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(controller: heightController)),
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
                        Text("Area of Triangle: ", style: TextStyle(fontSize: 20.0)),
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
                  child: Image.asset('assets/square.png', scale: .6),
                    onTap: () {Navigator.popAndPushNamed(context, squarePage.routeName);},
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
