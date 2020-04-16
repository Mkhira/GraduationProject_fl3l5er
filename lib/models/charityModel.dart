

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class charityModel{
  String image;
  charityModel({this.image});

 factory charityModel.fromJison(DocumentSnapshot snapshot){
   var data = snapshot.data;
      return charityModel(
        image: data['image']
      );
 }
}