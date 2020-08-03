




import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/models/User.dart';
import 'package:company_task/provider/SignUpLoginProvider/FireBaseAuth.dart';
import 'package:company_task/service/LoginService.dart';
import 'package:company_task/wedgit/ChosseImage.dart';
import 'package:company_task/wedgit/FriebaseErrorDailog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as p;

class SignUpProvider extends ChangeNotifier{











  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final firstNameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final idController = TextEditingController();
   String state = 'متزوج';
   String gander = 'ذكر';
  final jopController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();









  File imageFile;

  Future<void> openGallary(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);

    imageFile = picture;
    print(imageFile);
    print(picture);
    notifyListeners();
  }

  Future<void> openCamera(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    imageFile = picture;
    print(imageFile.toString());
    notifyListeners();
  }

  onChoseImage(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return OnChoseImageSignUp();
        });
  }







  final databaseReference = Firestore.instance;

  User _user = User();


 signUpRecord(BuildContext context) async {












    String urx;
    if (imageFile != null) {
      StorageReference _storageReference =
      FirebaseStorage.instance.ref().child(
          "Profile/${p.basename(imageFile.path)}");
      StorageUploadTask storageUploadTask = _storageReference.putFile(
          imageFile);
      StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;

      urx = await snapshot.ref.getDownloadURL();

      _user.email = emailController.text;
      _user.password = passwordController.text;
      _user.imageUrl =urx;
      _user.gander= gander;
      _user.location = addressController.text;
      _user.phone= phoneController.text;
      _user.jop = phoneController.text;
      _user.maritalState =state;
      _user.nationalId = idController.text;

    } else if (imageFile == null) {
      print(imageFile.path);
      print(urx);
      showDialog(context: context,
          builder: (BuildContext context) {
            return DailogError(
              text: "من فضلك إختر صوره", titleText: "هنالك خطأ فى البيانات",);
          });
    }
    if (emailController.text !=null ||fatherNameController.text !=null ||passwordController.text !=null ||firstNameController.text !=null ||lastNameController.text !=null ||
        jopController.text !=null ||addressController.text !=null  ||urx !=null || idController.text !=null) {
      DocumentReference ref = await databaseReference.collection("Users")
          .add({
        'id': int.parse(idController.text.toString()),
        'name': "${firstNameController.text + " " + fatherNameController.text + " " + lastNameController.text}",
        'email': emailController.text,
        'image': urx,
        'location': addressController.text,
        'phone': int.parse(phoneController.text.toString()),
        'maritalstate': state,
        'gander': gander,
        'password': passwordController.text,
        'jop': jopController.text,


      }).whenComplete(signUp(_user,context));
//
      print(ref.documentID);
    }else{
      print("gggggggggggggggggggggggg");
    }
    print(emailController.text);
    print(firstNameController.text);
    print(fatherNameController.text);
    print(lastNameController.text);
    print(passwordController.text);
    print(passwordConfirmController.text);
    print(addressController.text);
    print(jopController.text);
    print(gander);
    print(phoneController.text);
    print(    _user.email = emailController.text);
    print(_user.password = passwordController.text);



  }








  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}