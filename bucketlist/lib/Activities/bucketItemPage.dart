import 'package:flutter/material.dart';
import 'package:bucketlist/objects.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class bucketItemPage extends StatefulWidget {
  BucketItem activity;
  bucketItemPage(this.activity);

  @override
  bucketItemPageState createState() => new bucketItemPageState();
}

class bucketItemPageState extends State<bucketItemPage> {
  List<Widget> generateTagRow(List<Tag> tags) {
    List<Widget> widgets = new List<Widget>();
    widgets.add(Container(
      margin: EdgeInsets.only(top: 3.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0), color: Colors.black54),
      child: Text(
        "TAGS:",
        style: TextStyle(color: Colors.amberAccent),
        textScaleFactor: 2.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
    ));
    for (Tag tag in tags) {
      widgets.add(
        Container(
          child: Row(
            children: <Widget>[
              Text(
                tag.title,
                style: TextStyle(color: Colors.white70),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: null,
                iconSize: 24.0,
              ),
            ],
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0), color: tag.color),
          margin: EdgeInsets.symmetric(horizontal: 1.5, vertical: 2.5),
//          padding: EdgeInsets.only(left: 4.0),
        ),
      );
    }
    if (tags.length < 3) {
      widgets.add(Container(
        child: IconButton(
          icon: Icon(Icons.add_box),
          onPressed: null,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0), color: Colors.grey),
        margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 5.0),
      ));
    }
    return widgets;
  }

  List<Widget> generateTagContainers(Activity activity) {
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

  ValueChanged<Color> onColorChanged;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text(widget.activity.title)),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical:100.0),
              color: Colors.black38,
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(widget.activity.title),
                      Text(widget.activity.groups[0].title),
                    ],
                  ),
                  Column(children: generateTagContainers(widget.activity)),
                ],
              ),
            ),
            Divider(),
          ],
        ));
  }
}
