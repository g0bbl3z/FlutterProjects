import 'package:flutter/material.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
//This is the generic version of drawer_and_routing except drawer_and_routing has more features


//main method creates and runs the app
void main() {
  runApp(new MyApp());
}

//------------MyApp--------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{ //the other pages that can be accessed other than the home page
      //each new route is created individually
      Item1Build.routeName: (BuildContext context) => new Item1Build(),
      Item2Build.routeName: (BuildContext context) => new Item2Build(),
      Item3Build.routeName: (BuildContext context) => new Item3Build(),
      Item4Build.routeName: (BuildContext context) => new Item4Build(),
    };
    //the general info that the app needs
    //TODO: Understand themes better
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
      routes: routes,
    );
  }
}

//---------------Drawer----------------
//custom Drawer that will contain links/paths to each page (other than home)

//create the variable
final MyDrawer _drawer = new MyDrawer();

//create the widget. Since the Drawer is stateful it will be built through it's state instead of the widget
class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => new _MyDrawerState();
}
//the state of the drawer widget. Contains the build method
class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          //TODO: What to do with DrawerHeader
          new DrawerHeader(
            child: new Container(
              padding: new EdgeInsets.all(3.0),//Pretty much everything from here down (inside the container) is styling
              child: new Text("Header",
                  style: new TextStyle(
                      fontSize: 30.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          //each of these ListTiles is the corresponding link/path to the pages other than home
          //ListTile1
          new ListTile(
            leading:  new Icon(Icons.favorite, color: Colors.red),
            title: new  Text("ListTile1", style: new TextStyle(color: Colors.black87)),
            onTap: () {_onRouteTap(Item1Build.routeName);},
          ),
          //ListTile2
          new ListTile(
            leading: new Icon(Icons.star, color: Colors.blue),
            title: new Text("ListTile2", style: new TextStyle(color:Colors.redAccent)),
            onTap: () {_onRouteTap(Item2Build.routeName);},
          ),
          //ListTile3
          new ListTile(
            leading: new Icon(Icons.android, color: Colors.green),
            title: new Text("ListTile3", style: new TextStyle(color: Colors.yellow[800])),
            onTap: () {_onRouteTap(Item3Build.routeName);},
          ),
          //ListTile4
          new ListTile(
            leading: new Icon(Icons.bluetooth, color: Colors.deepOrange),
            title: new Text("ListTile4", style: new TextStyle(color: Colors.grey)),
            onTap: () {_onRouteTap(Item4Build.routeName);},
          )
        ],
      ),
    );
  }
  //This method is run when a link to another page is tapped.
  void _onRouteTap(route) {
    Navigator.popAndPushNamed(context, route);
  }
}
//----------Photo Class---------
//This class is to give any photos that are displayed more of a meaning. It isn't really part of the bare bones.
class Photo {
  Photo({this.asset, this.title, this.subtitle}): isFavorited = false;
  //asset is the link to the image. all the Photos in use below are stored on the web. Downloaded images would be created slightly differently.
  //They would need to be added to part of this project (I believe in the pubspec.yaml) and _ImagesPageState would need to
  //call Images.asset() instead of Images.network()
  //the boolean isFavorited is always initialized as false
  final String asset;
  final String title;
  final String subtitle;
  bool isFavorited;

}
//List of photos to be displayed in the grid
//the boolean isFavorited is always initialized as false
List<Photo> photos = <Photo>[
  new Photo(asset: 'https://s-media-cache-ak0.pinimg.com/originals/4c/09/e6/4c09e62ddd6cdc4a3932643519c43db1.jpg',title: 'Photo1', subtitle: 'Caption1'),
  new Photo(asset: 'http://i.dailymail.co.uk/i/pix/2012/09/04/article-0-14D3A225000005DC-40_964x602.jpg',title: 'Photo2', subtitle: 'Caption2'),
  new Photo(asset: 'http://www.jqueryscript.net/images/Simplest-Responsive-jQuery-Image-Lightbox-Plugin-simple-lightbox.jpg',title: 'Photo3', subtitle: 'Caption3'),
];
//the object that is called in MyApp to get the routeName and start building the corresponding page
class Item4Build extends StatelessWidget {
  static String routeName = "item4";

  @override
  Widget build(BuildContext context){
    return new Item4Page(title:"Page 4");
  }
}

//Creates the ImagesPage Widget. Since it is a stateful page the widget only creates it's state and then that state builds the page
class Item4Page extends StatefulWidget {
  Item4Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Item4PageState createState() => new _Item4PageState();
}

