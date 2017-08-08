import 'dart:math';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

//main method
void main() {
  runApp(new MyThemeApp());
}

//ThemeMode contains the different types of themes
enum ThemeMode { dark, light, red }
ThemeMode themeMode = ThemeMode.light; //initialize as light
bool isDark = false;
int redShade = 500;
//getTheme is a method that translates the (Theme)Mode to an actual ThemeData
ThemeData getTheme(ThemeMode themeMode) {
  switch (themeMode) {
    case ThemeMode.light:
      {
        MaterialColor primaryswatch = Colors
            .blue; //use the swatch to identify the main color and shade it differently
        return new ThemeData(
          brightness: Brightness.light, //light vs dark
          primarySwatch: primaryswatch, //the color that is defined above
          primaryColor: primaryswatch[
              400], //the color is shaded at 400 (smaller is lighter)
          accentColor: Colors.red,

        );
      }
    case ThemeMode.dark:
      {
        MaterialColor primaryswatch = Colors.green;
        return new ThemeData(
          brightness: Brightness.dark,
          primarySwatch: primaryswatch,
          primaryColor: primaryswatch[700], //the color is shaded at 700
        );
      }
    case ThemeMode.red:
      {
        MaterialColor primaryswatch = Colors.red; //red instead of blue
        return new ThemeData(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primarySwatch: primaryswatch,
          primaryColor: primaryswatch[redShade],
        );
      }
  }
  return null;
}

//the app is stateful so that the theme can be changed
class MyThemeApp extends StatefulWidget {
  @override
  MyThemeAppState createState() => new MyThemeAppState();
}

//the state of the app
class MyThemeAppState extends State<MyThemeApp> {
//runs this method when the theme is changed
  void _handleThemeChange(ThemeMode theme) {
    setState(() {
      //updates the state
      themeMode = theme; //changes the themeMode
    });
  }

//builds the app
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: getTheme(themeMode), //gets the theme based on the themeMode
      title: "My Themed App",
      home: new MyThemePage(
        title: "My Themed Home",
        onChanged:
            _handleThemeChange, //this is necessary for children widgets (like the flatbutton/home page) to setState of the parents (the app)
      ),
    );
  }
}

//the home page
class MyThemePage extends StatefulWidget {
  //requires the onChanged to update the parent
  MyThemePage({Key key, this.title, @required this.onChanged})
      : super(key: key);
  final String title;
  final ValueChanged<ThemeMode> onChanged; //were passing it a ThemeMode
  //when the button is tapped it runs this method.
  //cycles through the different themeModes
  void _handleTap() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
    } else if (themeMode == ThemeMode.dark) {
      themeMode = ThemeMode.red;
    } else {
      themeMode = ThemeMode.light;
    }
    onChanged(
        themeMode); //pass the new themeMode to onChanged (which sends it to the parent to change the theme)
  }

  void _handleSelect(ThemeMode theme) {
    //this sends the selected thememode to the parent
    onChanged(theme);
  }
//works the same as _handleSelect (because it uses _handleSelect)
//except that themeMode doesn't change (just sets state of parent) and updates isDark
  void _handleDarkToggle(bool newValue) {
    isDark = newValue;
    _handleSelect(themeMode);
  }
//works the same as _handleDarkToggle but with an int instead of a bool
  void _handleShadeSlider(int newValue){
    redShade = newValue;
    _handleSelect(themeMode);
  }

  @override
  MyThemePageState createState() => new MyThemePageState();
}

class MyThemePageState extends State<MyThemePage> {
  void _handleTap() {
    widget._handleTap(); //this takes the method _handleTap (used in flatbutton) that is defined in it's parent widget (MyThemePage)
  }

  void _handleSelect(ThemeMode theme) {
    //same as above (used in PopUpMenu, buttonBar, radio)
    widget._handleSelect(theme);
  }
//used in checkbox
  void _handleDarkToggle(bool newValue) {
    widget._handleDarkToggle(newValue);
  }
//used in slider
  void _handleShadeSlider(int newValue){
    widget._handleShadeSlider(newValue);
  }
  //creates a list of PopUpMenuEntries based on what values are in the ThemeMode enum
  List<PopupMenuEntry<ThemeMode>> popUpThemes() {
    List<PopupMenuEntry<ThemeMode>> lst = <PopupMenuEntry<ThemeMode>>[];
    for (ThemeMode theme in ThemeMode.values) {
      //loop through all of the ThemeMode values
      lst.add(new PopupMenuItem(
          //for each value add a popupmenuitem to the list
          value: theme, //it's value is the corresponding thememode value
          //display the corresponding text
          child: new Text(theme == ThemeMode.dark
              ? "Dark"
              : theme == ThemeMode.light
                  ? "Light"
                  : theme == ThemeMode.red ? "Red" : null)));
    }
    return lst;
  }

