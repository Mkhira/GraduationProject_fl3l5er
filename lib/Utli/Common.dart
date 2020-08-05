


import 'package:shared_preferences/shared_preferences.dart';

class Common{

  static final String userId ='token';
  static final String email ='email';
  static final String gander ='gander';
  static final String password ='password';
  static final String image ='image';
  static final String nationalId ='nationlaId';
  static final String jop ='jop';
  static final String location ='location';
  static final String state ='state';
  static final String phone ='phone';
  static final String name ='name';


  static getUserIdToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userIdToken = _prefs.getString(Common.userId) ?? '';

    return userIdToken;
  }


  static getUserEmailToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userEmailToken = _prefs.getString(Common.email) ?? '';

    return userEmailToken;
  }
  static getUserGanderToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userGanderToken = _prefs.getString(Common.gander) ?? '';

    return userGanderToken;
  }
  static getUserPasswordToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userPasswordToken = _prefs.getString(Common.password) ?? '';

    return userPasswordToken;
  }
  static getUserImageToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userImageToken = _prefs.getString(Common.image) ?? '';

    return userImageToken;
  }
  static getUserNationalIdToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userNationalIdToken = _prefs.getString(Common.nationalId) ?? '';

    return userNationalIdToken;
  }
  static getUserJopToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userJopToken = _prefs.getString(Common.jop) ?? '';

    return userJopToken;
  }
  static getUserLocationToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userLocationToken = _prefs.getString(Common.location) ?? '';

    return userLocationToken;
  }
  static getUserStateToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userStateToken = _prefs.getString(Common.state) ?? '';

    return userStateToken;
  }

  static getUserPhoneToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userPhoneToken = _prefs.getString(Common.phone) ?? '';

    return userPhoneToken;
  }

  static getUserNameToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String userNameToken = _prefs.getString(Common.name) ?? '';

    return userNameToken;
  }

}