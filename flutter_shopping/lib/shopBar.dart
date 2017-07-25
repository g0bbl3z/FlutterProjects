import 'package:flutter/material.dart';
import 'cart.dart';

AppBar buildShopBar(BuildContext context, String title) {
  return new AppBar(
    backgroundColor: Colors.orangeAccent[400],
    actions: <Widget>[
      new Container(
//        child: new Icon(Icons.shopping_cart, color: Colors.white, size: 30.0),
//TODO: Make Icons into buttons
      child: new IconButton(
              icon: new Icon(Icons.shopping_cart, color: Colors.white, size: 30.0),
              onPressed: () {Navigator.pushNamed(context, cartPage.routeName);},
              tooltip: "Go to Cart",
            ),
        padding: new EdgeInsets.only(right: 10.0),
      )
    ],
//TODO: Add Theme to this TextStyle
    title: new Text(title, style: new TextStyle(color: Colors.white)),
  );
}

