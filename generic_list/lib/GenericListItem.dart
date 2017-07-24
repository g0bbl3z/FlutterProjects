import 'package:flutter/material.dart';
import 'DialogOption.dart';

typedef void checkedChangeCallback(Entry entry, bool inCart);

class Entry {
  const Entry({this.name});
  final String name;
}

List<Entry> createEntries(){
  List<Entry> _entries = <Entry>[
    new Entry(name: 'Eggs'),
    new Entry(name: 'Flour'),
    new Entry(name: 'Chocolate chips'),
  ];
  return _entries;
}

class GenericListItem extends StatelessWidget {
  GenericListItem({Entry entry, this.isChecked, this.onCheckedChange})
      : entry = entry,
        super(key: new ObjectKey(entry));

  final Entry entry;
  final bool isChecked;
  final checkedChangeCallback onCheckedChange;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different parts of the tree
    // can have different themes.  The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return isChecked ? Colors.black54 : Theme.of(context).primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!isChecked) return null;

    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new GestureDetector(
          child: new Text(entry.name[0]),
          onTap: () {
            onCheckedChange(entry, isChecked);
          },
          onLongPress: () {
            displayDialog<String>(context: context, child: new SimpleDialog(
              children: createDialogOptions(context),
            ));
          },
        ),
      ),
      title: new GestureDetector(
        onTap: () {
          onCheckedChange(entry, isChecked);
        },
        child: new Text(entry.name, style: _getTextStyle(context)),
      ),
    );
  }
}