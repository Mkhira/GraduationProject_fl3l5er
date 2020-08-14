import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/Block/Validator.dart';
import 'package:company_task/Screens/homePage.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/models/User.dart';
import 'package:company_task/provider/SignUpLoginProvider/FireBaseAuth.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/service/LoginService.dart';
import 'package:company_task/wedgit/ChosseImage.dart';
import 'package:company_task/wedgit/FriebaseErrorDailog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

class SignUpProvider extends ChangeNotifier {
  Validator validator = Validator();

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

  final _email = BehaviorSubject<String>();
  Stream<String> get emailStream =>
      _email.stream.transform(validator.validateEmail);
  Function(String) get emailChange => _email.sink.add;

  final _password = BehaviorSubject<String>();
  Stream<String> get passwordStream =>
      _password.stream.transform(validator.validatePassword);
  Function(String) get passwordChange => _password.sink.add;
  File imageFile;


  final phone = BehaviorSubject<String>();

  Stream<String> get phoneStream => phone.stream.transform(validator.phone);

  Function(String) get phoneChange => phone.sink.add;


  final nID = BehaviorSubject<String>();

  Stream<String> get nIDStream => nID.stream.transform(validator.nID);

  Function(String) get nIDChange => nID.sink.add;

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
  signUpRecord(BuildContext context) async {}
  catchError(signUpError, BuildContext context) {
    if (signUpError is PlatformException) {
      if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        /// `foo@bar.com` has alread been registered.
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DailogError(
                text: "هذا الأميل مستخدم من قبل ",
                titleText: "هنالك خطأ فى البيانات",
              );
            });
      }
    }
  }
  final CollectionReference collectionReference =
      Firestore.instance.collection('Users');

  String urx;


    uploodImage(BuildContext context)async{
      if (imageFile != null) {
        StorageReference _storageReference = FirebaseStorage.instance
            .ref()
            .child("Profile/${p.basename(imageFile.path)}");
        StorageUploadTask storageUploadTask =
        _storageReference.putFile(imageFile);
        StorageTaskSnapshot snapshot = await storageUploadTask.onComplete;

        urx = await snapshot.ref.getDownloadURL();

      } else if (imageFile == null) {
        print(urx);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DailogErrorimage(
                text: "من فضلك إختر صوره",
                titleText: "هنالك خطأ فى البيانات",
              );
            });
      }
    }
  Future userDocment(BuildContext context) async {



    _user.imageUrl = urx;
    if (jopController.text.isNotEmpty || phoneController.text.isNotEmpty || addressController.text.isNotEmpty || fatherNameController.text.isNotEmpty ||
        firstNameController.text.isNotEmpty || lastNameController.text.isNotEmpty || idController.text.isNotEmpty && phone.value.length ==11 && nID.value.length ==14 && urx != null) {
    _user.email = emailController.text;
    _user.password = passwordController.text;
    _user.gander = gander;
    _user.location = addressController.text;
    _user.phone = phoneController.text;
    _user.jop = jopController.text;
    _user.maritalState = state;
    _user.nationalId = idController.text;

    _user.name =
        '${firstNameController.text + " " + fatherNameController.text + " " + lastNameController.text}';

    AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: _user.email,
          password: _user.password,
        )
        .catchError((signUpError) => showDialog(
            context: context,
            builder: (BuildContext context) {
              return DailogError(
                text: "${signUpError.code}",
                titleText: "هنالك خطأ فى البيانات",
              );
            }));

    if (authResult != null) {
      UserUpdateInfo updateInfo = UserUpdateInfo();

      updateInfo.displayName = _user.name;
      updateInfo.photoUrl = _user.imageUrl;
      FirebaseAuth.instance.currentUser().then((user) async {

        _user.id = user.uid;

        SharedPreferences sharedPreferencesGetUserId =
            await SharedPreferences.getInstance();
        sharedPreferencesGetUserId.setString(Common.userId, user.uid);
        print(await Common.getUserIdToken());
        print(await Common.getUserIdToken());
        print("user ------------------------------id");
        print(await Common.getUserIdToken());


        await collectionReference
            .document(_user.id)
            .setData({
          'id': idController.text.toString(),
          'name':
          "${firstNameController.text + " " + fatherNameController.text + " " + lastNameController.text}",
          'email': emailController.text,
          'image': urx,
          'location': addressController.text,
          'phone': phoneController.text.toString(),
          'maritalstate': state,
          'gander': gander,
          'password': passwordController.text,
          'jop': jopController.text,
          'userId': _user.id
        })
            .catchError((onError) => showDialog(
            context: context,
            builder: (BuildContext context) {
              return DailogError(
                text: "تأكد من أنك قد ادخلت جميع البيانات",
                titleText: "هنالك خطأ فى البيانات",
              );
            }))
            .whenComplete(() async {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return HomePage();
          }));});
        print(collectionReference.id);
      });

      String Token = await Common.userId;
      print('Token : $Token');
    }


    SharedPreferences sharedPreferencesGetUserEmail =
        await SharedPreferences.getInstance();
    sharedPreferencesGetUserEmail.setString(Common.email, _user.email);

    SharedPreferences sharedPreferencesGetUserGander =
        await SharedPreferences.getInstance();
    sharedPreferencesGetUserGander.setString(Common.gander, _user.gander);

    SharedPreferences sharedPreferencesGetUserNationalId =
        await SharedPreferences.getInstance();
    sharedPreferencesGetUserNationalId.setString(
        Common.nationalId, _user.nationalId);

    SharedPreferences sharedPreferencesGetUserImage =
        await SharedPreferences.getInstance();
    sharedPreferencesGetUserImage.setString(Common.image, _user.imageUrl);

    SharedPreferences sharedPreferencesGetUserJop =
        await SharedPreferences.getInstance();
    sharedPreferencesGetUserJop.setString(Common.jop, _user.jop);

    SharedPreferences sharedPreferencesGetUserLocation =
        await SharedPreferences.getInstance();
    sharedPreferencesGetUserLocation.setString(Common.location, _user.location);

    SharedPreferences sharedPreferencesGetUserState =
        await SharedPreferences.getInstance();
    sharedPreferencesGetUserState.setString(Common.state, _user.maritalState);

    SharedPreferences sharedPreferencesGetUserName =
        await SharedPreferences.getInstance();
    sharedPreferencesGetUserName.setString(Common.name, _user.name);

    SharedPreferences sharedPreferencesGetUserPassword =
        await SharedPreferences.getInstance();
    sharedPreferencesGetUserPassword.setString(Common.userId, _user.password);

    SharedPreferences sharedPreferencesGetUserPhone =
        await SharedPreferences.getInstance();
    sharedPreferencesGetUserPhone.setString(Common.phone, _user.phone);


    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DailogError(
              text: "من فضلك تأكد من جميع البيانات",
              titleText: "هنالك خطأ فى البيانات",
            );
          });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    phone.close();
    _email.close();
    _password.close();
    super.dispose();
  }
}
