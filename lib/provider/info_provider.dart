import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'package:company_task/Screens/ItemsContent.dart';
import 'package:company_task/Screens/MedicinePosts.dart';
import 'package:flutter/foundation.dart';
import 'package:company_task/models/eventModel.dart';
import 'package:company_task/models/medicenModel.dart';
import 'package:company_task/models/registerModel.dart';
import 'package:company_task/service/repostry.dart';
import 'package:rxdart/rxdart.dart';
import '../models/carouseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Screens/BlodDonation.dart';
import '../models/BloodNeedyModel.dart';
import '../Block/Block.dart';
import '../Screens/secondRigister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class InfoProvider extends ChangeNotifier {
  static TextEditingController _emial = TextEditingController();
  static TextEditingController _fristName = TextEditingController();
  static TextEditingController _lastName = TextEditingController();
  static TextEditingController _nickName = TextEditingController();
  static TextEditingController _password = TextEditingController();
  static TextEditingController _confirmPassword = TextEditingController();
  static TextEditingController _numKids = TextEditingController();
  static TextEditingController _jop = TextEditingController();
  static TextEditingController _salary = TextEditingController();
  static TextEditingController _cardId = TextEditingController();
  static TextEditingController _phone = TextEditingController();
  static TextEditingController _country = TextEditingController();
  static TextEditingController _governate = TextEditingController();
  static TextEditingController _city = TextEditingController();
  static TextEditingController _street = TextEditingController();

  static GlobalKey<FormState> _emailForm;
  static GlobalKey<FormState> _passwordForm;
  static GlobalKey<FormState> _maretalForm = new GlobalKey<FormState>();
  static GlobalKey<FormState> _jopForm = new GlobalKey<FormState>();
  static GlobalKey<FormState> _personalForm = new GlobalKey<FormState>();
  static GlobalKey<FormState> _locationForm = new GlobalKey<FormState>();

  final bloc = Bloc();
  int slectMaritalStatus = 0;

  List<String> stat = ["maried", "single", "devorce"];
  List<String> joplist = ["work", "jopless", ""];
  List<String> ganderlist = [
    "male",
    "female",
  ];
  int get selcetedStatus {
    return slectMaritalStatus;
  }

  void selectedMaritalStatus(int val) {
    slectMaritalStatus = val;
    notifyListeners();
  }

  stateReturn() {
    if (slectMaritalStatus != 0) {
      return stat[slectMaritalStatus - 1];
    } else
      return "";
  }

  genderReturn() {
    if (slectGender != 2) {
      return ganderlist[slectGender - 6];
    } else {
      return "";
    }
  }

  jopReturn() {
    if (slectJop != 1) {
      return joplist[slectJop - 4];
    } else {
      return "";
    }
  }

  int slectJop = 1;
  int get selcetedJop {
    return slectJop;
  }

  void selectedJop(int vale) {
    slectJop = vale;
    notifyListeners();
  }

  int slectGender = 2;
  int get selcetedGender {
    return slectGender;
  }

  void selectedGender(int value) {
    slectGender = value;

    notifyListeners();
  }
/////////// time //////////////////////////////////

  DateTime _dateTime;
  TextEditingController _date = TextEditingController();

  String get datee {
    return _dateTime.toIso8601String();
  }

  TextEditingController get date {
    return _date;
  }

  ///////////////////////////////////////

  List<carousModel> _test = [
    carousModel(
        image: "assets/me.jpg",
        head: "Every one could be hero",
        time: "Cairo, 16 Marc 2020"),
    carousModel(
        image: "assets/me.jpg",
        head: "Earth blod donation ",
        time: "Alex,20 Marc 2020"),
    carousModel(
        image: "assets/me.jpg",
        head: "Canser Helper",
        time: "Cairo, 1 April 2020"),
    carousModel(
        image: "assets/me.jpg",
        head: "Childern Donation",
        time: "Mansoura, 12 Marc 2020"),
  ];

  UnmodifiableListView<carousModel> get test {
    return UnmodifiableListView(_test);
  }

  int get testCount {
    return test.length;
  }

  FutureOr<dynamic> login(BuildContext context) async {
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => BloodDonation()));
  }

  void rgister(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => secondRegister()));
  }
  void item(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => MedicinePosts()));
  }





  /////////// DarkMod /////

//////////////////// Create DataBase ///////////////////////

//  String email;
//  String firstName;
//  String lastName;
//  String nickName;
//  String password;
//  int cardId;
//  String gender;
//  String jop;
//  double salary;
//  String maritalStatus;
//  int kidsNum;
//  String address;
//  DateTime date;
//  int phone;

  List<RegisterModel> listRigester;

  int get rigester {
    return listRigester.length;
  }

//////////////////////////////////////// validation///

  static emaiValidation(val) {
    if (val != null &&
        val.toString().contains("@") &&
        val.toString().contains(".com")) {
      return null;
    }
    if (val.toString() == null) {
      return "Email Shuld nit be empity";
    }
    if (val.toString().contains("@") != true ||
        val.toString().contains(".com") != true) {
      return "Missing @ or .com";
    }
  }

////////Submit//

  void Testvalidate(BuildContext context) {
    if (_emailForm.currentState.validate()) {}
  }

///////////////////////////////////////////////////////// home bage ///////////////////////

