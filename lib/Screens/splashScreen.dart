import 'package:company_task/Screens/homePage.dart';
import 'package:company_task/provider/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../style/constent.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  open(){
      Provider.of<InfoProvider>(context).fetch();
    Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (BuildContext context) => HomePage()) );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 7),()=> open());
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
                      Text("Blood Donation",style: TextStyle(color: kSecondColor,fontWeight: FontWeight.bold,fontSize: 20),),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(backgroundColor: kSecondColor),

                    SizedBox(height: 15,),
                    Text("It will take less than minunt...",style: TextStyle(color: kSecondColor,fontWeight: FontWeight.bold,fontSize: 15),)
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
