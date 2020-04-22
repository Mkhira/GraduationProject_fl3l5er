




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/models/BloodNeedyModel.dart';

class BloodNeedyService{
  Firestore _firestore = Firestore.instance;

  Future<List<BloodNeedyModel>> getNeedy( ) async {
    final QuerySnapshot querySnapshot =
    await _firestore.collection("bloodNeedy").getDocuments() ;


    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<BloodNeedyModel> bloodNeedyList = [];
      for( var snapshot in querySnapshot.documents){
        bloodNeedyList.add(BloodNeedyModel.formJison(snapshot));
      }
      return bloodNeedyList;
    }
  }








}
