//This code is pretty much a copy of the Firebase for Flutter Codelab with a few personal edits

//Finally a working example of Firebase

//Imports
import 'dart:async';
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(new FriendlychatApp());
}

//Theme for when on iOS
final ThemeData kIOSTheme = new ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.grey[100],
  primaryColorBrightness: Brightness.light,
);
//Theme for when on Android
final ThemeData kDefaultTheme = new ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.orangeAccent[400],
);

final googleSignIn =
    new GoogleSignIn(); //google sign in variable so user can sign in using google
final analytics = new FirebaseAnalytics(); //allows Firebase to track analytics
final auth = FirebaseAuth
    .instance; //firebase auth variable to ensure that the user can access data (like past messages)

//App is stateless
class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Friendlychat",
//Sets the theme based off of what platform the phone is using (iOS or Android)
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: new ChatScreen(),
    );
  }
}

//ChatMessage is an individual message. Contains the user ID, user Image, and either the text or photo that the user sent
class ChatMessage extends StatelessWidget {
  ChatMessage({this.snapshot, this.animation});
//DataSnapshots are the objects that hold the data from the firebase database
//So snapshot just contains the data from the firebase database location
  final DataSnapshot snapshot;
//controls the animation for (I think) when a new chatmessage is created
  final Animation animation;
  @override
  Widget build(BuildContext context) {
//animation
    return new SizeTransition(
        sizeFactor:
            new CurvedAnimation(parent: animation, curve: Curves.easeOut),
        axisAlignment: 0.0,
//layout
        child: new Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(snapshot.value[
                      'senderPhotoUrl']), //uses the snapshot (firebase data) to get the user's photo id
                ),
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                      snapshot.value[
                          'senderName'], //uses the snapshot (firebase data) to show the user's name
                      style: Theme.of(context).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: snapshot.value['imageUrl'] != null
                        ? //if the user sent an image then here is that data
                        new Image.network(
                            snapshot.value['imageUrl'],
                            width: 250.0,
                          )
                        : new Text(
                            snapshot.value['text']), //otherwise show the text
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

//Basically home, takes up the whole screen
class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

//ChatScreen is stateful
class ChatScreenState extends State<ChatScreen> {
//this controller notifies the listeners when the text composer changes (basically handles the text composer)
  final TextEditingController _textController = new TextEditingController();
//a Reference represents a specific location in your Database
//in this instance the reference is the "messages" child of the database which holds all of the sent messages
  final reference = FirebaseDatabase.instance.reference().child('messages');
//handles whether there or not there is text in the text composer
  bool _isComposing = false;
//Handles what happens when the user sends either a text message or an image (using image picker)
//async immediately returns a Future which is going to be completed "later"
//We make this function async because we want to use "await" when trying to login
  Future<Null> _handleSubmitted(String text) async {
    _textController.clear(); //clears the text from the composer
    setState(() {
      _isComposing = false;
    });
    await _ensureLoggedIn(); //await basically pauses the execution so that _ensureLoggedIn() can complete
    _sendMessage(text: text); //processes the sending of the message/image
  }

//Ensures that the user is logged in (before sending a message)
//we want to use await
  Future<Null> _ensureLoggedIn() async {
    GoogleSignInAccount user = googleSignIn
        .currentUser; //user is a google sign in user that is only logged in if the user has been logged in during this session
//if user is null (meaning the user hasn't logged in during this session yet) then await (which waits until the argument is completed) googleSignIn.signInSilently()
//which signs the user in without a dialog if there is an account that has been logged into before (on this specific app I believe)
    user ?? await googleSignIn.signInSilently();
//is user is still null then signInSilently() didn't have an account to log into
    if (user == null) {
      await googleSignIn
          .signIn(); //opens dialog for user to log into google account
      analytics
          .logLogin(); //once the user is logged in, send that to firebase analytics
    }
    if (auth.currentUser == null) {
      GoogleSignInAuthentication credentials = await googleSignIn.currentUser
          .authentication; //gets the user's google sign in credentials
      await auth.signInWithGoogle(
          //using those credentials to sign in to firebase with google
          idToken: credentials.idToken,
          accessToken: credentials.accessToken);
    }
  }

//handles actually sending the message
  void _sendMessage({String text, String imageUrl}) {
    //will either be a text message or an imageurl from image picker
    reference.push().set({
      //add the message to the database
//the message contains this stuff (unless left blank)
      'text': text,
      'imageUrl': imageUrl,
      'senderName': googleSignIn.currentUser.displayName,
      'senderPhotoUrl': googleSignIn.currentUser.photoUrl,
    });
    analytics.logEvent(
        name: 'send_message'); //log the event "send_message" in analytics
  }

//builds the bar at the bottom that is the text composer (with keyboard)
  Widget _buildTextComposer() {
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: new Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: new Row(children: <Widget>[
              //Send photo button
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 4.0),
                child: new IconButton(
                  icon: new Icon(Icons.photo_camera),
                  onPressed: () async {
                    await _ensureLoggedIn();
                    File imageFile = await ImagePicker
                        .pickImage(); //wait until the user picks a name
                    int random = new Random()
                        .nextInt(100000); //random number to use for image id
                    StorageReference ref = FirebaseStorage.instance.ref().child(
                        "image_$random.jpg"); //add the file to firebase storage with this name
                    StorageUploadTask uploadTask = ref.put(
                        imageFile); //uploads the actual file (in the ref that was created above)
                    Uri downloadUrl = (await uploadTask.future)
                        .downloadUrl; //Not completely sure. I think this creates a "url"(or uri but I don't know the difference) to be used later
                    _sendMessage(
                        imageUrl: downloadUrl
                            .toString()); //sends the image's download url (^)(which is used in a NetworkImage widget
                  },
                ),
              ),
              //Send a message
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  onSubmitted: _isComposing ? _handleSubmitted : null,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              //The send icon/text depending on the platform. If there is no text to send then it is inactive
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 4.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                          child: new Text("Send"),
                          onPressed: _isComposing
                              ? () => _handleSubmitted(_textController.text)
                              : null,
                        )
                      : new IconButton(
                          icon: new Icon(Icons.send),
                          onPressed: _isComposing
                              ? () => _handleSubmitted(_textController.text)
                              : null,
                        )),
            ])));
  }

//the build class of the ChatScreen
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Friendlychat"),
          elevation:
              Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0),
      body: new Container(
          child: new Column(
            children: <Widget>[
              new Flexible(
                //creates a scrolling container that animates ite,s when they are inserted or removed
                child: new FirebaseAnimatedList(
                  query:
                      reference, //populates the list. References "messages" in the firebase database
                  sort: (a, b) => b.key.compareTo(a
                      .key), //sorts the messages (by timestamp somehow) (seem to be pushkeys with timestamps and random bits) (still not sure how the list of pushkeys gets to here though)
                  padding: new EdgeInsets.all(8.0), //padding around each item
                  reverse:
                      true, //defines the beginning of the list as the bottom (near the composer)
                  itemBuilder: //builds items "as needed"
                      (_, DataSnapshot snapshot, Animation<double> animation) {
                    //snapshot represents the "read only contents of a row in the database"
                    return new ChatMessage(
                        snapshot: snapshot,
                        animation: animation); //I am not really sure where animation is ever really defined...
                  },
                ),
              ),
              _buildTextComposer(),//builds text composer
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border:
                      new Border(top: new BorderSide(color: Colors.grey[200])))
              : null),
    );
  }
}