GlobalKey actionKey = LabeledGlobalKey("x");
bool isDropdownOpened = false;
double height ,width ,xPosition,yPosition;


  OverlayEntry floatingDropdown ;

  changeDropdownOpenedState(){
    isDropdownOpened =! isDropdownOpened;
    notifyListeners();

  }
  void findDropdownData(){
     RenderBox renderBox = actionKey.currentContext.findRenderObject();
     height = renderBox.size.height;
     width =renderBox.size.width;
     Offset offset = renderBox.localToGlobal(Offset.zero);
     xPosition = offset.dx;
     yPosition = offset.dy;
    print(height);
    print(width);
    print(xPosition);
    print(yPosition);


  }





  OverlayEntry createFloatingDropdown(){

    return OverlayEntry(builder: (context){
      return Positioned(
        left: xPosition,
        width:8* width +40,
        top: yPosition + height-2,
      height: 2* height +80,


        child: SearchDropdownMenu(
          itemHeight: height,

        ),
      );
    });

  }


//profile,edit,medicine post work/////////////////////////////////////////////////////

  String name = 'Ahmed Sakr',
      jop = 'Student',
      location = 'Cairo , Egypt',
      bio =
          'Hello I am a Student of Menofia University.I joined this community to help others in need.',
      email = 'medosakr506@gmail.com',
      phone = '01013709514',
      id = '1311974542';

  String _day='1',_updatedDay='13',_month='January',_updatedMonth='November',_year='2020',_updatedYear='1997';

  //updating day
  String get day{
    return _day;
  }
  String get updatedDay{
    return _updatedDay;
  }

  set modifyDay(String newDay){
    _day=newDay;
    notifyListeners();
  }
  set modifyUpdatedDay(String newDay){
    _updatedDay=newDay;
    notifyListeners();
  }

  //updating month
  String get month{
    return _month;
  }
  String get updatedMonth{
    return _updatedMonth;
  }

  set modifyMonth(String newMonth){
    _month=newMonth;
    notifyListeners();
  }
  set modifyUpdatedMonth(String newMonth){
    _updatedMonth=newMonth;
    notifyListeners();
  }

  //updating year
  String get year{
    return _year;
  }
  String get updatedYear{
    return _updatedYear;
  }

  set modifyYear(String newYear){
    _year=newYear;
    notifyListeners();
  }

  set modifyUpdatedYear(String newYear){
    _updatedYear=newYear;
    notifyListeners();
  }


  String _selectedGender='Male',_selectedStatus='Single',_updatedGender='Male',_updatedStatus='Single';

  //updating status
  String get status{
    return _selectedStatus;
  }

  String get updatedStatus{
    return _updatedStatus;
  }

  set modifyStatus(String newStatus){
    _selectedStatus=newStatus;
    notifyListeners();
  }
  set modifyUpdatedStatus(String newStatus){
    _updatedStatus=newStatus;
    notifyListeners();
  }

  //updating gender
  String get gender{
    return _selectedGender;
  }

  String get updatedGender{
    return _updatedGender;
  }

  set modifyGender(String newGender){
    _selectedGender=newGender;
    notifyListeners();
  }

  set modifyUpdatedGender(String newGender){
    _updatedGender=newGender;
    notifyListeners();
  }


  //update image
  File _pickedImage,_updatedImage;

  File get pickedImage{
    return _pickedImage;
  }

  File get updatedImage{
    return _updatedImage;
  }

  set modifyImage(File newImage) {
    _pickedImage = newImage;
    notifyListeners();
  }

  set modifyUpdatedImage(File newImage){
    _updatedImage=newImage;
    notifyListeners();
  }


  void updateInfo({
    String newName,
    String newJop,
    String newLocation,
    String newBio,
    String newEmail,
    String newID,
    String newPhone,
  }) {
    name = newName;
    jop = newJop;
    location = newLocation;
    bio = newBio;
    email = newEmail;
    phone = newPhone;
    id = newID;
    notifyListeners();
  }

  //MedicinePost screen:

  //todo get this informations from firebase
  String _medicineImage='assets/medicinePhoto.jfif',_medicineName='Antibiotic',
  _uses='Dexlansoprazole is used to treat certain stomach and esophagus problems (such as acid reflux).';
  int _medicineAmount=14,_medicineAppliers=30,_acceptedPeople=10,_daysLeft=15,_expireDay=7,_expireMonth=6,_expireYear=2020;

  String get medicineImage{
    return _medicineImage;
  }

  int get medicineAmount{
    return _medicineAmount;
  }

  int get medicineAppliers{
    return _medicineAppliers;
  }

  int get acceptedPeople{
    return _acceptedPeople;
  }

  int get daysLeft{
    return _daysLeft;
  }

  String get medicineName{
    return _medicineName;
  }

  String get uses{
    return _uses;
  }

  int get expireDay{
    return _expireDay;
  }

  int get expireMonth{
    return _expireMonth;
  }

  int get expireYear{
    return _expireYear;
  }




///////////////////////////////////////////////
  itemContent(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => ItemContent()));
  }


  Blood(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => BloodDonation()));
  }

bool medicineClick = true;

  choseMedicine(){
    medicineClick = true;
    notifyListeners();
  }

}

////////////////////////////////////////////////
