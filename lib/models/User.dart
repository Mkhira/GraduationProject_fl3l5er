


import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String email;
  String phone;
  String location;
  String imageUrl;
  String password;
  String gander;
  String name;
  String nationalId;
  String maritalState;
  String jop;
  User({this.email,this.imageUrl,this.location,this.phone,this.password,this.gander,this.name,this.jop,this.maritalState,this.nationalId});

  factory User.fromJison(DocumentSnapshot snapshot){
    var data = snapshot.data;
    return User(
        email: data['email'],
        location: data['location'],
        imageUrl: data['image'],
        phone: data['phone'],
        password: data['password'],
        gander: data['gander'],
      name: data['nmae'],
      jop: data['jop'],
      maritalState: data['maritalstate'],
      nationalId: data['id'],


    );



  }

}