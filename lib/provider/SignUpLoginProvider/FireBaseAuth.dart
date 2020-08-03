


import 'package:company_task/service/LoginService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthNotifier extends ChangeNotifier{


  FirebaseUser _user;


  FirebaseUser get user => _user;


  void setUser(FirebaseUser user){
    _user =user;
    notifyListeners();
  }



}