//the state of the Images Page
class _Item4PageState extends State<Item4Page>{
  @override
  Widget build(BuildContext context){
    //Method that expands an image when it is selected
    void _expandImage(Photo img) {
      Navigator.push(context, new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return new Scaffold(
              appBar: new AppBar(title: new Text(img.title)),
              body: new Stack(
                children: <Widget>[
                  new Opacity(child: new SizedBox.expand(child: new Image.network(img.asset, fit: BoxFit.fill)), opacity: .4,),
                  new SizedBox.expand(child: new Image.network(img.asset, fit: BoxFit.contain)),
                ],
              ),
            );
          }
      ));
    }
    //Turning photos into gridItem widgets to be displayed
    //as stated above this item isn't really bare bones
    List<Widget> gridItems = <Widget>[];
    for(int i=0;i<photos.length;i++){
      gridItems.add(
        new GridTile(
          child: new GestureDetector(
            child: new Image.network(photos[i].asset, fit: BoxFit.cover),
            onTap: () {_expandImage(photos[i]);},
          ),
          footer: new GridTileBar(
            backgroundColor: Colors.black45,
            title: new Text(photos[i].title),
            subtitle: new Text(photos[i].subtitle),
            trailing: new IconButton(icon: photos[i].isFavorited ? new Icon(Icons.star, color: Colors.red) : new Icon(Icons.star_border, color: Colors.white), onPressed: () {setState((){photos[i].isFavorited = !photos[i].isFavorited;});}),
          ),
        ),
      );
    }

    //the actual build of this page
    return new Scaffold(
      drawer: new MyDrawer(),
      appBar: new AppBar(title: new Text("This is Page 4")),
      body: new GridView.extent(
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
        maxCrossAxisExtent: 300.0,
        padding: const EdgeInsets.all(3.0),
        children: gridItems,
      ),
      floatingActionButton: new HomeButton(),
    );
  }

}
//-----------HomeButton-------------
//the Floating Action Button that is located in the bottom right of each page
//A different type of button could probably be used somewhere else (for example in the Drawer)
//and this onPressed method would probably still work
class HomeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new FloatingActionButton(
      child: new Icon(Icons.home, size: 30.0, color: Colors.white),
      onPressed: () {
        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      },
      tooltip: "Home",
    );
  }
}

//---------Method that launches Browser to specified url--------
//uses the import 'package:url_launcher/url_launcher.dart';
_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

//------------MyGrid--------------------
//this is a very simple grid that contains RaisedButtons showing implementation of the _launchURL method above
class MyGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GridView.extent(
      maxCrossAxisExtent: 300.0,
      padding: const EdgeInsets.all(4.0),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: <Widget>[
        new RaisedButton(
            onPressed: () {
              _launchURL('https://www.google.com');
            },
            child: new Text("https://www.google.com")),
        new RaisedButton(
            onPressed: () {
              _launchURL("https://flutter.io");
            },
            child: new Text("https://flutter.io")),
      ],
    );
  }
}

//------------Browser Page-----------------
//The class that contains the route and starts building the page
class Item3Build extends StatelessWidget {
  static String routeName = "item3";

  @override
  Widget build(BuildContext context) {
    return new Item3Page(title: 'Page 3');
  }
}

//Since BrowserPage is stateless it contains it's build method instead of the createState method
class Item3Page extends StatelessWidget {
  Item3Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new MyDrawer(),
      appBar: new AppBar(title: new Text("This is Page 3")),
      body: new MyGrid(),
      floatingActionButton: new HomeButton(),
    );
  }
}

//-------------Cake Page-------------------
//the class that contains the route and starts building the page
class Item2Build extends StatelessWidget {
  static String routeName = "item2";

  @override
  Widget build(BuildContext context) {
    return new Item2Page(title: 'Page 2');
  }
}

//Since CakePage is Stateful it uses State to build itself
class Item2Page extends StatefulWidget {
  Item2Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Item2PageState createState() => new _Item2PageState();
}

//the state that builds the page
//contains _size and _shade variables that are changed when the IconButton is pressed
class _Item2PageState extends State<Item2Page> {
  double _size = 50.0;
  int _shade = 500;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new MyDrawer(),
      appBar: new AppBar(title: new Text("This is Page 2")),
      body: new Center(//this centers it's child to the middle of the page
        child: new IconButton(
          iconSize: _size,
          icon: new Icon(Icons.cake,
              size: _size, color: Colors.deepOrange[_shade]),
          onPressed: _grow,
        ),
      ),
      floatingActionButton: new HomeButton(),
    );
  }
  //the method that changes _size and _shade when the IconButton is pressed
  void _grow() {
    setState(() {
      _size++;
      _shade = new Random().nextInt(8) * 100 + 100;//this is what uses the dart:math import
    });
  }
}

//-------------Favorites Page--------------
//this page is currently really boring
//TODO: See if you can save any photos that were favorited in the Images Page and list them here
//the class that contains the route and starts building the page
class Item1Build extends StatelessWidget {
  static String routeName = "item1";

  @override
  Widget build(BuildContext context) {
    return new Item1Page(title: 'Page 1');
  }
}

//since it is stateless it just builds itself
class Item1Page extends StatelessWidget {
  Item1Page({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new MyDrawer(),
      appBar: new AppBar(title: new Text("This is Page 1")),
      body: new Center(
        child: new Icon(Icons.favorite, size: 50.0, color: Colors.red[500]),
      ),
      floatingActionButton: new HomeButton(),
    );
  }
}

//----------------------Home Page------------------
//Since HomePage is StateFul it uses State to build itself
//this is just the default page that Flutter gives in every new project
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var drawer = new MyDrawer();
    return new Scaffold(
      drawer: drawer,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '${_counter}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
