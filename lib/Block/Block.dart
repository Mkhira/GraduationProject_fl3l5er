import 'dart:async';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/models/BloodNeedyModel.dart';
import 'package:company_task/models/ClothesModel.dart';
import 'package:company_task/models/FurintureModel.dart';
import 'package:company_task/models/User.dart';
import 'package:company_task/models/charityModel.dart';
import 'package:company_task/wedgit/FriebaseErrorDailog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
          return DailogError(titleText: "Id error",text: "this Id aulreadr exist",);
        });
  }
  void missingData(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DailogError(titleText: "Missing data",text: "Please enter important data",);
        });
  }
  void passwordNotMatch(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return DailogError(titleText: "Pasword Not match",text: "Please be in sure write the same password",);
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

















  final MedicenTextController = BehaviorSubject<String>();
  final ClothTextController = BehaviorSubject<String>();
  final FurnitureTextController = BehaviorSubject<String>();
  final demond = BehaviorSubject<String>();
  final donate = BehaviorSubject<String>();
  Stream<String> get MedicineTextStream => MedicenTextController.stream;
  Stream<String> get ClothTextStream => ClothTextController.stream;
  Stream<String> get furnitureTextStream => FurnitureTextController.stream;
  Stream<String> get demondStream => demond.stream;
  Stream<String> get donateStream => donate.stream;

  Function(String) get demondChange => demond.sink.add;
  Function(String) get donateChange => donate.sink.add;
  Function(String) get MedicineTextChange => MedicenTextController.sink.add;
  Function(String) get ClothTextChange => ClothTextController.sink.add;
  Function(String) get furnitureTextChange => FurnitureTextController.sink.add;

  updateMedicineText(String text) {
         MedicenTextController.sink.add(text);
  }
  updateClothText(String text) {
    ClothTextController.sink.add(text);
  }
  updateFurnitureText(String text) {
    FurnitureTextController.sink.add(text);
  }
  updateDemond(String text) {
         demond.sink.add(text);
  }updateDonate(String text) {
         donate.sink.add(text);
  }
  final _medicineListSearch = PublishSubject<List<MedicineModel>>();
  Observable<List<MedicineModel>> get streamMedicinesearch => _medicineListSearch.stream;
  MedicineRepostrySearch _medicineRepostrySearch = MedicineRepostrySearch();


  MedicineSearch()async{

List<MedicineModel> _medicenmodelsearch = await _medicineRepostrySearch.getMedicineSearch(MedicenTextController.value);

  return _medicineListSearch.sink.add(_medicenmodelsearch);


  }


  MedicineRepostry _medicineRepostry = MedicineRepostry();

  final _medicineList = PublishSubject<List<MedicineModel>>();
  Observable<List<MedicineModel>> get streamMedicine => _medicineList.stream;

  fetchMedicine() async{
    List<MedicineModel> _medicineModel = await _medicineRepostry.getMedicine();
   return _medicineList.sink.add(_medicineModel);
  }




  MedicineRepostryFinish _medivcineRepostryFinish = MedicineRepostryFinish();

  final _MedicineListFinish = PublishSubject<List<MedicineModel>>();
  Observable<List<MedicineModel>> get streamMedicineFinish => _MedicineListFinish.stream;

  fetchMedicineFinish() async{
    List<MedicineModel> _medicineModelfinish = await _medivcineRepostryFinish.getMedicineFinish();
    return _MedicineListFinish.sink.add(_medicineModelfinish);
  }





  MedicineRepostoryProfile _medivcineRepostryProfile = MedicineRepostoryProfile();

  final _MedicineListProfile = PublishSubject<List<MedicineModel>>();
  Observable<List<MedicineModel>> get streamMedicineProfile => _MedicineListProfile.stream;

 Future fetchMedicineProfileData(BuildContext context) async{
    List<MedicineModel> _medicineModelProfile = await _medivcineRepostryProfile.getMedicineProfile(context);
    return _MedicineListProfile.sink.add(_medicineModelProfile);
  }

  /////// Cloth ///
  final _clothListSearch = PublishSubject<List<ClothModel>>();
  Observable<List<ClothModel>> get streamClothsearch => _clothListSearch.stream;
  ClothRepostrySearch _clothRepostrySearch = ClothRepostrySearch();


  ClothSearch()async{

    List<ClothModel> _clothmodelsearch = await _clothRepostrySearch.getClothSearch(ClothTextController.value);

    return _clothListSearch.sink.add(_clothmodelsearch);


  }


  ClothRepostry _clothRepostry = ClothRepostry();

  final _clothList = PublishSubject<List<ClothModel>>();
  Observable<List<ClothModel>> get streamCloth => _clothList.stream;

  fetchCloth() async{
    List<ClothModel> _clothModel = await _clothRepostry.getCloth();
    return _clothList.sink.add(_clothModel);
  }

  ClothRepostryFinish _clothRepostryFinish = ClothRepostryFinish();

  final _clothListFinish = PublishSubject<List<ClothModel>>();
  Observable<List<ClothModel>> get streamClothFinish => _clothListFinish.stream;

  fetchClothFinish() async{
    List<ClothModel> _clothModelfinish = await _clothRepostryFinish.getCloth();
    return _clothListFinish.sink.add(_clothModelfinish);
  }




  ClothRepostoryProfile _clothRepostryProfile = ClothRepostoryProfile();

  final _clothListProfile = PublishSubject<List<ClothModel>>();
  Observable<List<ClothModel>> get streamClothProfile => _clothListProfile.stream;

  Future fetchClothProfileData(BuildContext context) async{
    List<ClothModel> _ClothModelProfile = await _clothRepostryProfile.getClothProfile(context);
    return _clothListProfile.sink.add(_ClothModelProfile);
  }
  ////// Cloth Finish////



  final _furnitureListSearch = PublishSubject<List<FurnitureModel>>();
  Observable<List<FurnitureModel>> get streamFurnituresearch => _furnitureListSearch.stream;
  FurnitureRepostrySearch _furnitureRepostrySearch = FurnitureRepostrySearch();


  FurnitureSearch()async{

    List<FurnitureModel> _furnituremodelsearch = await _furnitureRepostrySearch.getFurnitureSearch(FurnitureTextController.value);

    return _furnitureListSearch.sink.add(_furnituremodelsearch);


  }


  FurnitureRepostry _furnitureRepostry = FurnitureRepostry();

  final _furnitureList = PublishSubject<List<FurnitureModel>>();
  Observable<List<FurnitureModel>> get streamFurniture => _furnitureList.stream;
  fetchFurniture() async{
    List<FurnitureModel> _furnitureModel = await _furnitureRepostry.getFurniture();
    return _furnitureList.sink.add(_furnitureModel);
  }

  FurnitureRepostryFinish _furnitureRepostryFinish = FurnitureRepostryFinish();

  final _furnitureListFinish = PublishSubject<List<FurnitureModel>>();
  Observable<List<FurnitureModel>> get streamFurnitureFinish => _furnitureListFinish.stream;

  fetchFurnitureFinish() async{
    List<FurnitureModel> _furnitureModelfinish = await _furnitureRepostryFinish.getFurnitureFinish();
    return _furnitureListFinish.sink.add(_furnitureModelfinish);
  }



  FurnitureRepostoryProfile _furnitureRepostryProfile = FurnitureRepostoryProfile();

  final _furnitureListProfile = PublishSubject<List<FurnitureModel>>();
  Observable<List<FurnitureModel>> get streamFurnitureProfile => _furnitureListProfile.stream;

  Future  fetchFurnitureProfileData(BuildContext context) async{
    List<FurnitureModel> _furnitureModelProfile = await _furnitureRepostryProfile.getFurnitureProfile(context);
    return _furnitureListProfile.sink.add(_furnitureModelProfile);
  }


/////////////////////////////////////////////////////////



  BloodRepostry _bloodRepostry = BloodRepostry();
  final _bloodNeedyList = PublishSubject<List<BloodNeedyModel>>();
  Observable<List<BloodNeedyModel>> get streamNeedy => _bloodNeedyList.stream;

  fetchBloodNeedy() async{
    List<BloodNeedyModel> _bloodModel = await _bloodRepostry.getNeedy();
    return _bloodNeedyList.sink.add(_bloodModel);
  }


//////////////////////////////////////////////////////////

//
//  UserRopestryLogin _userRopestryLogin = UserRopestryLogin();
//  final _userList = PublishSubject<List<User>>();
//  Observable<List<User>> get streamUser => _userList.stream;
//
//  fetchUser(BuildContext context) async{
//    List<User> _userModel = await _userRopestryLogin.getUserData( context);
//    print("hjhjhjhjhjhjhjhjhjhhjhjh");
//    return _userList.sink.add(_userModel);
//
//
//  }


  Future<List> getNewsOnSearchBar(BuildContext context) async {
    var prov =Provider.of<InfoProvider>(context);
    final String _collection = 'Users';
    final Firestore _fireStore = Firestore.instance;

    print("1");

    Future<QuerySnapshot> getData() async {
      print("2");
      print('ffffffffffffffffffff:${Provider.of<InfoProvider>(context).UserLoginId}');

      return await _fireStore.collection(_collection).where('userId',isEqualTo: "${Provider.of<InfoProvider>(context).UserLoginId}").getDocuments();
    }

    QuerySnapshot val = await getData();
    if (val.documents.length > 0) {
      print("3");
      for (int i = 0; i < val.documents.length; i++) {
        prov.newsListUser.insert(0,val.documents[0].data["email"]);
        prov.newsListUser.insert(1,val.documents[0].data["gander"]);
        prov.newsListUser.insert(2,val.documents[0].data["id"]);
        prov.newsListUser.insert(3,val.documents[0].data["image"]);
        prov.newsListUser.insert(4,val.documents[0].data["jop"]);
        prov.newsListUser.insert(5,val.documents[0].data["location"]);
        prov.newsListUser.insert(6,val.documents[0].data["maritalstate"]);
        prov.newsListUser.insert(7,val.documents[0].data["name"]);
        prov.newsListUser.insert(8,val.documents[0].data["password"]);
        prov.newsListUser.insert(9,val.documents[0].data["phone"]);
        prov.newsListUser.insert(10,val.documents[0].data["userId"]);
      }
  
    } else {
      print("Not Found");
    }
    print("4");
    SharedPreferences sharedPreferencesGetUserEmail =
    await SharedPreferences.getInstance();
    sharedPreferencesGetUserEmail.setString(Common.email, prov.newsListUser[0]);


    SharedPreferences sharedPreferencesGetUserGander =
    await SharedPreferences.getInstance();
    sharedPreferencesGetUserGander.setString(Common.gander, prov.newsListUser[1]);


    SharedPreferences sharedPreferencesGetUserNationalId =
    await SharedPreferences.getInstance();
    sharedPreferencesGetUserNationalId.setString(Common.nationalId, prov.newsListUser[2]);


    SharedPreferences sharedPreferencesGetUserImage =
    await SharedPreferences.getInstance();
    sharedPreferencesGetUserImage.setString(Common.image, prov.newsListUser[3]);


    SharedPreferences sharedPreferencesGetUserJop =
    await SharedPreferences.getInstance();
    sharedPreferencesGetUserJop.setString(Common.jop, prov.newsListUser[4]);


    SharedPreferences sharedPreferencesGetUserLocation =
    await SharedPreferences.getInstance();
    sharedPreferencesGetUserLocation.setString(Common.location, prov.newsListUser[5]);


    SharedPreferences sharedPreferencesGetUserState =
    await SharedPreferences.getInstance();
    sharedPreferencesGetUserState.setString(Common.state, prov.newsListUser[6]);


    SharedPreferences sharedPreferencesGetUserName =
    await SharedPreferences.getInstance();
    sharedPreferencesGetUserName.setString(Common.name, prov.newsListUser[7]);


    SharedPreferences sharedPreferencesGetUserPassword =
    await SharedPreferences.getInstance();
    sharedPreferencesGetUserPassword.setString(Common.password,prov.newsListUser[8]);


    SharedPreferences sharedPreferencesGetUserPhone =
    await SharedPreferences.getInstance();
    sharedPreferencesGetUserPhone.setString(Common.phone, prov.newsListUser[9]);

    SharedPreferences sharedPreferencesGetUserId =
    await SharedPreferences.getInstance();
    sharedPreferencesGetUserId.setString(Common.userId, prov.newsListUser[10]);

    print('userId:${prov.newsListUser[0]}');
    print('userId:${prov.newsListUser[5]}');
    print('userId:${prov.newsListUser[9]}');
    print('userId:${prov.newsListUser[10]}');
    return prov.newsListUser;
  }


//////////////////////////// profilee ////////////////////////
  String imageUrlProfile;
  String nameProfile;
  String passwordProfile;
  String nationalIdProfile;
  String jopProfile;
  String phoneProfile;
  String ganderProfile;
  String emailProfile;
  String stateProfile;
  String locationProfile;

  fetch()async{

    imageUrlProfile = await Common.getUserImageToken();
emailProfile = await Common.getUserEmailToken();
    passwordProfile = await Common.getUserPasswordToken();
    phoneProfile = await Common.getUserPhoneToken();
 jopProfile = await Common.getUserJopToken();
  ganderProfile = await Common.getUserGanderToken();
    nationalIdProfile= await Common.getUserNationalIdToken();
    stateProfile = await Common.getUserStateToken();
    locationProfile = await Common.getUserLocationToken();

    print(imageUrlProfile);
  }

//////////////////////////////////// Chat /////////////////////////////
  BehaviorSubject<bool> uploadingSubject = BehaviorSubject();
  Observable<bool> get isUploading => uploadingSubject.stream;

  Future<String> uploadApk(file) async {
    uploadingSubject.sink.add(true);
    StorageReference storageRef = FirebaseStorage.instance
        .ref()
        .child('apks/' + basename(file.path));
    final StorageUploadTask uploadTask = storageRef.putFile(
      file,
    );
    StorageTaskSnapshot snap = await uploadTask.onComplete;
    String url = await snap.ref.getDownloadURL();
    uploadingSubject.sink.add(false);
    return url;
  }


  /////////////////////////////////////////////////////////////

  void dispose() async {
    await uploadingSubject.drain();
    uploadingSubject.close();
//    _userList.close();
    await _evntList.drain();
    _evntList.close();

    await _topList.drain();
    _evntList.close();

    _MedicineListProfile.close();
    await _chairtyList.drain();
    _chairtyList.close();


    await _medicineList.drain();
    _medicineList.close();
    MedicenTextController.close();
    _medicineListSearch.close();
    demond.close();
    donate.close();
//    _clothListSearch.close();
    _clothListProfile.close();
    _clothList.close();
    _bloodNeedyList.close();
    _clothListFinish.close();
    _MedicineListFinish.close();
    _clothListSearch.close();
    _furnitureListSearch.close();
    _furnitureList.close();
    _furnitureListFinish.close();
  }



}
