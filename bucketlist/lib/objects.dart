import 'package:flutter/material.dart';

class User {
  String username; //TODO: Do we want a handle and a name or just the handle?
  String
      password; //TODO:This probably won't be a thing we want in the actual app
  List<Group> groups;
  String phoneNumber;
  List<Activity> unGroupedActivities;
  //Adds the member to the groups "member" list and adds the group to the users "group" list
  joinGroup(Group group) {
    group.addMember(this);
    groups.add(group);
  }

  //removes the member from the groups "member" list and removes the group from the users "group" list
  leaveGroup(Group group) {
    group.removeMember(this);
    groups.remove(group);
  }

  //TODO: Test if the .toString() works
  String toString() {
    return "Username: " +
        this.username +
        ", Password: " +
        this.password +
        ", Groups: " +
        groups.toString();
  }

  //Initialize all Users with a username, password, and empty list of groups
  User(this.username, this.password, {this.phoneNumber}) {
    this.groups = List<Group>();
    this.unGroupedActivities = List<Activity>();
  }
}

class Group {
  String title;
  List<User> members;
  List<BucketItem> bucketItems;
  List<Event> events;
  List<Tag> tags;

  //Initialize all groups with a title and lots of empty lists
  Group(this.title) {
    this.members = List<User>();
    this.bucketItems = List<BucketItem>();
    this.events = List<Event>();
    this.tags = List<Tag>();
  }
  //TODO: When a group is first created, the user that created it should be added to "members"
  //Add a member to the group
  addMember(User member) {
    members.add(member);
  }

  //Remove a member from the group
  User removeMember(User member) {
    members.remove(member);
    return member;
  }

  //Add an BucketItem to the bucket list
  addBucketItem(BucketItem BucketItem) {
    bucketItems.add(BucketItem);
  }

  //Permanently removes an BucketItem from the group. This is not completing an BucketItem
  removeBucketItem(BucketItem BucketItem) {
    bucketItems.remove(BucketItem);
  }

  //Add an event to the list of events
  addEvent(Event event) {
    events.add(event);
  }

  //Permanently remove an event.
  Event removeEvent(Event event) {
    events.remove(event);
    return event;
  }

  //TODO: When adding events and activities, check if the tag on the event is in the group
  //Adds a tag to be used for the group
  addTag(Tag tag) {
    tags.add(tag);
  }

  //Remove a tag from the group
  Tag removeTag(Tag tag) {
    tags.remove(tag);
    return tag;
  }

  //Change the group's name
  changeTitle(String title) {
    this.title = title;
  }

  List<Activity> getAllActivities() {
    List<Activity> activities = List<Activity>();
    for(Activity act in bucketItems){
      activities.add(act);
    }
    for(Activity act in events){
      activities.add(act);
    }
    return activities;
  }
}

class Activity {
  String title;
  List<Tag> tags;
  List<Group> groups;
}
class Event extends Activity implements Comparable{
  String title;
  String location; //TODO: Create Location Object
  List<Tag> tags;
  DateTime startTime;
  DateTime endTime;
  List<Group> groups;
  //TODO: Add the ability to PIN certain discussion items
  String
      discussion; //TODO: This might be a little different later. Might be own object (in database?)

  Event(this.title, this.location, this.startTime, this.endTime, Group group, Tag tag, {this.discussion}){
    groups = List<Group>();
    tags = List<Tag>();
    groups.add(group);
    tags.add(tag);
  }

  Event.groupList(this.title, this.location, this.startTime, this.endTime, this.groups, Tag tag, {this.discussion}){
    tags = List<Tag>();
    tags.add(tag);
  }

  addTag(Tag tag){
    tag.addReference(this);
    tags.add(tag);
  }

  Tag removeTag(Tag tag){
    tag.removeReference(this);
    tags.remove(tag);
    return tag;
  }

  addGroup(Group group){
    groups.add(group);
    group.addEvent(this);
  }

  @override
  int compareTo(other) {
    return startTime.compareTo(other.startTime);
  }

  //no removeGroup cause that's awkward

}

class Tag {
  String title;
  Color color;
  List<Activity> references;

  Tag(this.title, this.color) {
    references = List<Activity>();
  }

  //Change the Tag's Color
  changeColor(Color c) {
    this.color = c;
  }
  //Change the Tag's Title
  changeTitle(String t){
    this.title = t;
  }

  addReference(Activity activity){
    references.add(activity);
  }

  Activity removeReference(Activity activity){
    references.remove(activity);
    return activity;
  }
}

class BucketItem extends Activity{
  String title;
  List<Group> groups;//This is a list even though there can only be one to make grouping bucketItems and Events into Activities easier
  List<Tag> tags;
  bool completed;
  DateTime dateCompleted;
  String discussion;

  BucketItem(this.title, Group group, Tag tag, {this.discussion}){
    tags = List<Tag>();
    tags.add(tag);
    groups = List.filled<Group>(1,group);
    this.completed = false;
    this.dateCompleted = null;
  }

  addTag(Tag tag){
    tag.addReference(this);
    tags.add(tag);
  }

  Tag removeTag(Tag tag){
    tag.removeReference(this);
    tags.remove(tag);
    return tag;
  }

  changeTitle(String t){
    this.title = t;
  }

  completeBucketItem(DateTime date) {
    completed = true;
    dateCompleted = date;
  }
  //returns the old group and replaces it with the new group
  Group changeGroup(Group newGroup) {
    Group oldGroup = this.groups[0];
    this.groups[0]=newGroup;
    return oldGroup;
  }
}
