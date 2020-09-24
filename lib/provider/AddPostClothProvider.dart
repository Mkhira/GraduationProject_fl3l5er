

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/Block/Validator.dart';
import 'package:company_task/provider/AddPostMedicineProvider.dart';
import 'package:company_task/provider/MapProvider.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/wedgit/ChosseImage.dart';
import 'package:company_task/wedgit/FriebaseErrorDailog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import '../Block/Block.dart';
import '../Screens/Cloth/ClothesPost.dart';
class AddPostClothProvider extends ChangeNotifier{

  bool value = false;
  Validator validator = Validator();

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

  Bloc _bloc = Bloc();

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
  TextEditingController phoneController = TextEditingController();
  TextEditingController dayController = TextEditingController();
  void createRecordCloth(BuildContext context) async {

    ProgressDialog pr = new ProgressDialog(context);
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: true);
    if(clothName.value != null && name.length == 0){

      for(int x = 0 ; x<= clothName.value.length ; x++){
        name.insert(x, clothName.value.substring(0,x));
      }
    }
    String urx;

    locationList.insert(0, Provider.of<MapProvider>(context).lat);
    locationList.insert(1, Provider.of<MapProvider>(context).lat);
    print(locationList[0]);
    print(locationList[1]);
    if(imageFileCloth != null) {
      pr.show();
      StorageReference _storageReference =
      FirebaseStorage.instance.ref().child(
          "Cloth/${p.basename(imageFileCloth.path)}");
      StorageUploadTask storageUploadTask = _storageReference.putFile(
          imageFileCloth);
      StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;
      urx = await snapshot.ref.getDownloadURL();
    }else if(imageFileCloth == null ){
      pr.hide();
      print(urx);
      showDialog(context: context ,
          builder: (BuildContext context) {
            return  DailogError(text: "من فضلك إختر صوره",titleText: "هنالك خطأ فى البيانات",); } );
    }
    if(clothAmount.value != null && clothName.value != null &&  urx != null && locationList[0] != null && locationList[1] != null && phone.value != null && name.length>=3 &&
        duration.value != null&& phoneController.text.length == 11 &&dayController.text.length ==1 && clothDescription.value != null){
      DocumentReference ref = await databaseReference.collection("Cloth").document();
          ref.setData({
        'amount': int.parse(clothAmount.value.toString()),
        'description': clothDescription.value,
        'name': clothName.value,
        'owner': (value == false) ?"مجهول" : Provider.of<InfoProvider>(context).nameProfile,
        'image':  urx,
        'location':  locationList,
        'phone':  int.parse(phone.value.toString()),
        'searchkey':name,
        'state': selectedsState,
       'clothstate': selectedsStateType,
        'dayleft': int.parse(duration.value.toString()),
        'userid': Provider.of<InfoProvider>(context).UserLoginId,
            "documentId":ref.documentID,
            "userImage": Provider.of<InfoProvider>(context).imageUrlProfile,
            "ownerName":Provider.of<InfoProvider>(context).nameProfile,



          }).then(done()).whenComplete((){
            pr.hide();
            _bloc.fetchCloth();
            _bloc.fetchClothFinish();

            Navigator.pop(context);

          });
      print(ref.documentID);}
     else if((locationList[0] == null || locationList[1] == null) && imageFileCloth != null && urx != null){
      pr.hide();
      showDialog(context: context ,
          builder: (BuildContext context) {
            return
              DailogError(text: "من فضلك إختر الموقع",titleText: "هنالك خطأ فى البيانات",);
          } );
    }
     else if(clothAmount.value == null || clothName.value == null || phone.value == null || name.length <3 || duration.value == null){
      pr.hide();
      showDialog(context: context ,
          builder: (BuildContext context) {
            return
              DailogError(text: "من فضلك تأكد من ادخال جميع البيانات ",titleText: "هنالك خطأ فى البيانات",);
          } );
    } else if(phoneController.text.length !=10 || dayController.text.length !=1){
      pr.hide();
      showDialog(context: context ,
          builder: (BuildContext context) {
            return
              customError(text: "من فضلك تأكد من الهاتف والمده ",titleText: "هنالك خطأ فى البيانات",
                onPressed: (){

                  Navigator.pop(context);
                },

              );
          }


      );

    }
    else {
      pr.hide();
      showDialog(context: context ,
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



    phoneController.text = null;
    dayController.text = null;
    clothAmount.value =null;
    clothDescription.value = null;
    clothName.value = null;
    locationList.clear();
    phone.value =null;
    name.clear();duration.value =null;
    imageFileCloth= null;
    notifyListeners();
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