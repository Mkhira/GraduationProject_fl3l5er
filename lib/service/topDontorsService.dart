import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/topDonatersmodel.dart';

class TopDonatorsService {
  Firestore _firestore = Firestore.instance;

  Future<List<TopDonatorsModel>> getTopdDonators() async {
    final QuerySnapshot querySnapshot =
    await _firestore.collection("topDonators").getDocuments();
    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<TopDonatorsModel> topdonatorsmodel = [];
      for( var snapshot in querySnapshot.documents){
        topdonatorsmodel.add(TopDonatorsModel.formJison(snapshot));
      }
      return topdonatorsmodel;
    }
  }
}
