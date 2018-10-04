import 'package:bucketlist/eventsPage.dart';
import 'package:flutter/material.dart';
import 'objects.dart';
import 'package:bucketlist/Activities/bucketItemPage.dart';
import 'package:date_format/date_format.dart';

class homePage extends StatefulWidget {
  homePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  homePageState createState() => homePageState();
}

class homePageState extends State<homePage> {
  concatGroups(List<Group> groups) {
    String ret = "";
    for (int i = 0; i < groups.length; i++) {
      ret += groups[i].title;
      if (i != groups.length - 1) {
        ret += ", ";
      }
    }
    return ret;
  }

  //TODO: Consider using chips (here and for showing groups)
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

  List<Widget> generateUpcomingEvents(List<Event> events){
    List<Widget> upcomingEvents = new List<Widget>();
    events.sort();
    for(Event event in events){
      //If the event is within the next week
      if(event.startTime.isBefore(new DateTime.now().add(new Duration(days: 7)))){
        upcomingEvents.add(
              GestureDetector(
                onTap: () {
                  Navigator
                      .of(context)
                      .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return eventsPage(event);
                  }));
                },
                child: Card(
                  elevation: 2.0,
                  color: Colors.black38,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0)),
                  child: ListTile(
                    title: Text(
                      event.title,
                      style: TextStyle(color: Colors.amber),
                    ),
                    subtitle: Text(
                      (concatGroups(event.groups)),
                      style: TextStyle(color: Colors.amberAccent),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: generateTagContainers(event),
                    ),
                    leading: Column(
                      children: <Widget>[
                        new Text(formatDate(event.startTime, [M, ' ', dd]), style: TextStyle(color: Colors.orangeAccent)),
                        new Text(formatDate(event.startTime, [HH,':', nn]), style: TextStyle(color: Colors.orangeAccent)),
                      ],
                    )
                  ),
                ),
              ),
            );
      }
    }
    return upcomingEvents;
  }

  generateMainView(List<BucketItem> bucketItems, List<Event> events) {
    List<Widget> children = List<Widget>();
    //Upcoming Events
    children.add(Center(
      child: Text("Upcoming Events",
          style: TextStyle(
              fontSize: 30.0,
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.underline)),
      heightFactor: 2.0,
    ));
    //Events
    children.addAll(generateUpcomingEvents(events));
    //view all events
    children.add(FlatButton(child: new Text("View All")));//TODO: Implement View All
    children.add(Divider(color: Colors.black54,));
    //Bucket Items
    children.add(Center(
      child: Text("Bucket Items",
          style: TextStyle(
              fontSize: 30.0,
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.underline)),
      heightFactor: 2.0,
    ));
    //buckets
    for (BucketItem bucketItem in bucketItems) {
      children.add(
        GestureDetector(
          onTap: () {
            Navigator
                .of(context)
                .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
              return bucketItemPage(bucketItem);
            }));
          },
          child: Card(
            elevation: 2.0,
            color: Colors.black38,
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(2.0)),
            child: ListTile(
              title: Text(
                bucketItem.title,
                style: TextStyle(color: Colors.amber),
              ),
              subtitle: Text(
                (concatGroups(bucketItem.groups)),
                style: TextStyle(color: Colors.amberAccent),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: generateTagContainers(bucketItem),
              ),
            ),
          ),
        ),
      );
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    User user = new User("Username", "Password", phoneNumber: "(720)231-8709");
    Group pangea = new Group("Pangea");
    pangea.addTag(new Tag("Adventure", Colors.red));
    pangea.addTag(new Tag("Chill", Colors.blue));
    pangea.addBucketItem(
        new BucketItem("Denver Aquarium", pangea, pangea.tags[0]));
    pangea.addBucketItem(new BucketItem("Mario Kart", pangea, pangea.tags[1]));
    pangea.addEvent(new Event("Barbeque at Zeke's", "Zeke's House",
        new DateTime(2018, 6, 16, 12), new DateTime(2018,6,16,17), pangea, pangea.tags[1]));
    Group basket = new Group("BasketBros");
    basket.addTag(new Tag("Adventure", Colors.redAccent));
    basket.addTag(new Tag("Ball", Colors.orange));
    basket.addBucketItem(new BucketItem("Hiking", basket, basket.tags[0]));
    basket.addBucketItem(new BucketItem("3v3", basket, basket.tags[1]));
    basket.addEvent(new Event.groupList(
        "House Party at David's",
        "David's House",
        new DateTime(2018, 7, 16, 12),new DateTime(2018,7,16,16),
        user.groups,
        pangea.tags[0]));
    user.joinGroup(pangea);
    user.joinGroup(basket);
    pangea.events[0].addTag(new Tag("Hangout", Colors.cyan));
    pangea.events[0].addTag(new Tag("Food", Colors.yellow));
    List<Activity> activities = List<Activity>();
    for (Group group in user.groups) {
      for (Activity activity in group.getAllActivities()) {
        activities.add(activity);
      }
    }
    List<BucketItem> bucketItems = List<BucketItem>();
    for (Group group in user.groups) {
      for (BucketItem item in group.bucketItems) {
        bucketItems.add(item);
      }
    }
    List<Event> events = List<Event>();
    for (Group group in user.groups) {
      for (Event event in group.events) {
        events.add(event);
      }
    }
    return Scaffold(
      backgroundColor: Colors.white70,
      drawer: Drawer(),
      appBar: AppBar(
        title: Text("My List", style: TextStyle(color: Colors.amber)),
        backgroundColor: Colors.black38,
      ),
      body: ListView(
        children: generateMainView(bucketItems, events),
      ),

    );
  }
}
