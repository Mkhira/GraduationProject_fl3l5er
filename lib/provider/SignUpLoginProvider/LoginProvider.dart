



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_task/Block/Block.dart';
import 'package:company_task/Utli/Common.dart';
import 'package:company_task/models/User.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  User _user = User();

  Bloc bloc = Bloc();





  loginn(BuildContext context) async{

    _user.email = emailController.text;
    _user.password =passwordController.text;




  }
}