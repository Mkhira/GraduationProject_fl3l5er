import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/models/FurintureModel.dart';



class FurnitureService{
  Firestore _firestore = Firestore.instance;

  Future<List<FurnitureModel>> getFurniture( ) async {
    final QuerySnapshot querySnapshot =
    await _firestore.collection("Furniture").getDocuments() ;


    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<FurnitureModel> furnitureModel = [];
      for( var snapshot in querySnapshot.documents){
        furnitureModel.add(FurnitureModel.fromJison(snapshot));
      }
      return furnitureModel;
    }
  }








}
class FurnitureServiceSearch{

  Future<List<FurnitureModel>> getFurnitureSearch( String query) async {
    final QuerySnapshot querySnapshot =
    await Firestore.instance.collection("Furniture")
        .where("searchkey", arrayContains: query)
        .getDocuments();


    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<FurnitureModel> furnitureModelSearch = [];
      for( var snapshot in querySnapshot.documents){
        furnitureModelSearch.add(FurnitureModel.fromJison(snapshot));
      }
      return furnitureModelSearch;
    }
  }








}


class FurnitureServiceFinish{

  Future<List<FurnitureModel>> getFurnitureFinish(  ) async {
    final QuerySnapshot querySnapshot =
    await Firestore.instance.collection("Furniture")
        .where("dayleft", isLessThanOrEqualTo: 2)
        .getDocuments();


    if (querySnapshot.documents.length == 0) {
      return null;
    } else {
      List<FurnitureModel> furnitureModelSearch = [];
      for( var snapshot in querySnapshot.documents){
        furnitureModelSearch.add(FurnitureModel.fromJison(snapshot));
      }
      return furnitureModelSearch;
    }
  }








}