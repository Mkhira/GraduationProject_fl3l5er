import 'dart:async';

import 'package:company_task/Screens/LoginScreen/LoginMainScreen.dart';
import 'package:company_task/style/constent.dart';
import 'package:flutter/material.dart';




class CustomSplashwidget extends StatefulWidget {
  @override
  _CustomSplashwidgetState createState() => _CustomSplashwidgetState();
}


class _CustomSplashwidgetState extends State<CustomSplashwidget> {
  @override
  void initState() {
    // TODO: implement initState
        Timer(Duration(seconds: 1),()=> LoginMainScreen());

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit:StackFit.expand ,
        children: <Widget>[
          Container(
            color: kMainColor,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: 250,
                          width: 250,
                          child: Hero(
                              tag: "splash",
                              child: Image(image: AssetImage("assets/logo.png"),fit: BoxFit.contain,)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      backgroundColor: kSecondColor,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),

                    SizedBox(height: 30,),
                    Text(" ..... اهلا بك جارى تحميل البيانات",style: TextStyle(color: kSecondColor,fontWeight: FontWeight.bold,fontSize: 15),)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
