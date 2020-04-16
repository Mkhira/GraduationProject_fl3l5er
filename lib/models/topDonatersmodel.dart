


import 'package:cloud_firestore/cloud_firestore.dart';

class TopDonatorsModel{

  String urlImage;
  String name;
  String field;

  TopDonatorsModel({this.field,this.name,this.urlImage});

  factory TopDonatorsModel.formJison(DocumentSnapshot snapshot){
    var data = snapshot;
    return TopDonatorsModel(
      field: data['field'],
      name: data['name'],
      urlImage: data['image'],
    );
  }
}