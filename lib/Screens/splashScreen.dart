import 'package:flutter/material.dart';
import 'dart:async';
import '../style/conist.dart';
import 'Login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 7),()=> Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (BuildContext context) => Login())) );
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit:StackFit.expand ,
        children: <Widget>[
          Container(
            color: maincolor,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 200,
                        width: 250,
                        child: Hero(
                            tag: "splash",
                            child: Image(image: AssetImage("assets/splash.png"),fit: BoxFit.cover,)),
                      ),
                      SizedBox(height: 20,),
                      Text("Blood Donation",style: TextStyle(color: secodcolor,fontWeight: FontWeight.bold,fontSize: 20),),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(backgroundColor: secodcolor),

                    SizedBox(height: 15,),
                    Text("It will take less than minunt...",style: TextStyle(color: secodcolor,fontWeight: FontWeight.bold,fontSize: 15),)
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
