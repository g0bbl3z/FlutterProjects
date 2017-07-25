import 'package:flutter/material.dart';
import 'shoppingHome.dart';
import 'cart.dart';


void main() {
  runApp(new ShoppingApp());
}
class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    var routes = <String, WidgetBuilder>{
      cartPage.routeName: (BuildContext context) => new cartPage(),
    };
    ThemeData defaultTheme = new ThemeData(
      primaryColor: Colors.blue[400],
    );
    ThemeData darkTheme = new ThemeData(
      primaryColor: Colors.purple,
    );
    return new MaterialApp(
      title: "Shopping App",
      theme: defaultTheme,
      home: new ShoppingHome(title: "Home"),
      routes: routes,
    );
  }
}