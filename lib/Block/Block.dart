import 'dart:async';
import 'package:company_task/models/BloodNeedyModel.dart';
import 'package:company_task/models/charityModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'Validator.dart';
import 'package:provider/provider.dart';
import '../provider/info_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/registerModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../wedgit/fireBaseError wedgit.dart';
import '../models/eventModel.dart';
import '../service/repostry.dart';
import 'package:rxdart/futures.dart';
import '../models/topDonatersmodel.dart';
import '../models/medicenModel.dart';
import '../service/MedicineService.dart';
import '../service/MedicineService.dart';
class Bloc extends Object with Validator {

  final _email = BehaviorSubject<String>();

  final _fristName = BehaviorSubject<String>();
  final _lastName = BehaviorSubject<String>();

  final _nickName = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();


  final _confirmPassword = BehaviorSubject<String>();
  final _numKids = BehaviorSubject<String>();
  final _jop = BehaviorSubject<String>();
  final _salary = BehaviorSubject<String>();
  final _cardId = BehaviorSubject<String>();
  final _phone = BehaviorSubject<String>();
  final _date = BehaviorSubject<String>();
  final _country = BehaviorSubject<String>();
  final _governate = BehaviorSubject<String>();
  final _city = BehaviorSubject<String>();
  final _street = BehaviorSubject<String>();





  Validator validator = Validator();

  // Stream
  Stream<String> get emailStream => _email.stream.transform(validator.validateEmail);

  Stream<String> get firstNameStream => _fristName.stream.transform(validator.validateFirstName);
  Stream<String> get lastNameStream => _lastName.stream.transform(validator.validateFirstName);
  Stream<String> get nickNameStream => _nickName.stream;
  Stream<String> get passwordStream => _password.stream.transform(validator.validatePassword);
  Stream<String> get confirmPasswordStream => _confirmPassword.stream.transform(validator.validateConfirmPassword);
  Stream<String> get numKidsStream => _numKids.stream;
  Stream<String> get jopStream => _jop.stream.transform(validator.validateStrng);
  Stream<String> get salaryStream => _salary.stream;
  Stream<String> get cardIdStream => _cardId.stream;
  Stream<String> get phoneStream => _phone.stream;
  Stream<String> get dateStream => _date.stream;
  Stream<String> get countryStream => _country.stream.transform(validator.validateStrng);
  Stream<String> get cityStream => _city.stream.transform(validator.validateStrng);
  Stream<String> get governateStream => _governate.stream.transform(validator.validateStrng);
  Stream<String> get streetStream => _street.stream.transform(validator.validateStrng);




  Stream<bool> get submitButtonStream => Observable.combineLatest4(emailStream , firstNameStream,lastNameStream,nickNameStream ,(e , a,l,n )=> true);

// change data


  Function(String) get emailChange => _email.sink.add;
  Function(String) get passwordChange => _password.sink.add;
  Function(String) get confirmPasswordChange => _confirmPassword.sink.add;
  Function(String) get firstNameChange => _fristName.sink.add;
  Function(String) get lastNameChange => _lastName.sink.add;
  Function(String) get nickNameChange => _nickName.sink.add;
  Function(String) get numKidsChange => _numKids.sink.add;
  Function(String) get jopChange => _jop.sink.add;
  Function(String) get salaryChange => _salary.sink.add;
  Function(String) get cardIdChange => _cardId.sink.add;
  Function(String) get phoneChange => _phone.sink.add;
  Function(String) get dateChange => _date.sink.add;
  Function(String) get countryChange => _country.sink.add;
  Function(String) get governateChange => _governate.sink.add;
  Function(String) get cityChange => _city.sink.add;
  Function(String) get streetChange => _street.sink.add;




  final _auth = FirebaseAuth.instance;

  get auth{
    return _auth;
  }


  authFunction() async{
    final user = await _auth.signInWithEmailAndPassword(email: _email.value, password: _password.value);
  }

  final databaseReference = FirebaseDatabase.instance.reference();


//  void createRecord(BuildContext context){
//    databaseReference.child(_cardId.value).set({
//      "email":_email.value,
//      "firstName":_fristName.value,
//      "lastName":_lastName.value,
//      "nickName":_nickName.value,
//      "password":_password.value,
//      "address":"${_country.value+"/"+_governate.value+"/"+_city.value+"/"+_street.value}",
//      "date":_date.value,
//      "phone":_phone.value,
//      "jop":"${Provider.of<TaskData>(context).jopReturn()}",
//      "gender":"${Provider.of<TaskData>(context).genderReturn()}",
//      "kidsNum":_numKids.value,
//      "maritalStatus":"${Provider.of<TaskData>(context).stateReturn()}",
//      "salary":_salary.value,
//    });
//
//  }
  final Firestore firestore = Firestore();


