

import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineModel{
  String name;
  int amount;
  int phone;
  List<dynamic> location;
  String owner;
  String imageUrl;
  String state;
  String userID;
  int dayLeft;

  MedicineModel({this.userID,this.name,this.amount,this.imageUrl,this.location,this.owner,this.phone,this.state,this.dayLeft});

  factory MedicineModel.fromJison(DocumentSnapshot snapshot){
    var data = snapshot.data;
    return MedicineModel(
        name: data['name'],
      amount: data['amount'],
      location: data['location'],
      imageUrl: data['image'],
      owner: data['owner'],
      phone: data['phone'],
      state: data['state'],
        dayLeft: data['dayleft'],
      userID: data['userid']

    );



}
}


class MedicineModelSearch{
  String name;
  int amount;
  int phone;
  List<dynamic> location;
  String owner;
  String imageUrl;
  String state;
  List<String> searchKey;
  int dayLeft;

  MedicineModelSearch({this.name,this.amount,this.imageUrl,this.location,this.owner,this.phone,this.state,this.searchKey,this.dayLeft});

  factory MedicineModelSearch.fromJison(DocumentSnapshot snapshot){
    var data = snapshot.data;
    return MedicineModelSearch(
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