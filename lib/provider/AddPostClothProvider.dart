

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/provider/AddPostMedicineProvider.dart';
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

class AddPostClothProvider extends ChangeNotifier{


  var location = Location();

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


  final clothName = BehaviorSubject<String>();

  Stream<String> get clothNameStream => clothName.stream;

  Function(String) get clothNameChange => clothName.sink.add;



  final clothDescription = BehaviorSubject<String>();

  Stream<String> get clothDescriptionStream => clothDescription.stream;

  Function(String) get clothDescriptionChange => clothDescription.sink.add;


  final clothAmount = BehaviorSubject<String>();

  Stream<String> get clothAmountStream => clothAmount.stream;

  Function(String) get clothAmountChange => clothAmount.sink.add;

  final phone = BehaviorSubject<String>();

  Stream<String> get phoneStream => phone.stream;

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





  File imageFileCloth;

  Future<void> openGallaryCloth(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);

    imageFileCloth = picture;
    print(imageFileCloth);
    print(picture);
    notifyListeners();
  }

  Future<void> openCameraCloth(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFileCloth = picture;
    print(imageFileCloth.toString());
    notifyListeners();
  }

  onChoseImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ChosseImageCloth();
        });
  }

  FirebaseStorage _storage = FirebaseStorage.instance;
  double chosenLat;
  double chosenLong;

  void createRecordCloth(BuildContext context) async {
    if(clothName.value != null && name.length == 0){

      for(int x = 0 ; x<= clothName.value.length ; x++){
        name.insert(x, clothName.value.substring(0,x));
      }
    }
    String urx;

    if(locationList.length == 0){
      locationList.insert(0, chosenLat);
      locationList.insert(1, chosenLong);
    }
    print(locationList[0]);
    print(locationList[1]);
    if(imageFileCloth != null) {
      StorageReference _storageReference =
      FirebaseStorage.instance.ref().child(
          "Cloth/${p.basename(imageFileCloth.path)}");
      StorageUploadTask storageUploadTask = _storageReference.putFile(
          imageFileCloth);
      StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;

      urx = await snapshot.ref.getDownloadURL();
    }else if(imageFileCloth == null ){
      print(imageFileCloth.path);
      print(urx);
      showDialog(context: context ,
          builder: (BuildContext context) {
            return  DailogError(text: "من فضلك إختر صوره",titleText: "هنالك خطأ فى البيانات",); } );
    }
    if(clothAmount.value != null && clothName.value != null &&  urx != null && locationList[0] != null && locationList[1] != null
        && phone.value != null && name.length>=3 &&  duration.value != null){
      DocumentReference ref = await databaseReference.collection("Cloth")
          .add({
        'amount': int.parse(clothAmount.value.toString()),
        'description': clothDescription.value,
        'name': clothName.value,
        'owner': 'mk',
        'image':  urx,
        'location':  locationList,
        'phone':  int.parse(phone.value.toString()),
        'searchkey':name,
        'state': selectedsState,
       'clothstate': selectedsStateType,
        'dayleft': int.parse(duration.value.toString()),


      }).then(done()).whenComplete(close(context));
      print(ref.documentID);}
     else if((locationList[0] == null || locationList[1] == null) && imageFileCloth != null && urx != null){
      showDialog(context: context ,
          builder: (BuildContext context) {
            return
              DailogError(text: "من فضلك إختر الموقع",titleText: "هنالك خطأ فى البيانات",);
          } );
    }
     else if(clothAmount.value == null || clothName.value == null || phone.value == null || name.length <3 || duration.value == null){
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
    print(int.parse(clothAmount.value.toString()));
    print(int.parse(phone.value.toString()));
    print(int.parse(duration.value.toString()));

  }



  close(BuildContext context){

    Navigator.pop(context);
    clothAmount.value =null;
    clothDescription.value = null;
    clothName.value = null;
    locationList.clear();
    phone.value =null;
    name.clear();duration.value =null;
    imageFileCloth= null;
  }

  done(){
    print("ggggggggggggggggggggggggggggggggggggggggggggggg");
  }
  @override
  void dispose() {
    // TODO: implement dispose
    clothName.close();
    clothAmount.close();
    phone.close();
    clothDescription.close();
    datev.close();
    duration.close();
    super.dispose();
  }


}