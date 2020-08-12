


import 'package:cloud_firestore/cloud_firestore.dart';

class Delete{



  deleteDocument(String documentName, String documentId){
    Firestore.instance.collection("$documentName").document("$documentId").delete();
  }






}