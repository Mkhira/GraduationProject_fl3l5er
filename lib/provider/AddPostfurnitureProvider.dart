

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/Block/Validator.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/wedgit/ChosseImage.dart';
import 'package:company_task/wedgit/FriebaseErrorDailog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class AddPostFurnitureProvider extends ChangeNotifier{
  Validator validator = Validator();

  var location = Location();
  bool value = false;

  Future checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }
  List<String> dropState = ['متبرع','طالب'];
  String selectedsState = 'متبرع';


  ChosseState(String newValue){

    selectedsState = newValue;
    notifyListeners();
  }


  List<String> dropStateType = ['مستعمل','جديد'];
  String selectedsStateType = 'مستعمل';


  ChosseStateType(String newValue){

    selectedsStateType = newValue;
    notifyListeners();
  }


  final furnitureName = BehaviorSubject<String>();

  Stream<String> get furnitureStream => furnitureName.stream;

  Function(String) get furnitureChange => furnitureName.sink.add;



  final furnitureDescription = BehaviorSubject<String>();

  Stream<String> get furnitureDescriptionStream => furnitureDescription.stream;

  Function(String) get furnitureDescriptionChange => furnitureDescription.sink.add;


  final furnitureAmount = BehaviorSubject<String>();

  Stream<String> get furnitureAmountStream => furnitureAmount.stream;

  Function(String) get furnitureAmountChange => furnitureAmount.sink.add;

  final phone = BehaviorSubject<String>();

  Stream<String> get phoneStream => phone.stream.transform(validator.phone);

  Function(String) get phoneChange => phone.sink.add;


  final datev = BehaviorSubject<String>();

  Stream<String> get dateStream => datev.stream;

  Function(String) get dateChange => datev.sink.add;



  final duration = BehaviorSubject<String>();

  Stream<String> get durationStream => duration.stream;

  Function(String) get durationChange => duration.sink.add;








  final databaseReference = Firestore.instance;



  List<String> name=[];
  List<double> locationList=[];

  String url ='';





  File imageFileFurniture;

  Future<void> openGallaryFurniture(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);

    imageFileFurniture = picture;
    print(imageFileFurniture);
    print(picture);
    notifyListeners();
  }

  Future<void> openCameraFurniture(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFileFurniture = picture;
    print(imageFileFurniture.toString());
    notifyListeners();
  }

  onChoseImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ChosseImageFurniture();
        });
  }

  FirebaseStorage _storage = FirebaseStorage.instance;
  double chosenLat;
  double chosenLong;

  void createRecordFurniture(BuildContext context) async {
    if(furnitureName.value != null && name.length == 0){

      for(int x = 0 ; x<= furnitureName.value.length ; x++){
        name.insert(x, furnitureName.value.substring(0,x));
      }
    }
    String urx;

    if(locationList.length == 0){
      locationList.insert(0, chosenLat);
      locationList.insert(1, chosenLong);
    }

    if(imageFileFurniture != null) {
      StorageReference _storageReference =
      FirebaseStorage.instance.ref().child(
          "Furniture/${p.basename(imageFileFurniture.path)}");
      StorageUploadTask storageUploadTask = _storageReference.putFile(
          imageFileFurniture);
      StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;

      urx = await snapshot.ref.getDownloadURL();
    }else if(imageFileFurniture == null ){
      print(imageFileFurniture.path);
      print(urx);
      showDialog(context: context ,
          builder: (BuildContext context) {
            return  DailogError(text: "من فضلك إختر صوره",titleText: "هنالك خطأ فى البيانات",); } );
    }
    if(furnitureAmount.value != null && furnitureName.value != null &&  urx != null && locationList[0] != null && locationList[1] != null
        && phone.value != null && name.length>=3 &&  duration.value != null){
      DocumentReference ref = await databaseReference.collection("Furniture").document();
          ref.setData({
        'amount': int.parse(furnitureAmount.value.toString()),
        'description': furnitureDescription.value,
        'name': furnitureName.value,
        'owner': (value == false) ?"مجهول" : Provider.of<InfoProvider>(context).nameProfile,
        'image':  urx,
        'location':  locationList,
        'phone':  int.parse(phone.value.toString()),
        'searchkey':name,
        'state': selectedsState,
        'furnitureState': selectedsStateType,
        'dayleft': int.parse(duration.value.toString()),
        'userid': Provider.of<InfoProvider>(context).UserLoginId,
        "documentId": ref.documentID,
          "userImage": Provider.of<InfoProvider>(context).imageUrlProfile,
            "ownerName":Provider.of<InfoProvider>(context).nameProfile,




          }).whenComplete(close(context));
      print(ref.documentID);}
    else if((locationList[0] == null || locationList[1] == null) && imageFileFurniture != null && urx != null){
      showDialog(context: context ,
          builder: (BuildContext context) {
            return
              DailogError(text: "من فضلك إختر الموقع",titleText: "هنالك خطأ فى البيانات",);
          } );
    }
    else if(furnitureAmount.value == null || furnitureName.value == null || phone.value == null || name.length <3 || duration.value == null){
      showDialog(context: context ,
          builder: (BuildContext context) {
            return
              DailogError(text: "من فضلك تأكد من ادخال جميع البيانات ",titleText: "هنالك خطأ فى البيانات",);
          } );
    }
    else { showDialog(context: context ,
        builder: (BuildContext context) {
          return
            DailogError(text: "من فضلك تأكد من الاتصال بالإنترنت ",titleText: "هنالك خطأ فى البيانات",);
        } );

    }
    print(int.parse(furnitureAmount.value.toString()));
    print(int.parse(phone.value.toString()));
    print(int.parse(duration.value.toString()));

  }



  close(BuildContext context){

    Navigator.pop(context);
    furnitureAmount.value =null;
    furnitureDescription.value = null;
    furnitureName.value = null;
    locationList.clear();
    phone.value =null;
    name.clear();duration.value =null;
    imageFileFurniture= null;
  }

  done(){
    print("ggggggggggggggggggggggggggggggggggggggggggggggg");
  }
  @override
  void dispose() {
    // TODO: implement dispose
    furnitureName.close();
    furnitureAmount.close();
    phone.close();
    furnitureDescription.close();
    datev.close();
    duration.close();
    super.dispose();
  }

}