import 'package:flutter/material.dart';
import 'GenericListItem.dart';

class GenericList extends StatefulWidget {
  GenericList({Key key, this.entries}) : super(key: key);

  final List<Entry> entries;
  // The framework calls createState the first time a widget appears at a given
  // location in the tree. If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework will re-use the State object
  // instead of creating a new State object.

  @override
  _GenericListState createState() => new _GenericListState();
}

class _GenericListState extends State<GenericList> {

  Set<Entry> _checkedItems = new Set<Entry>();

  void _handleCheckedChange(Entry entry, bool isChecked) {
    setState(() {
      // When user changes what is in the cart, we need to change _shoppingCart
      // inside a setState call to trigger a rebuild. The framework then calls
      // build, below, which updates the visual appearance of the app.
      if (!isChecked)
        _checkedItems.add(entry);
      else
        _checkedItems.remove(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Shopping List'),
      ),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.entries.map((Entry entry) {
          return new GenericListItem(
            entry: entry,
            isChecked: _checkedItems.contains(entry),
            onCheckedChange: _handleCheckedChange,
          );
        }).toList(),
      ),
    );
  }
}