  createProfileData(BuildContext context, )async{
//    final snapShot = await Firestore.instance;
    final snapShot = await Firestore.instance.collection('userData').document(_cardId.value).get();

    if(!snapShot.exists&& _cardId.value != null &&_email.value !=null&& _fristName.value != null &&_lastName.value !=null&& _nickName.value != null &&_password.value !=null&& Provider.of<InfoProvider>(context).genderReturn() != null ) {
      if(_password.value == _confirmPassword.value){
        firestore.collection("userData").document(_cardId.value).setData({
          "email": _email.value,
          "firstName": _fristName.value,
          "lastName": _lastName.value,
          "nickName": _nickName.value,
          "password": _password.value,
          "address": (_country.value == null || _governate.value ==null || _city.value == null || _street.value == null) ? "" : "${_country.value + "/" + _governate.value + "/" +
              _city.value + "/" + _street.value}",
          "date": _date.value,
          "phone": _phone.value,
          "jop": (Provider.of<InfoProvider>(context).jopReturn() == "") ? "" : "${Provider.of<InfoProvider>(context).jopReturn()}",
          "gender": "${Provider.of<InfoProvider>(context).genderReturn()}",
          "kidsNum": (_numKids.value == null) ?"":_numKids.value,
          "maritalStatus": (Provider.of<InfoProvider>(context).stateReturn() == "") ? "" : "${Provider.of<InfoProvider>(context).stateReturn()}",
          "salary":(_salary.value == null) ? "" : _salary.value,
        }).whenComplete(Provider.of<InfoProvider>(context).login(context));

      }else{
           passwordNotMatch(context);
      }
    }if(snapShot.exists){
           idExsits(context);
    }
    else if(_cardId.value == null ||_email.value ==null|| _fristName.value == null || _lastName.value ==null || _nickName.value == null ||_password.value ==null || Provider.of<InfoProvider>(context).genderReturn() == "" ){
      missingData(context);

    }
  }





  void idExsits(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return dailogerror(titleText: "Id error",text: "this Id aulreadr exist",);
        });
  }
  void missingData(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return dailogerror(titleText: "Missing data",text: "Please enter important data",);
        });
  }
  void passwordNotMatch(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return dailogerror(titleText: "Pasword Not match",text: "Please be in sure write the same password",);
        });
  }




//  eventData(TaskData taskData, BuildContext context) async {
//    QuerySnapshot querySnapshot =
//    await Firestore.instance.collection("events").getDocuments();
//    List<EventModel> _event_model=[];
//    querySnapshot.documents.forEach((document){
//      EventModel eventModel = EventModel.fromMap(document.data);
//      _event_model.add(eventModel);
//      Provider.of<TaskData>(context, listen: true).eventModelList =_event_model;
//    });
//  }


eventRepostry _repostry = eventRepostry();

final _evntList = PublishSubject<List<EventModel>>();
  Observable<List<EventModel>> get streamEvent => _evntList.stream;


     fetchEvent() async{
          List<EventModel> _eventmodel = await _repostry.getevent();
          _evntList.sink.add(_eventmodel);
     }

  TopDonatorsRepostry _topdonatorsrepostry = TopDonatorsRepostry();

  final _topList = PublishSubject<List<TopDonatorsModel>>();
  Observable<List<TopDonatorsModel>> get streamtopdonators => _topList.stream;


  fetchTopDonators() async{
    List<TopDonatorsModel> _topmodel = await _topdonatorsrepostry.getTopdDonators();
    _topList.sink.add(_topmodel);
  }


  charityRepostry _charityrepostry = charityRepostry();

  final _chairtyList = PublishSubject<List<charityModel>>();
  Observable<List<charityModel>> get streamCharity => _chairtyList.stream;


  fetchcharity() async{
    List<charityModel> _charitymodel = await _charityrepostry.getcharity();
    _chairtyList.sink.add(_charitymodel);
  }

















  final textController = BehaviorSubject<String>();
  final demond = BehaviorSubject<String>();
  final donate = BehaviorSubject<String>();
  Stream<String> get textStream => textController.stream;
  Stream<String> get demondStream => demond.stream;
  Stream<String> get donateStream => donate.stream;

  Function(String) get demondChange => demond.sink.add;
  Function(String) get donateChange => donate.sink.add;
  Function(String) get textChange => textController.sink.add;

  updateText(String text) {
         textController.sink.add(text);
  }
  updateDemond(String text) {
         demond.sink.add(text);
  }updateDonate(String text) {
         donate.sink.add(text);
  }
  final _medicineListSearch = PublishSubject<List<MedicineModel>>();
  Observable<List<MedicineModel>> get streamMedicinesearch => _medicineListSearch.stream;
  MedicineRepostrySearch _medicineRepostrySearch = MedicineRepostrySearch();


  search()async{

List<MedicineModel> _medicenmodelsearch = await _medicineRepostrySearch.getMedicineSearch(textController.value);

  return _medicineListSearch.sink.add(_medicenmodelsearch);


  }


  MedicineRepostry _medicineRepostry = MedicineRepostry();

  final _medicineList = PublishSubject<List<MedicineModel>>();
  Observable<List<MedicineModel>> get streamMedicine => _medicineList.stream;

  fetchMedicine() async{
    List<MedicineModel> _medicineModel = await _medicineRepostry.getMedicine();
   return _medicineList.sink.add(_medicineModel);
  }

  BloodRepostry _bloodRepostry = BloodRepostry();

  final _bloodNeedyList = PublishSubject<List<BloodNeedyModel>>();
  Observable<List<BloodNeedyModel>> get streamNeedy => _bloodNeedyList.stream;

  fetchBloodNeedy() async{
    List<BloodNeedyModel> _bloodModel = await _bloodRepostry.getNeedy();
    return _bloodNeedyList.sink.add(_bloodModel);
  }







  void dispose() async {
    await _evntList.drain();
    _evntList.close();

    await _topList.drain();
    _evntList.close();


    await _chairtyList.drain();
    _chairtyList.close();


    await _medicineList.drain();
    _medicineList.close();
    textController.close();
    _medicineListSearch.close();
    demond.close();
    donate.close();


    _bloodNeedyList.close();

  }



}
