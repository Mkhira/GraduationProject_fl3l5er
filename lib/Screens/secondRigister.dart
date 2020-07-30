import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../style/constent.dart';
import '../Block/Block.dart';
import '../provider/info_provider.dart';
import 'package:provider/provider.dart';
import '../wedgit/rigisterContainers.dart';

class secondRegister extends StatelessWidget {
  static const String id = "register";
  @override
  Widget build(BuildContext context) {
    final bloc = Bloc();

    return SafeArea(
        child: Scaffold(
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: Container(
          height: 2300,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 1,),
                Container(
                  width: 200,
                  height: 150,
                  child: Hero(
                      tag: "splash",
                      child: Image(
                        image: AssetImage("assets/splash.png"),
                        fit: BoxFit.cover,
                      )),
                ),
                Spacer(flex: 1,),
                Text(
                  "Blood Donation",
                  style: TextStyle(
                      color: kSecondColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Spacer(flex: 1,),

////////////////Email
                EmailContainer(bloc: bloc),

                Spacer(flex: 1,),

                ///////////////////password
                PasswordContainer(bloc: bloc),

                Spacer(flex: 1,),
//////////////////////////maretal
              Text("Not necessary data for register",style: bigHeadLine,),
                SizedBox(height: 30,),
                maritalStatusContainer(bloc: bloc),

                Spacer(flex: 1,),////////////////// jop
                jopContainer(bloc: bloc),
                Spacer(flex: 1,),
/////////////////// location
                LocationContiner(bloc: bloc),

                Spacer(flex: 1,),////////////////// jop

                MaterialButton(
                  onPressed: () {
                    bloc.createProfileData(context);
                  },
                  height: 60,
                  minWidth: 150,
                  elevation: 5,
                  splashColor: Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 3,
                        color: Colors.lightBlueAccent,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  color: Colors.white,
                  child: Text("Supmit"),
                ),

                Spacer(flex: 2,),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

