import 'package:cloud_firestore/cloud_firestore.dart';

class FurnitureModel{
  String name;
  int amount;
  int phone;
  String location;
  String owner;
  String imageUrl;
  String state;
  int dayLeft;

  FurnitureModel({this.name,this.amount,this.imageUrl,this.location,this.owner,this.phone,this.state,this.dayLeft});

  factory FurnitureModel.fromJison(DocumentSnapshot snapshot){
    var data = snapshot.data;
    return FurnitureModel(
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


class FurnitureModelSearch{
  String name;
  int amount;
  int phone;
  String location;
  String owner;
  String imageUrl;
  String state;
  List<String> searchKey;
  int dayLeft;

  FurnitureModelSearch({this.name,this.amount,this.imageUrl,this.location,this.owner,this.phone,this.state,this.searchKey,this.dayLeft});

  factory FurnitureModelSearch.fromJison(DocumentSnapshot snapshot){
    var data = snapshot.data;
    return FurnitureModelSearch(
        name: data['name'],
        amount: data['amount'],
        location: data['location'],
        imageUrl: data['image'],
        owner: data['owner'],
        phone: data['phone'],
        state: data['state'],
        searchKey: data['searchkey'],
        dayLeft: data['dayleft']

    );



  }
}