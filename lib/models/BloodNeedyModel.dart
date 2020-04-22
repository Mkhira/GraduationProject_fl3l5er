
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class BloodNeedyModel{

   String imageUrl;
   String name;
   String description;
   String blood;
   int neededAmount;
   int collectedAmount;
   int duration;
   String bloodBankId;
   String hospitalName;

   BloodNeedyModel({this.imageUrl,this.name,this.description,this.blood,this.collectedAmount,this.neededAmount,this.duration,this.bloodBankId,this.hospitalName});

   factory BloodNeedyModel.formJison(DocumentSnapshot snapshot){
     var data = snapshot;
     return BloodNeedyModel(
       imageUrl: data['image'],
       name: data['name'],
       description: data["descroption"],
       blood: data["blood"],
       neededAmount: data["neededAmount"],
       collectedAmount: data["collectedAmount"],
       duration: data["duration"],
       bloodBankId: data["bloodBankId"],
       hospitalName: data["hospitalName"],
     );
   }

}