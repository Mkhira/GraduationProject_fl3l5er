


import 'package:shared_preferences/shared_preferences.dart';

class Common{

  static final String userId ='token';


  static getToken() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String token = _prefs.getString(Common.userId) ?? '';

    return token;
  }

}