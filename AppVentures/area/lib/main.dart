import 'package:flutter/material.dart';
import 'squarePage.dart';
import 'trianglePage.dart';
import 'circlePage.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  var routes = <String, WidgetBuilder>{
    squarePage.routeName: (BuildContext context) => new squarePage(),
    trianglePage.routeName: (BuildContext context) => new trianglePage(),
    circlePage.routeName: (BuildContext context) => new circlePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppVenturesArea',
      home: homePage(title: 'AppVentures Area'),
      routes: routes,
    );
  }
}

class homePage extends StatefulWidget {
  homePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  @override
  Widget build(BuildContext context) {
    double scale = .75;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                "Select a Shape!",
                style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              margin: EdgeInsets.all(25.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                  child: GestureDetector(
                    child: Image.asset('assets/square.png', scale: scale),
                    onTap: () {Navigator.pushNamed(context, squarePage.routeName);},
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                  child: GestureDetector(
                    child: Image.asset('assets/circle.png', scale: scale),
                    onTap: () {Navigator.pushNamed(context, circlePage.routeName);},
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                  child: GestureDetector(
                    child: Image.asset('assets/triangle.png', scale: scale),
                    onTap: () {Navigator.pushNamed(context, trianglePage.routeName);},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
