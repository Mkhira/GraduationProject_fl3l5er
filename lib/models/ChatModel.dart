


import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{

  String userId;
  List<dynamic> ids;
  String roomId;
  String usersName;
  String usersImage;

  ChatModel({this.roomId,this.ids,this.userId,this.usersName,this.usersImage});

  factory ChatModel.formJison(DocumentSnapshot snapshot){
    var data = snapshot;
    return ChatModel(
      roomId: data['chatrooid'],
        ids: data['ids'],
      userId:data["userid"],
      usersName: data["username"],
      usersImage: data["userimage"]
    );
  }
}