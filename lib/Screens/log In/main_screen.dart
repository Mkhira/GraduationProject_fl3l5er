import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class Main_screen extends StatefulWidget {
  static const  id='main_screen';
  @override
  _Main_screenState createState() => _Main_screenState();
}

class _Main_screenState extends State<Main_screen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LogIn(),
    );
  }
}
