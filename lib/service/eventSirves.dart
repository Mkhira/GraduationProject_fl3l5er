import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/eventModel.dart';

class eventService {
  Firestore _firestore = Firestore.instance;

  Future<List<EventModel>> getevent() async {
    final QuerySnapshot querySnapshot =
        await _firestore.collection("events").getDocuments();
    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<EventModel> eventmodel = [];
      for( var snapshot in querySnapshot.documents){
                eventmodel.add(EventModel.fromJison(snapshot));
      }
      return eventmodel;
    }
  }
}
