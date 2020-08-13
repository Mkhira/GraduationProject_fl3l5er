

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/Block/Block.dart';
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

class AddPostMedicineProvider extends ChangeNotifier{
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




  final medicineName = BehaviorSubject<String>();

  Stream<String> get medicineNameStream => medicineName.stream;

  Function(String) get medicineNameChange => medicineName.sink.add;



  final medicineDescription = BehaviorSubject<String>();

  Stream<String> get medicineDescriptionStream => medicineDescription.stream;

  Function(String) get medicineDescriptionChange => medicineDescription.sink.add;


  final medicineAmount = BehaviorSubject<String>();

  Stream<String> get medicineAmountStream => medicineAmount.stream;

  Function(String) get medicineAmountChange => medicineAmount.sink.add;

  final phone = BehaviorSubject<String>();

  Stream<String> get phoneStream => phone.stream.transform(validator.phone);

  Function(String) get phoneChange => phone.sink.add;


  final datev = BehaviorSubject<String>();

  Stream<String> get dateStream => datev.stream;

  Function(String) get dateChange => datev.sink.add;



  final duration = BehaviorSubject<String>();

  Stream<String> get durationStream => duration.stream;

  Function(String) get durationChange => duration.sink.add;



  DateTime dateTime;


  datePicker(BuildContext context){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(3333)).then((date){
      dateTime = date;
      datev.value = date.toString();
      notifyListeners();
    });
  }



  final databaseReference = Firestore.instance;



  List<String> name=[];
  List<double> locationList=[];

  String url ='';





  File imagefile;

  Future<void> openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);

    imagefile = picture;
    print(imagefile);
    notifyListeners();
  }

  Future<void> openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    imagefile = picture;
    print(imagefile.toString());
    notifyListeners();
  }

  onChoseImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ChosseImage();
        });
  }

  FirebaseStorage _storage = FirebaseStorage.instance;
  double chosenLat;
  double chosenLong;

  void createRecord(BuildContext context) async {
    if(medicineName.value != null && name.length == 0){

      for(int x = 0 ; x<= medicineName.value.length ; x++){
        name.insert(x, medicineName.value.substring(0,x));
      }
    }
    String urx;

    if(locationList.length == 0){
      locationList.insert(0, chosenLat);
      locationList.insert(1, chosenLong);
    }

    if(imagefile != null) {
      StorageReference _storageReference =
      FirebaseStorage.instance.ref().child(
          "medicen/${p.basename(imagefile.path)}");
      StorageUploadTask storageUploadTask = _storageReference.putFile(
          imagefile);
      StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;

      urx = await snapshot.ref.getDownloadURL();
    }else if(imagefile == null ){
      showDialog(context: context ,
          builder: (BuildContext context) {
            return  DailogError(text: "من فضلك إختر صوره",titleText: "هنالك خطأ فى البيانات",); } );
    }
    if(medicineAmount.value != null && medicineName.value != null &&  urx != null && locationList[0] != null && locationList[1] != null
        && phone.value != null && name.length>=3 && dateTime != null && duration.value != null){
      DocumentReference ref = await Firestore.instance.collection("medicine").document();
      ref.setData({
        'amount': int.parse(medicineAmount.value.toString()),
        'description': medicineDescription.value,
        'name': medicineName.value,
        'owner': (value == false) ?"مجهول" : Provider.of<InfoProvider>(context).nameProfile,
        'image':  urx,
        'location':  locationList,
        'phone':  int.parse(phone.value.toString()),
        'searchkey':name,
        'state': selectedsState,
        'date': DateFormat('dd/MM/yyyy ')
            .format(DateTime.parse(dateTime.toString()))
            .toString(),
        'dayleft': int.parse(duration.value.toString()),
        'userid': Provider.of<InfoProvider>(context).UserLoginId,
        "documentId": ref.documentID,
        "userImage": Provider.of<InfoProvider>(context).imageUrlProfile,
        "ownerName":Provider.of<InfoProvider>(context).nameProfile,



      }).then(close(context)).whenComplete(done());
      print(ref.documentID);
    } else if((locationList[0] == null || locationList[1] == null) && imagefile != null && urx != null){
      showDialog(context: context ,
          builder: (BuildContext context) {
            return
              DailogError(text: "من فضلك إختر الموقع",titleText: "هنالك خطأ فى البيانات",);
          } );
    } else if(medicineAmount.value == null || medicineName.value == null || phone.value == null || name.length <3 || dateTime == null || duration.value == null){
      showDialog(context: context ,
          builder: (BuildContext context) {
            return
              DailogError(text: "من فضلك تأكد من ادخال جميع البيانات ",titleText: "هنالك خطأ فى البيانات",);
          } );
    }else { showDialog(context: context ,
        builder: (BuildContext context) {
          return
            DailogError(text: "من فضلك تأكد من الاتصال بالإنترنت ",titleText: "هنالك خطأ فى البيانات",);
        } );

    }
//    print(int.parse(medicineAmount.value.toString()));
//    print(int.parse(phone.value.toString()));
//    print(int.parse(duration.value.toString()));

  }



  close(BuildContext context){

    Navigator.pop(context);
    medicineAmount.value =null;
    medicineDescription.value = null;
    medicineName.value = null;
    locationList.clear();
    phone.value =null;
    name.clear();duration.value =null;
    imagefile= null;
  }
Bloc _bloc;
  done(){
//    _bloc.fetchMedicineFinish();
//    _bloc.fetchMedicine();
    print("ggggggggggggggggggggggggggggggggggggggggggggggg");
  }
  @override
  void dispose() {
    // TODO: implement dispose
    medicineName.close();
    medicineAmount.close();
    phone.close();
    medicineDescription.close();
    datev.close();
    duration.close();
    super.dispose();
  }


}