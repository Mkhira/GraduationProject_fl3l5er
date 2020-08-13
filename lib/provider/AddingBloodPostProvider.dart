




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/wedgit/FriebaseErrorDailog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class BloodPostProvider extends ChangeNotifier{

  var location = Location();

  Future checkGps() async {
    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }

  final patientDescription = BehaviorSubject<String>();

  Stream<String> get patientDescriptionStream => patientDescription.stream;

  Function(String) get patientDescriptionChange => patientDescription.sink.add;





  final patientName = BehaviorSubject<String>();

  Stream<String> get patientStream => patientName.stream;

  Function(String) get patientChange => patientName.sink.add;



  final bloodBank = BehaviorSubject<String>();

  Stream<String> get bloodBankStream => bloodBank.stream;

  Function(String) get bloodBankChange => bloodBank.sink.add;




  final bloodNeededAmount = BehaviorSubject<String>();

  Stream<String> get bloodNeededAmountStream => bloodNeededAmount.stream;

  Function(String) get bloodNeededAmountChange => bloodNeededAmount.sink.add;



  final phone = BehaviorSubject<String>();

  Stream<String> get phoneStream => phone.stream;

  Function(String) get phoneChange => phone.sink.add;

  final patientAge = BehaviorSubject<String>();

  Stream<String> get patientAgeStream => patientAge.stream;

  Function(String) get patientAgeChange => patientAge.sink.add;


  final hospitalName = BehaviorSubject<String>();

  Stream<String> get hospitalNameStream => hospitalName.stream;

  Function(String) get hospitalNameChange => hospitalName.sink.add;


  List<String> ganderState = ['انثى',  "ذكر"];
  String selectGander = 'ذكر';


  choseGander(String newValue){

    selectGander = newValue;
    notifyListeners();
  }



  List<String> bloodType = ['A+','A-','B+','B-','AB+','AB-','O+','O-',];
  String selectedBloodType = 'A+';


  choseBloodType(String newValue){

    selectedBloodType = newValue;
    notifyListeners();
  }

  double chosenLat;
  double chosenLong;


  List<double> locationList=[];

  final databaseReference = Firestore.instance;
  void createBloodPost(BuildContext context) async {


    if(locationList.length == 0){
      locationList.insert(0, chosenLat);
      locationList.insert(1, chosenLong);
    }


    if(bloodNeededAmount.value != null && patientName.value != null &&  patientDescription.value != null && locationList[0] != null && locationList[1] != null
        && phone.value != null && hospitalName.value!=null ){
      DocumentReference ref = await databaseReference.collection("bloodNeedy").document();
      ref.setData({
        'neededAmount': int.parse(bloodNeededAmount.value.toString()),
        'descroption': patientDescription.value,
        'name': patientName.value,
        'postownername':Provider.of<InfoProvider>(context).nameProfile,
        'bloodBankId':bloodBank.value,
        'hospitalName':hospitalName.value,

        'location':  locationList,
        'phone':  phone.value,
        'userid': Provider.of<InfoProvider>(context).UserLoginId,
        "documentId": ref.documentID,
        "image": Provider.of<InfoProvider>(context).imageUrlProfile,
        "gander": selectGander,
        "blood": selectedBloodType,
        "age": int.parse(patientAge.value.toString()),
        "collectedAmount": 0,




      }).whenComplete(close(context));
      print(ref.documentID);}
    else if((locationList[0] == null || locationList[1] == null) ){
      showDialog(context: context ,
          builder: (BuildContext context) {
            return
              DailogError(text: "من فضلك إختر الموقع",titleText: "هنالك خطأ فى البيانات",);
          } );
    }
    else if(hospitalName.value == null || patientAge.value == null || phone.value == null || bloodNeededAmount.value ==null|| phone.value == null|| bloodBank.value == null || patientName.value == null || patientDescription.value ==null){
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
    print(int.parse(bloodNeededAmount.value.toString()));
    print(int.parse(phone.value.toString()));

  }





  close(BuildContext context){

    Navigator.pop(context);
    hospitalName.value =null;
    patientAge.value = null;
    bloodNeededAmount.value = null;
    locationList.clear();
    phone.value =null;
    bloodBank.value = null;
    patientName.value =null;
    patientDescription.value= null;
  }








  @override
  void dispose() {
    // TODO: implement dispose
    hospitalName.close();
    patientAge.close();
    bloodNeededAmount.close();
    bloodBank.close();
    patientName.close();
    patientDescription.close();
    super.dispose();
  }
}