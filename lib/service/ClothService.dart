import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/models/ClothesModel.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';








class ClothService{
  Firestore _firestore = Firestore.instance;
  Future<List<ClothModel>> getCloth( ) async {
    final QuerySnapshot querySnapshot =
    await _firestore.collection("Cloth").getDocuments() ;


    if (querySnapshot.documents.length == 0) {
      return null;
    }
    else {
      List<ClothModel> clothModel = [];
      for( var snapshot in querySnapshot.documents){
        clothModel.add(ClothModel.fromJison(snapshot));
      }
      return clothModel;
    }
  }

}
class ClothServiceSearch {
  Future<List<ClothModel>> getClothSearch(String query) async {
    final QuerySnapshot querySnapshot =
    await Firestore.instance.collection("Cloth")
        .where("searchkey", arrayContains: query)
        .getDocuments();
    if (querySnapshot.documents.length == 0) {
      return null;
    }
    else {
      List<ClothModel> clothModelSearch = [];
      for (var snapshot in querySnapshot.documents) {
        clothModelSearch.add(ClothModel.fromJison(snapshot));
      }
      return clothModelSearch;
    }
  }

}










  class ClothServicefinsh{

  Future<List<ClothModel>> getClothFinish() async {
  final QuerySnapshot querySnapshot =
  await Firestore.instance.collection("Cloth")
      .where("dayleft", isLessThanOrEqualTo: 2)
      .getDocuments();


  if (querySnapshot.documents.length == 0) {
  return null;
  } else {
  List<ClothModel> clothModelSearch = [];
  for( var snapshot in querySnapshot.documents){
  clothModelSearch.add(ClothModel.fromJison(snapshot));
  }
  return clothModelSearch;
  }
  }






}



class ClothProfile{

  Future<List<ClothModel>> getClothProfile(BuildContext context) async {
    String userID = await Common.getUserIdToken();
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");
    print(userID);
    print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrr");

    final QuerySnapshot querySnapshot =
    await Firestore.instance.collection("Cloth")
        .where("userid", isEqualTo: Provider.of<InfoProvider>(context).UserLoginId)
        .getDocuments();

    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<ClothModel> medicineModelSearch = [];
      for( var snapshot in querySnapshot.documents){
        medicineModelSearch.add(ClothModel.fromJison(snapshot));
      }
      return medicineModelSearch;
    }
  }








}
