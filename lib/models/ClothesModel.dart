

import 'package:cloud_firestore/cloud_firestore.dart';

class ClothModel{
  String name;
  int amount;
  int phone;
  String location;
  String owner;
  String imageUrl;
  String state;
  int dayLeft;

  ClothModel({this.name,this.amount,this.imageUrl,this.location,this.owner,this.phone,this.state,this.dayLeft});

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
        dayLeft: data['dayleft']

    );



  }
}


class ClothModelSearch{
  String name;
  int amount;
  int phone;
  String location;
  String owner;
  String imageUrl;
  String state;
  List<String> searchKey;
  int dayLeft;

  ClothModelSearch({this.name,this.amount,this.imageUrl,this.location,this.owner,this.phone,this.state,this.searchKey,this.dayLeft});

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
        dayLeft: data['dayleft']

    );



  }
}