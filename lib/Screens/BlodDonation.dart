import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../style/constent.dart';
import '../wedgit/headersWedgit.dart';
import '../wedgit/caruselWedgit.dart';
import '../wedgit/bloodWedgit.dart';

class BloodDonation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kMainColor,
      body: SingleChildScrollView(
        child: Container(
          height: 1000,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 280,
                left: 0,
                child: Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: BloodListBuilder(),
                  ),
                ),
              ),
              topHeader(),
              Positioned(
                bottom: 280,
                left: 20,
                child: Text(
                  "Blood Donation Events",
                  style: kTitleHeader,
                ),
              ),
              Positioned(
                bottom: -20,
                left: 0,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child:
                       caruselBuilder()
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

