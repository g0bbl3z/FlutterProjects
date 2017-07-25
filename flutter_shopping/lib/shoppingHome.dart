import 'package:flutter/material.dart';
import 'product.dart';
import 'shopBar.dart';

class ShoppingHome extends StatefulWidget {
  ShoppingHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ShoppingHomeState createState() => new ShoppingHomeState();
}

class ShoppingHomeState extends State<ShoppingHome>{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: buildShopBar(context, widget.title),
      body: new Container(
        child: new GridView.count(
          crossAxisCount: 2,
          children: generateProductViews(products),
          padding: new EdgeInsets.all(2.0),
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
        ),
        color: Colors.blue[300],
      ),
    );
  }
}