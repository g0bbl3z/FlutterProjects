import 'package:flutter/material.dart';
import './PageOne.dart' as first;
import './PageTwo.dart' as second;
import './PageThree.dart' as third;

//Different pages are now separated into different files
//they are more organized now (than in drawer_and_routing) but they also need to be imported

//Main method
void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
    title: "Top Navigation Bar Example",
  ));
}

//This is set as "home" in main, but the actual home page is Page One.
class MyApp extends StatefulWidget {
  @override
  MyTabsState createState() => new MyTabsState();
}

//Since this is new tabs, the appbar is never recreated in each Page and the State needs this SingleTickerProviderStateMixin.
class MyTabsState extends State<MyApp> with SingleTickerProviderStateMixin {
  //this variable is very important. it is used to handle changing between tabs
  TabController tabController;

  //Not exactly sure what this is for but it is important
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this); //length is the number of tabs
  }

  //Also not really sure what it does but I think it kind of "closes" tabs that aren't in use
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  //the build method that builds the app and provides routes to tabs
  //the ordering of the children are important and need to correspond.
  //ex: first.First() (under TabBarView) is the build of Page One, and that corresponds to the "Page One" Tab (under bottom/TabBar)
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        bottom: new TabBar(
          tabs: <Tab>[
            new Tab(text: "Page One"),//without an icon there seems to be sort of weird padding but it still works
            new Tab(icon: new Icon(Icons.threed_rotation)), //same thing without text. However that is fixed with just empty text (like this: new Tab(icon: new Icon(Icons.threed_rotation), text: ""),
            new Tab(text: "Page Three", icon: new Icon(Icons.nature)),
          ],
          controller: tabController,
        ),
        title: new Text("Top Navigation Bar Example")),
      body: new TabBarView(
        controller: tabController,
        children: <Widget>[
          new first.First(),
          new second.Second(),
          new third.Third(),
        ],
      ),
    );
  }
}
