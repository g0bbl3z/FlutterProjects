import 'package:flutter/material.dart';
import 'package:bucketlist/homePage.dart';
import 'package:bucketlist/Groups/groupsPage.dart';
import 'objects.dart';
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var groups = new List();
    groups.add(new Group("Pangea"));
    groups.add(new Group("BasketBros"));
    var routes = <String, WidgetBuilder> {
      groupsPage.routeName: (BuildContext context) => new groupsPage(groups),
//      tagsPage.routeName: (BuildContext context) => new tagsPage(),
//      eventsPage.routeName: (BuildContext context) => new eventsPage(),
//      archivePage.routeName: (BuildContext context) => new archivePage(),

    };
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: new homePage(title: 'My List'),
      routes: routes,
    );
  }
}