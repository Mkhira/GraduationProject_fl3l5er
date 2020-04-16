import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/charityModel.dart';


class charityService{
  Firestore _firestore = Firestore.instance;

  Future<List<charityModel>> getcharity() async {
    final QuerySnapshot querySnapshot =
    await _firestore.collection("charity").getDocuments();
    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<charityModel> charitymodel = [];
      for( var snapshot in querySnapshot.documents){
        charitymodel.add(charityModel.fromJison(snapshot));
      }
      return charitymodel;
    }
  }
}