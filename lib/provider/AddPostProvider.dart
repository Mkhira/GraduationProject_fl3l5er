

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/wedgit/ChosseImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class AddPostProvider extends ChangeNotifier{


  List<String> dropState = ['Donate','Demond'];
  String selectedsState = 'Donate';


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

  Stream<String> get phoneStream => phone.stream;

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
  }

  onChoseImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ChosseImage();
        });
  }

  FirebaseStorage _storage = FirebaseStorage.instance;


  void createRecord() async {
    if(medicineName.value != null){

      for(int x = 0 ; x<= medicineName.value.length ; x++){
        name.insert(x, medicineName.value.substring(0,x));
      }
    }


    StorageReference _storageReference =
    FirebaseStorage.instance.ref().child("medicen/${p.basename(imagefile.path)}");
    StorageUploadTask storageUploadTask = _storageReference.putFile(imagefile);
    StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
    String urx  = await snapshot.ref.getDownloadURL();


    DocumentReference ref = await databaseReference.collection("medicen")
        .add({
      'amount': int.parse(medicineAmount.value.toString()),
      'description': medicineDescription.value,
      'name': medicineName.value,
      'owner': 'mk',
      'image':  urx,
      'location':  'hhhhhhhh',
      'phone':  int.parse(phone.value.toString()),
      'searchkey':name,
      'state': selectedsState,
      'date': DateFormat('dd/MM/yyyy ')
          .format(DateTime.parse(dateTime.toString()))
          .toString(),
      'dayleft': int.parse(duration.value.toString()),


    });
    print(int.parse(medicineAmount.value.toString()));
    print(int.parse(phone.value.toString()));
    print(int.parse(duration.value.toString()));
    print(ref.documentID);
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