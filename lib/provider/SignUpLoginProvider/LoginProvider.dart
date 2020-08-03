



import 'package:company_task/models/User.dart';
import 'package:flutter/cupertino.dart';

class LoginProvider extends ChangeNotifier{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  User _user = User();
  loginn(){

    _user.email = emailController.text;
    _user.password =passwordController.text;
  }
}