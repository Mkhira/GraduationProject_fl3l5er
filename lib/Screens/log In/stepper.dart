import 'package:flutter/material.dart';

import 'stepper_screen.dart';

class MyStepper extends StatefulWidget {
  @override
  _MyStepperState createState() => _MyStepperState();
}

class _MyStepperState extends State<MyStepper> {
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;

    return Scaffold(
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
                    height: MediaQuery.of(context).size.height / 3,
                    color: Colors.orange,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0,right: 30.0),
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
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top:MediaQuery.of(context).size.height/3-120,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Container(
                        height: 1000,
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
    );
  }
}