  //the list is randomized just to show that a buttonbar can hold pretty much any type of button
  //changing theme kind of makes the buttonbar freak out for a second but randomizing the buttons isn't practical anyways so nbd
  //just wanted to show that buttonbar holds any combination of buttons
  List<Widget> buttonThemes() {
    //returns a list of buttons with corresponding themes
    List<Widget> lst = <Widget>[];
    var rng = new Random(); //random number generator
    for (ThemeMode theme in ThemeMode.values) {
      //for each ThemeMode value make a button
/*
Changed the rng to only choose between flat or raised buttons. Removed icons because
it makes the format "jumpy" and annoying when they switch. Change the value (below) in nextInt
to 3 if you want to see iconButtons as well.
*/
      int rand = rng.nextInt(2); //three options (button types) (only 2 options when set to 2)
      if (rand == 0) {
        //first option is a flatbutton
        lst.add(new FlatButton(
            onPressed: () => _handleSelect(theme), //handlepress sends the theme
            child: new Text(theme == ThemeMode.dark
                ? "Dark"
                : theme == ThemeMode.light
                    ? "Light"
                    : theme == ThemeMode.red ? "Red" : null)));
      } else if (rand == 1) {
        //second option is a raised button
        lst.add(new RaisedButton(
            onPressed: () => _handleSelect(theme),
            child: new Text(theme == ThemeMode.dark
                ? "Dark"
                : theme == ThemeMode.light
                    ? "Light"
                    : theme == ThemeMode.red ? "Red" : null)));
      } else if (rand == 2) {
        //third option is an icon button
        lst.add(new IconButton(
            icon: new Icon(Icons.face), onPressed: () => _handleSelect(theme)));
      }
    }
    return lst;
  }

  //builds the home page
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Center(
              child: new FlatButton(
                  //flatbuttons look like text but act as buttons
                  onPressed: () =>
                      _handleTap(), //the method to run when button is pressed
                  child: new Text("FlatButton",
                      style: new TextStyle(
                          color: Theme
                              .of(context)
                              .primaryColor)))), //this could be accentColor (or a lot of different things), it just depends on how you want your app to look
          new PopupMenuButton(
            itemBuilder: (BuildContext context) => popUpThemes(),
            onSelected: (ThemeMode result) {
              _handleSelect(result);
            },
            child: new Text(
              //child can pretty much be anything. If it is left null then the overflow icon appears
              "Choose a color",
              style: new TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          ),
          new ButtonBar(
            children: buttonThemes(), //the list of widgets (buttons)
            alignment: MainAxisAlignment.center, //the bar is centered
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Checkbox(
                  value: isDark,
                  onChanged: (bool newValue) {
                    _handleDarkToggle(newValue);
                  }),//toggles the value of isDark. The only ThemeMode that is responsive to isDark is ThemeMode.red (so it only works on that thememode)
              new Checkbox(
                  value: themeMode == ThemeMode.red,
                  onChanged:
                      null), //inactive, but changes itself based on if the themeMode is red
            ],
          ),
          //switch is another way to toggle
          //it is doing the same thing as that checkbox
          new Switch(
              value: isDark,//corresponding bool value
              onChanged: (bool newValue) => _handleDarkToggle(newValue),//the method to call when it is selected
          ),
          new Row(//row of radio buttons
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Radio(
                  value: ThemeMode.dark,//corresponding ThemeMode value
                  groupValue: themeMode,//the value to check it against (and the group it is a part of)
                  onChanged: (ThemeMode newTheme) => _handleSelect(newTheme)),//the method to call when it is updated/selected
              new Radio(
                  value: ThemeMode.light,
                  groupValue: themeMode,
                  onChanged: (ThemeMode newTheme) => _handleSelect(newTheme)),
              new Radio(
                  value: ThemeMode.red,
                  groupValue: themeMode,
                  onChanged: (ThemeMode newTheme) => _handleSelect(newTheme)),
            ],
          ),
          new Slider(
            value: redShade.toDouble(),//sliders need to be doubles
            onChanged: (double newValue) => _handleShadeSlider(newValue.toInt()),//material colors are ints and rounded to hundred's
            min: 100.0,//minimum value of slider
            max: 900.0,//maximum value of slider
            divisions: 8,//how to split up the slider. with 8 divisions it slides by hundred's. if left out then it is smooth
            label: redShade.toString(),//label is the icon that appears above when sliding. it is optional
          ),
        ],
      ),
    );
  }
}
