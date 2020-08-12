


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/models/ChatModel.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class chatServices{

  Future<List<ChatModel>> getChatRoom(BuildContext context) async {
    final QuerySnapshot querySnapshot =
    await Firestore.instance.collection("chatRoom")
        .where("ids", arrayContains: await Common.getUserIdToken())
        .getDocuments();


    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<ChatModel> chatModelList = [];
      for( var snapshot in querySnapshot.documents){
        chatModelList.add(ChatModel.formJison(snapshot));
      }
      return chatModelList;
    }
  }






}
