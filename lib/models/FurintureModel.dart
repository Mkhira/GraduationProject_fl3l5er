import 'package:cloud_firestore/cloud_firestore.dart';

class FurnitureModel{
  String name;
  int amount;
  int phone;
  List<dynamic> location;
  String owner;
  String imageUrl;
  String state;
  String userID;
  String documentId;
  String userImage;
  String description;
  String ownerName;
  String furnitureState;

  int dayLeft;

  FurnitureModel({this.furnitureState,this.ownerName,this.description,this.userImage,this.documentId,this.userID,this.name,this.amount,this.imageUrl,this.location,this.owner,this.phone,this.state,this.dayLeft});

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
        dayLeft: data['dayleft'],
      userID: data['userid'],
      documentId: data["documentId"],
      userImage: data["userImage"],
      description: data["description"],
      ownerName: data["ownerName"],
      furnitureState: data["furnitureState"],

    );



  }
}


class FurnitureModelSearch{
  String name;
  int amount;
  int phone;
  List<dynamic> location;
  String owner;
  String imageUrl;
  String state;
  String documentId;
  String userImage;
  String description;
  String ownerName;
  List<String> searchKey;
  int dayLeft;

  FurnitureModelSearch({this.ownerName,this.description,this.userImage,this.documentId,this.name,this.amount,this.imageUrl,this.location,this.owner,this.phone,this.state,this.searchKey,this.dayLeft});

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
        dayLeft: data['dayleft'],
      documentId: data["documentId"],
      userImage: data["userImage"],
      description: data["description"],
      ownerName: data["ownerName"],

    );



  }
}