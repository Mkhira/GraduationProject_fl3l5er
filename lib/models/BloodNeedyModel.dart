
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class BloodNeedyModel{

   String imageUrl;
   String name;
   String description;
   String bloodType;
   int neededAmount;
   int collectedAmount;
   int age;
   String bloodBankId;
   String hospitalName;
   String userId;
   String postOwnerName;
   String gander;
   List<dynamic> location;

   BloodNeedyModel({this.gander,this.location,this.postOwnerName,this.userId,this.imageUrl,this.name,this.description,this.bloodType,this.collectedAmount,this.neededAmount,this.age,this.bloodBankId,this.hospitalName});

   factory BloodNeedyModel.formJison(DocumentSnapshot snapshot){
     var data = snapshot;
     return BloodNeedyModel(
       imageUrl: data['image'],
       name: data['name'],
       description: data["descroption"],
       bloodType: data["blood"],
       neededAmount: data["neededAmount"],
       collectedAmount: data["collectedAmount"],
       bloodBankId: data["bloodBankId"],
       hospitalName: data["hospitalName"],
       location: data['location'],
       postOwnerName: data['postownername'],
       userId: data['userid'],
       gander: data['gander'],
       age: data['age'],
     );
   }

}