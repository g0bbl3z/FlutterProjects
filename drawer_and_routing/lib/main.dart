import 'package:flutter/material.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

//TODO I think those __Build pages are a waste?
//main method creates and runs the app
void main() {
  runApp(new MyApp());
}

//------------MyApp--------------
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{
      //the other pages that can be accessed other than the home page
      //each new route is created individually
      FavoritesBuild.routeName: (BuildContext context) => new FavoritesBuild(),
      CakeBuild.routeName: (BuildContext context) => new CakeBuild(),
      BrowserBuild.routeName: (BuildContext context) => new BrowserBuild(),
      ImagesPage.routeName: (BuildContext context) => new ImagesPage(),
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
              padding: new EdgeInsets.all(
                  3.0), //Pretty much everything from here down (inside the container) is styling
              child: new Text("Header",
                  style: new TextStyle(
                      fontSize: 30.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          //each of these ListTiles is the corresponding link/path to the pages other than home
          new ListTile(
            leading: new Icon(Icons.favorite, color: Colors.red),
            title: new Text("Your Favorites",
                style: new TextStyle(color: Colors.black87)),
            onTap: () {
              _onRouteTap(FavoritesBuild.routeName);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.cake, color: Colors.pink),
            title:
                new Text("Cake!", style: new TextStyle(color: Colors.black87)),
            onTap: () {
              _onRouteTap(CakeBuild.routeName);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.web, color: Colors.blue),
            title: new Text("Check out the Web!",
                style: new TextStyle(color: Colors.black87)),
            onTap: () {
              _onRouteTap(BrowserBuild.routeName);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.image, color: Colors.deepOrange),
            title: new Text("Look at these pictures!",
                style: new TextStyle(color: Colors.black87)),
            onTap: () {
              _onRouteTap(ImagesPage.routeName);
            },
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
  Photo({this.asset, this.title, this.subtitle}) : isFavorited = false;
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
  new Photo(
      asset:
          'http://i.dailymail.co.uk/i/pix/2017/01/16/20/332EE38400000578-4125738-image-a-132_1484600112489.jpg',
      title: 'Hippo',
      subtitle: 'Yawning'),
  new Photo(
      asset:
          'http://i.dailymail.co.uk/i/pix/2012/09/04/article-0-14D3A225000005DC-40_964x602.jpg',
      title: 'Birdy',
      subtitle: 'With a hat'),
  new Photo(
      asset:
          'http://www.jqueryscript.net/images/Simplest-Responsive-jQuery-Image-Lightbox-Plugin-simple-lightbox.jpg',
      title: 'Red Panda',
      subtitle: 'Cute'),
];

//----------ImagesPage---------
//the object that is called in MyApp to get the routeName and start building the corresponding page
//class ImagesBuild extends StatelessWidget {
//  static String routeName = "images";
//
//  @override
//  Widget build(BuildContext context) {
//    return new ImagesPage(title: "Images Page");
//  }
//}

//Creates the ImagesPage Widget. Since it is a stateful page the widget only creates it's state and then that state builds the page
class ImagesPage extends StatefulWidget {
  ImagesPage({Key key, this.title}) : super(key: key);

  final String title;

  static String routeName = "images";

  @override
  _ImagesPageState createState() => new _ImagesPageState();
}

//the state of the Images Page
class _ImagesPageState extends State<ImagesPage> {
  @override
  Widget build(BuildContext context) {
    //Method that expands an image when it is selected
    void _expandImage(Photo img) {
      Navigator.push(context,
          new MaterialPageRoute<Null>(builder: (BuildContext context) {
        return new Scaffold(
          appBar: new AppBar(title: new Text(img.title)),
          body: new Stack(
            children: <Widget>[
              new Opacity(
                child: new SizedBox.expand(
                    child: new Image.network(img.asset, fit: BoxFit.fill)),
                opacity: .4,
              ),
              new SizedBox.expand(
                  child: new Image.network(img.asset, fit: BoxFit.contain)),
            ],
          ),
        );
      }));
    }

    //Turning photos into gridItem widgets to be displayed
    //as stated above this item isn't really bare bones
    List<Widget> gridItems = <Widget>[];
    for (int i = 0; i < photos.length; i++) {
      gridItems.add(
        new GridTile(
          child: new GestureDetector(
            child: new Image.network(photos[i].asset, fit: BoxFit.cover),
            onTap: () {
              _expandImage(photos[i]);
            },
          ),
          footer: new GridTileBar(
            backgroundColor: Colors.black45,
            title: new Text(photos[i].title),
            subtitle: new Text(photos[i].subtitle),
            trailing: new IconButton(
                icon: photos[i].isFavorited
                    ? new Icon(Icons.star, color: Colors.red)
                    : new Icon(Icons.star_border, color: Colors.white),
                onPressed: () {
                  setState(() {
                    photos[i].isFavorited = !photos[i].isFavorited;
                  });
                }),
          ),
        ),
      );
    }

    //the actual build of this page
    return new Scaffold(
      drawer: new MyDrawer(),
      appBar: new AppBar(title: new Text("Images Page")),
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
class BrowserBuild extends StatelessWidget {
  static String routeName = "browser";

  @override
  Widget build(BuildContext context) {
    return new BrowserPage(title: 'Browser Page');
  }
}

//Since BrowserPage is stateless it contains it's build method instead of the createState method
class BrowserPage extends StatelessWidget {
  BrowserPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new MyDrawer(),
      appBar: new AppBar(title: new Text("Open this link!")),
      body: new MyGrid(),
      floatingActionButton: new HomeButton(),
    );
  }
}

//-------------Cake Page-------------------
//the class that contains the route and starts building the page
class CakeBuild extends StatelessWidget {
  static String routeName = "cake";

  @override
  Widget build(BuildContext context) {
    return new MyCakePage(title: 'Cake Page');
  }
}

//Since CakePage is Stateful it uses State to build itself
class MyCakePage extends StatefulWidget {
  MyCakePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCakePageState createState() => new _MyCakePageState();
}

//the state that builds the page
//contains _size and _shade variables that are changed when the IconButton is pressed
class _MyCakePageState extends State<MyCakePage> {
  double _size = 50.0;
  int _shade = 500;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new MyDrawer(),
      appBar: new AppBar(title: new Text("Cake!")),
      body: new Center(
        //this centers it's child to the middle of the page
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
      _shade = new Random().nextInt(8) * 100 +
          100; //this is what uses the dart:math import
    });
  }
}

//-------------Favorites Page--------------
//this page lists out the photos that have been favorited in the Images Page
//the class that contains the route and starts building the page
class FavoritesBuild extends StatelessWidget {
  static String routeName = "favorites";

  @override
  Widget build(BuildContext context) {
    return new MyFavoritesPage(title: 'Favorites Page');
  }
}

//Changed this page to be stateful
class MyFavoritesPage extends StatefulWidget {
  MyFavoritesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyFavoritesPageState createState() => new _MyFavoritesPageState();
}

class _MyFavoritesPageState extends State<MyFavoritesPage> {
  bool _isSearching = false;//toggles the appBar/searchBar
  final TextEditingController _searchQuery = new TextEditingController();//the text the user entered after submitting a search

  //called when the search icon is pressed. Opens up the searchBar
  void _handleSearchBegin() {
    ModalRoute.of(context).addLocalHistoryEntry(new LocalHistoryEntry(
      onRemove: () {
        //this happens when _handleSearchEnd is run
        setState(() {
          _isSearching = false;
          _searchQuery.clear();
        });
      },
    ));
    setState(() {
      _isSearching = true;
    });
  }
//called when the user submits a search. closes the searchBar and completes search
  void _handleSearchEnd() {
    Navigator.pop(context);
  }
//the method that performs the search. filters all images by title and returns a list of images that contain _searchQuery.
//this list is later filtered again based on if the image is favorited (this method doesn't do that though. It only filters based on name)
  List<Photo> _filterBySearchQuery(List<Photo> images) {
    if(_searchQuery.text.isEmpty){
      return images;
    }
    final RegExp regexp = new RegExp(_searchQuery.text,caseSensitive: false);
    List<Photo> res = [];
    for(int i=0;i<images.length;i++){
      if(images[i].title.contains(regexp)){
        res.add(images[i]);
      }
    }
    return res;
  }
  //if the user pressed the search icon then the SearchBar(contains the TextField) will be built, otherwise the appbar (contains header) is built
  //this method is used in place of "new AppBar" in the build method of this page
  AppBar _buildSearchBar(bool _isSearching) {
    if (_isSearching) {
      return new AppBar(
        leading: new IconButton(
            tooltip: "Cancel",
            icon: new Icon(Icons.clear, color: Theme.of(context).accentColor),
            onPressed: _handleSearchEnd),
        title: new TextField(
          controller: _searchQuery,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Search'),
        ),
        backgroundColor: Theme.of(context).canvasColor,
      );
    } else {
      return new AppBar(
        title: new Text("Favorites Page"),
        actions: <Widget>[
          new IconButton(
              icon:
                  new Icon(Icons.search, color: Colors.white),
              onPressed: _handleSearchBegin,
              tooltip: "Search")
        ],
      );
    }
  }
//the build method
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new MyDrawer(),
      appBar: _buildSearchBar(_isSearching),
      body: _createFavorites(_filterBySearchQuery(photos)),
      floatingActionButton: new HomeButton(),
    );
  }

  //method that creates a list of ListTile widgets based on what is favorited (in the Images Page)
  _createFavorites(List<Photo> photos) {
    List<Widget> favorites = <Widget>[];
    for (int i = 0; i < photos.length; i++) {
      if (photos[i].isFavorited) {
        favorites.add(
          new ListTile(
            leading: new CircleAvatar(
              backgroundImage: new NetworkImage(photos[i].asset),
            ),
            title: new Text(photos[i].title),
            trailing: new IconButton(
                tooltip: "Remove from Favorites",
                icon: photos[i].isFavorited
                    ? new Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      )
                    : new Icon(Icons.star_border, color: Colors.white),
                onPressed: () {
                  setState(() {
                    photos[i].isFavorited = !photos[i].isFavorited;
                  });
                }),
          ),
        );
      }
    }
    //if the list is empty then do this
    if (favorites.length == 0) {
      return new Container(
        alignment: FractionalOffset.center, //centers up and down
        margin: new EdgeInsets.all(50.0), //spacing on the left and right
        child: new Text(
          "Go to Images Page to add to your favorites!",
          style: new TextStyle(fontSize: 25.0),
        ),
      );
    }
    return new ListView(children: favorites);
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
