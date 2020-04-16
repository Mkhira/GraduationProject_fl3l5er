import 'package:company_task/Block/Block.dart';
import 'package:company_task/wedgit/rigisterWedgit.dart';
import 'package:flutter/material.dart';
import '../style/conist.dart';
import '../wedgit/textFeild.dart';
import 'package:provider/provider.dart';
import '../provider/taskData.dart';
import '../wedgit/rigisterWedgit.dart';
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc =Bloc();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 810,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.1, 0.4, 0.7, 1],
                    colors: [secodcolor, Colors.blue, Colors.orange, maincolor
            ], tileMode: TileMode.mirror)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 2,
                ),
                Container(
                  height: 150,
                  width: 200,
                  child: Hero(
                      tag: "splash",
                      child: Image(
                        image: AssetImage("assets/splash.png"),
                        fit: BoxFit.cover,
                      )),
                ),
                Spacer(
                  flex: 1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child:  emailField(bloc),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: passwordField(bloc),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text("Forget Password",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),
//                      Spacer(),
                      MaterialButton(
                        onPressed: (){
                          Provider.of<TaskData>(context).login(context);
                        },
                        height: 50,
                        minWidth: 80,
                        elevation: 5,
                        splashColor: Colors.lightBlueAccent,

                        shape: RoundedRectangleBorder(
                          side:
                          BorderSide(width: 3,color: Colors.lightBlueAccent,style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(30),),),
                        color: Colors.white,
                        child: Icon(Icons.arrow_forward,size: 30,),

                      ),
                    ],
                  ),
                ),
                Spacer(flex: 1,),
                GestureDetector(

                  onTap: (){
                    Provider.of<TaskData>(context).rgister(context);
                  },
                    child: Container(
                      height: 60,
                      child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Text("Rigister Blood Dontion!",style: TextStyle(fontWeight: FontWeight.w400),),

                  ],
                ),
                    )),

                Spacer(
                  flex: 3,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
