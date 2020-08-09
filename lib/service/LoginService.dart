

import 'package:company_task/Screens/homePage.dart';
import 'package:company_task/Screens/splashScreen.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/models/User.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:company_task/wedgit/ButtonWidget.dart';
import 'file:///E:/flater_projects/company_task/lib/provider/SignUpLoginProvider/FireBaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';



  login(String email,String password, AuthNotifier authNotifier ,BuildContext context)async{

  AuthResult authResult =  await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).
    catchError((error)=> print(error.code));


   if(authResult != null){
     FirebaseUser firebaseUser = authResult.user;

     if(FirebaseUser != null){
       Provider.of<InfoProvider>(context).UserLoginId = firebaseUser.uid;
       print('Login : ${Provider.of<InfoProvider>(context).UserLoginId}');
       SharedPreferences sharedPreferencesGetUserId =
       await SharedPreferences.getInstance();
       sharedPreferencesGetUserId.setString(Common.userId, firebaseUser.uid);
//       print('Login : ${firebaseUser.uid}');
//       print('Login : ${firebaseUser.uid}');
//       print('Login : ${firebaseUser.uid}');
           authNotifier.setUser(firebaseUser);



           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
             return SplashScreen();
           }));
     }
   }
  }

//  signUp(User user, BuildContext context)async{
//
//
//
//  }



  signOut(AuthNotifier authNotifier)async{
    await FirebaseAuth.instance.signOut().catchError((error)=> print(error.code));
    authNotifier.setUser(null);
  }


User _user =User();
  initializeCurrentUser(AuthNotifier authNotifier,BuildContext context)async{

    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    Provider.of<InfoProvider>(context).UserLoginId = firebaseUser.uid;
    print('Login : ${Provider.of<InfoProvider>(context).UserLoginId}');

    if(firebaseUser != null){
      print(firebaseUser.photoUrl);
      authNotifier.setUser(firebaseUser);

               FirebaseAuth.instance.currentUser().then((user) async{
                 SharedPreferences sharedPreferencesGetUserId =
                     await SharedPreferences.getInstance();
                 sharedPreferencesGetUserId.setString(Common.userId, firebaseUser.uid);
          _user.id  = user.uid;
          print(_user.id);
         });

    }

  }

//  User _user =User();
//submitSignUp(BuildContext context){
//
//    AuthNotifier not = Provider.of<AuthNotifier>(context,listen: false);
//    signUp(_user, not);
//

//}