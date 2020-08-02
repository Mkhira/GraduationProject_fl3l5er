import 'package:company_task/style/constent.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

import 'stepper_screen.dart';

class MyStepper extends StatefulWidget {
  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height+200,
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 4,
                      color: kSecondColor,

                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0,right: 65.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 32.0,
                            ),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: ()=>Navigator.pop(context),
                          ),
                          Text(
                            "انشاء حساب جديد",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontFamily: ArabicFonts.Amiri,package: 'google_fonts_arabic',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top:80,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: Container(
                          height: 900,
                          width: width,
                          child: StepperScreen(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

