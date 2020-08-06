

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/models/User.dart';
import 'package:company_task/provider/SignUpLoginProvider/LoginProvider.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class UserServiceLogin{

  Future<List<User>> getUserData( BuildContext context) async {
    final QuerySnapshot querySnapshot =
    await Firestore.instance.collection("Users")
        .where("userId",isEqualTo: "${Provider.of<InfoProvider>(context).UserLoginId}")
        .getDocuments();


    print('    ${Provider.of<InfoProvider>(context).UserLoginId}');

    if (querySnapshot.documents.length == 0) {

      return null;
    } else {
      List<User> userModelLogin = [];
      for( var snapshot in querySnapshot.documents){
        userModelLogin.add(User.fromJison(snapshot));
      }

      print('ffffffffffffffffffffffffffffffffffffffffffffffff');
      print('ffffffffffffffffffffffffffffffffffffffffffffffff');
      return userModelLogin;
    }
  }








}
