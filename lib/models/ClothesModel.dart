

import 'package:cloud_firestore/cloud_firestore.dart';

class ClothModel{
  String name;
  int amount;
  int phone;
  List<dynamic> location;
  String owner;
  String imageUrl;
  String state;
  String clothState;
String description;
  int dayLeft;

  ClothModel({this.name,this.amount,this.imageUrl,this.location,this.owner,this.phone,this.state,this.dayLeft,this.clothState,this.description});

  factory ClothModel.fromJison(DocumentSnapshot snapshot){
    var data = snapshot.data;
    return ClothModel(
        name: data['name'],
        amount: data['amount'],
        location: data['location'],
        imageUrl: data['image'],
        owner: data['owner'],
        phone: data['phone'],
        state: data['state'],
        dayLeft: data['dayleft'],
        clothState: data['clothstate'],
      description: data['description']


    );



  }
}


class ClothModelSearch{
  String name;
  int amount;
  int phone;
  List<dynamic> location;
  String owner;
  String imageUrl;
  String state;
  String clothState;
  List<String> searchKey;
  int dayLeft;
  String description;
  String userID;

  ClothModelSearch({this.userID,this.name,this.amount,this.imageUrl,this.location,this.owner,this.phone,this.state,this.searchKey,this.dayLeft,this.clothState,this.description});

  factory ClothModelSearch.fromJison(DocumentSnapshot snapshot){
    var data = snapshot.data;
    return ClothModelSearch(
        name: data['name'],
        amount: data['amount'],
        location: data['location'],
        imageUrl: data['image'],
        owner: data['owner'],
        phone: data['phone'],
        state: data['state'],
        searchKey: data['sarchkey'],
        dayLeft: data['dayleft'],
        clothState: data['clothstate'],
      description: data['description'],
        userID: data['userid']

    );



  }
}