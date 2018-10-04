import 'package:flutter/material.dart';
import 'objects.dart';

class eventsPage extends StatefulWidget {
  Event event;
  eventsPage(this.event);

  @override
  eventsPageState createState() => new eventsPageState();

}

class eventsPageState extends State<eventsPage> {
  generateTagContainers(Activity activity) {
    List<Widget> children = List<Widget>();
    for (Tag tag in activity.tags) {
      children.add(
        Container(
          child: Text(
            tag.title,
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0), color: tag.color),
          margin: EdgeInsets.only(right: 1.5, top: 1.5, bottom: 1.0),
          padding: EdgeInsets.symmetric(horizontal: 1.5, vertical: 1.0),
        ),
      );
    }
    return children;
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text(widget.event.title)),
      body: Column(
        children: <Widget>[
          Container(
            color:Colors.red,
            child: Center(child: Text("Test Discussion")),
          ),
        ],
      )
    );
  }
}