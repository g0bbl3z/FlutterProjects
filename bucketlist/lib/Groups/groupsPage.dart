import 'package:flutter/material.dart';
import 'package:bucketlist/objects.dart';

class groupsPage extends StatefulWidget {
  static String routeName = "groups";
  List<Group> groups;
  groupsPage(this.groups);

  @override
  groupsPageState createState() => new groupsPageState();
}

class groupsPageState extends State<groupsPage>{
//  Widget generateMainView(List<Group> groups) {
//    List<Widget> children = new List<Widget>();
//    for(Group group in groups){
//      children.add(
//        new Container(
//          child: new Column(
//            children: <Widget>[
//
//            ],
//          );
//        );
//      );
//    }
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text("My Groups")),
//      body: generateMainView(widget.groups),
    );
  }
}