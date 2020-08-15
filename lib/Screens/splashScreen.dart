import 'package:company_task/Block/Block.dart';
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
  Bloc bloc = Bloc();
  Bloc _bloc;

  open(){
             bloc.getNewsOnSearchBar(context);
      Provider.of<InfoProvider>(context).fetch();
    Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (BuildContext context) => HomePage()) );
  }
  @override
  void initState() {
    // TODO: implement initState
    Bloc();
    _bloc = Bloc();
    _bloc.getNewsOnSearchBar(context);
    _bloc.fetchChatRoom(context);

    super.initState();
    Timer(Duration(seconds: 3),()=> open());
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
