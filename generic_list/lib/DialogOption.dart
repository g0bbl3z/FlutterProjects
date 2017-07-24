import 'package:flutter/material.dart';

class DialogOption extends StatelessWidget {
  const DialogOption({Key key, this.icon,this.text,this.onPressed}):super(key:key);
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context){
    return new SimpleDialogOption(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Icon(icon, size:36.0, color: Theme.of(context).primaryColor),
          new Padding(padding: const EdgeInsets.only(left:16.0),
            child: new Text(text),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}

void displayDialog<T>({BuildContext context, Widget child}) {
  showDialog<T>(context: context, child: child,).then<Null>((T value) {
    if(value != null) {
      Scaffold.of(context).removeCurrentSnackBar(reason: SnackBarClosedReason.remove);
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('$value')));
    }
  });
}

List<Widget> createDialogOptions(BuildContext context) {
  List<Widget> _dialog = <Widget>[
    new DialogOption(
      icon: Icons.delete,
      onPressed: () {Navigator.pop(context, "This item should be deleted");},
      text:"Delete this item",
    ),
    new DialogOption(
      icon: Icons.shuffle,
      onPressed: () {Navigator.pop(context, "This item should be moved");},
      text:"Move this item",
    ),
    new DialogOption(
      icon: Icons.autorenew,
      onPressed: () {Navigator.pop(context, "This item should be renamed");},
      text:"Rename this item",
    ),
  ];
  return _dialog;
}