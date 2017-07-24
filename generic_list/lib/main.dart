import 'package:flutter/material.dart';
import 'GenericList.dart';
import 'GenericListItem.dart';
//TODO: Add Firebase (logins) to customize lists by user
//TODO: Make the dialogs actually function. Not just show a snackbar

//Shows a list where each item can be toggled and each circle icon can be long-pressed to display a dialog.

void main() {
  runApp(new MaterialApp(
    title: 'Shopping App',
    home: new GenericList(
      entries: createEntries(),
    ),
  ));
}