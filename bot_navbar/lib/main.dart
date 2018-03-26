import 'package:flutter/material.dart';
//imported the pages
import './PageOne.dart' as first;
import './PageTwo.dart' as second;
//main method
void main() {
  runApp(new MyApp());
}
//the app itself with the outlining details
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      //title of the app (only seen outside of the app)
      title: 'Bottom Nav Bar Demo',
      //theme of the app
      //TODO: learn Themes better
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      //builds the bottomNav bar and the body (and the body changes based on the bottomNavBar)
      home: new MyHomePage(title: 'Bottom Navbar Demo'),
    );
  }
}

//This class is essential to making the navBar (especially when it comes to actually navigating)
class NavigationIconView {
  final Widget _icon;
  final Color _color;
  final Widget _page;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;
  //constructor
  NavigationIconView({Widget icon, Widget title, Widget page, Color color, TickerProvider vsync,}) :
    _icon = icon,
    _color = color,
    _page = page,
    item = new BottomNavigationBarItem(
      icon: icon, title: title, backgroundColor: color,
    ),
    //Duration in this controller defines how long the transition between pages takes
    controller = new AnimationController(vsync: vsync, duration: new Duration(milliseconds: 500)){
    //TODO: Investigate different animations and how to adjust them
    _animation = new CurvedAnimation(parent: controller, curve: const Interval(0.5, 1.0, curve: Curves.easeInOut));
  }
  //TODO: Investigate different animations and how to adjust them
//  FadeTransition transition(BuildContext context){
//    return new FadeTransition(
//      opacity: _animation,
//      child: new SlideTransition(
//        position: new FractionalOffsetTween(
//          begin: const FractionalOffset(0.02, 0.02),
//          end: FractionalOffset.topLeft,
//        ).animate(_animation),
//        child: _page,
//      ),
//    );
//  }
}

//the class that is put into the "home" parameter at the app level. Is stateful so needs to create state
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

//the state of the Home page. Has a TickerProvider so it can listen to changes
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  //index references which tab the navbar is currently on
  int _currentIndex = 0;
  //the list of items on the bar
  List<NavigationIconView> _navigationViews;

  //creates that list and gives each item a controller that allows the listeners that change between pages
  @override
  void initState() {
    super.initState();
    _navigationViews = <NavigationIconView>[
      //icon and title are self-explanatory (just the image and text on the navbar). page is the corresponding page to that item (icon/title).
      //color is the background color of the bar when that item is selected. They can be the same color. vsync is always "this"
      new NavigationIconView(icon: new Icon(Icons.calendar_today), title: new Text("Calendar"), page: new first.First(), color: Colors.blue, vsync: this,),
      new NavigationIconView(icon: new Icon(Icons.brush), title: new Text("Brush"), page: new second.Second(), color: Colors.red,vsync: this,),
    ];
    //this adds a listener to each item. When the listener is called it runs _rebuild (which just resets the state. it kind of just updates the app to the new page)
    for(NavigationIconView view in _navigationViews){
      view.controller.addListener(_rebuild);
    }
    //Not totally sure what this does but I am pretty sure it has something to do with making sure the body opens to a page instead of being totally blank until the user
    //taps an item in the navBar
    _navigationViews[_currentIndex].controller.value = 1.0;
  }

  //"When a state object is no longer needed, the framework calls dispose on the state object". It basically does cleanup work
  @override
  void dispose() {
    for(NavigationIconView view in _navigationViews){
      view.controller.dispose();
    }
    super.dispose();
  }
  //method that the listeners call to update the screen
  void _rebuild(){
    setState((){});
  }
  //this is the body that changes between pages. each child is a fadeTransition TODO: investigate different animations and how to adjust them
  Widget _buildTransitionStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

//    for(NavigationIconView view in _navigationViews){
//      transitions.add(view.transition(context));
//    }

    return new Stack(
      children: transitions,
    );
  }

  //the actual build method of the app
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),//this takes the title that is used when MyHomePage is called (line 22)
      ),
      body: _buildTransitionStack(),
      bottomNavigationBar: new BottomNavigationBar(
        items:_navigationViews.map((NavigationIconView navigationView) => navigationView.item).toList(),
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _navigationViews[_currentIndex].controller.reverse();
            _currentIndex = index;
            _navigationViews[_currentIndex].controller.forward();
          });
        },
        //changing this to .fixed takes away the background colors (currently white. TODO: Learn themes more and see if you can change the white)
        //When it is set to fixed the title and icon are both always visible but the selected on grows slightly and the icon and text turn blue.
        type: BottomNavigationBarType.shifting,

      ),
    );
  }
}
