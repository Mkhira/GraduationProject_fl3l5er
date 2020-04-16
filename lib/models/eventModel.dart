
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class EventModel{
    String eventName;
    String location;
    int duration;
    String imageUrl;
    int amount;
    int need;
EventModel({this.location,this.duration,this.eventName,this.imageUrl,this.amount,this.need});
  factory  EventModel.fromJison(DocumentSnapshot snapshot){
        var data = snapshot.data;
             return EventModel(
                 eventName: data['name'],
                 duration: data['duration'],
                 imageUrl: data['image'],
                 location: data['location'],
               amount: data['amount'],
               need: data['need']


             );
    }

}