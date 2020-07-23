import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/medicenModel.dart';


class MedicineService{
  Firestore _firestore = Firestore.instance;

  Future<List<MedicineModel>> getMedicine( ) async {
    final QuerySnapshot querySnapshot =
     await _firestore.collection("medicen").getDocuments() ;


    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<MedicineModel> medicineModel = [];
      for( var snapshot in querySnapshot.documents){
        medicineModel.add(MedicineModel.fromJison(snapshot));
      }
      return medicineModel; 
    }
  }








}
class MedicineServiceSearch{

  Future<List<MedicineModel>> getMedicineSearch( String query) async {
    final QuerySnapshot querySnapshot =
    await Firestore.instance.collection("medicen")
        .where("searchkey", arrayContains: query)
        .getDocuments();


    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<MedicineModel> medicineModelSearch = [];
      for( var snapshot in querySnapshot.documents){
        medicineModelSearch.add(MedicineModel.fromJison(snapshot));
      }
      return medicineModelSearch;
    }
  }








}


class MedicineServiceFinish{

  Future<List<MedicineModel>> getMedicineFinish(  ) async {
    final QuerySnapshot querySnapshot =
    await Firestore.instance.collection("medicen")
        .where("dayleft", isLessThanOrEqualTo: 2)
        .getDocuments();


    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<MedicineModel> medicineModelSearch = [];
      for( var snapshot in querySnapshot.documents){
        medicineModelSearch.add(MedicineModel.fromJison(snapshot));
      }
      return medicineModelSearch;
    }
  }








}